import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tech_haven/core/common/data/datasource/data_source.dart';
import 'package:tech_haven/core/common/data/model/image_model.dart';
import 'package:tech_haven/core/common/data/model/location_model.dart';
import 'package:tech_haven/core/common/data/model/order_model.dart';
import 'package:tech_haven/core/common/data/model/product_model.dart';
import 'package:tech_haven/core/common/data/model/product_review_model.dart';
import 'package:tech_haven/core/common/data/model/review_model.dart';
import 'package:tech_haven/core/common/data/model/user_model.dart' as model;
import 'package:tech_haven/core/common/data/model/user_model.dart';
import 'package:tech_haven/core/entities/cart.dart';
import 'package:tech_haven/core/entities/image.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/entities/review.dart';
import 'package:tech_haven/core/error/exceptions.dart';
import 'package:tech_haven/core/common/data/model/category_model.dart';
import 'package:tech_haven/user/features/home/data/models/cart_model.dart';
import 'package:tech_haven/vendor/features/registervendor/data/models/vendor_model.dart';
import 'package:uuid/uuid.dart';
// import 'package:tech_haven/user/features/auth/data/models/user_model.dart';
// import 'package:tech_haven/core/models/category.dart';

class DataSourceImpl implements DataSource {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth;
  DataSourceImpl({
    required this.firebaseFirestore,
    required this.firebaseAuth,
  });

  List<CategoryModel> mainCategories = [];

  @override
  Future<String> updateProductFields(
      String productID, Map<String, dynamic> updates) async {
    try {
      final DocumentReference productDocRef =
          FirebaseFirestore.instance.collection('products').doc(productID);

      await productDocRef.update(updates);

      return 'Success';
    } catch (e) {
      throw ServerException('Failed to update product: $e');
    }
  }

  @override
  Future<void> addReview(
      {required Product product,
      required List<Review> listOfReview,
      required String userReview,
      required double userRating}) async {
    try {
      final model.UserModel? user = await getUserData();

      if (user != null) {
        final String reviewID = const Uuid().v1();
        final DateTime dateTime = DateTime.now();

        final currentRating = product.rating ?? 0;
        final totalReviews = listOfReview.length;

        // Calculate new average rating
        final newTotalReviews = totalReviews + 1;
        final newRating =
            ((currentRating * totalReviews) + userRating) / newTotalReviews;

        // Update product review count and rating
        // product.totalReviews = newTotalReviews;
        // product.rating = newRating;
        // Calculate new average rating

        final ProductReviewModel productReviewModel = ProductReviewModel(
          productID: product.productID,
          productName: product.name,
          // totalReviews: 0,f
          vendorID: product.vendorID,
          vendorName: product.vendorName,
          // totalRating: 0
        );
        final ReviewModel reviewModel = ReviewModel(
            productID: product.productID,
            reviewID: reviewID,
            userProfile:
                user.isProfilePhotoUploaded ? user.profilePhoto! : null,
            userReview: userReview,
            listOfHelpFulUsers: [],
            userName: user.username!,
            dateTime: dateTime,
            userID: user.uid!,
            userRating: userRating);
        await firebaseFirestore
            .collection('products')
            .doc(product.productID)
            .update({'rating': newRating});
        await firebaseFirestore
            .collection('reviews')
            .doc(product.productID)
            .set(productReviewModel.toJson());
        await firebaseFirestore
            .collection('reviews')
            .doc(product.productID)
            .collection('reviewDetails')
            .doc(reviewID)
            .set(reviewModel.toJson());
      }
    } catch (e) {
      throw Exception('Failed to add review: $e');
    }
  }

// Fetch sub-subcollection data
  Future<List<DocumentSnapshot>> fetchSubsubcollectionData(
      DocumentReference subDocRef) async {
    var subsubcollectionSnapshot =
        await subDocRef.collection('variantCategories').get();
    return subsubcollectionSnapshot.docs;
  }

  @override
  Future<model.UserModel?> getUserData() async {
    model.UserModel? userModel;
    try {
      // Get current user
      final User? user = firebaseAuth.currentUser;

      if (user != null) {
        // Query Firestore for user document with current user ID
        DocumentSnapshot userSnapshot =
            await firebaseFirestore.collection('users').doc(user.uid).get();

        // Check if user document exists
        if (userSnapshot.exists) {
          // Convert document data to UserModel
          userModel = model.UserModel.fromJson(
              userSnapshot.data() as Map<String, dynamic>);
        }
      }
      return userModel;
    } catch (e) {
      throw ServerException(e.toString()); // Return null in case of error
    }
  }

    @override
  Future<List<CategoryModel>> getAllBrands() async {
    try {
      final allBrands = await firebaseFirestore.collection('brand').get();
      List<CategoryModel> listOfBrandModels = [];
      for (var brand in allBrands.docs) {
        listOfBrandModels.add(CategoryModel.fromJson(brand.data()));
      }
      return listOfBrandModels;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<CategoryModel>> getAllCategory(bool refresh) async {
    if (mainCategories.isNotEmpty && !refresh) {
      return mainCategories;
    }
    mainCategories.clear();
    try {
      final mainSnapshot =
          await firebaseFirestore.collection('categories').get();
      for (var mainCategoryDoc in mainSnapshot.docs) {
        List<CategoryModel> subcategories = [];
        var mainDocumentData = mainCategoryDoc.data();
        CategoryModel mainCategory = CategoryModel.fromJson(mainDocumentData);
        //list of mainCategories

        //[mainCategory]
        mainCategories.add(mainCategory); //one category is added.
        final subSnapshotDocs =
            await fetchSubcollectionData(mainCategoryDoc.reference);

        for (var subCategoryDoc in subSnapshotDocs) {
          List<CategoryModel> variants = [];
          var subDocumentData = subCategoryDoc.data() as Map<String, dynamic>;
          CategoryModel subCategory = CategoryModel.fromJson(subDocumentData);
          // print(subCategory.categoryName);
          subcategories.add(subCategory); //one category is added
          final variantSnapshotDocs =
              await fetchSubsubcollectionData(subCategoryDoc.reference);

          for (var variantCategoryDoc in variantSnapshotDocs) {
            var variantDocumentData =
                variantCategoryDoc.data() as Map<String, dynamic>;
            CategoryModel variantCategory =
                CategoryModel.fromJson(variantDocumentData);
            variants.add(
                variantCategory); //one category is added if there is only one variant category it goes outside of loop.
          }
          subCategory.subCategories =
              variants; //variants have only one category model in it.
        }
        mainCategory.subCategories = subcategories;
      }

      return mainCategories.reversed.toList();
    } on FirebaseException catch (e) {
      throw ServerException(e.toString());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  Future<List<DocumentSnapshot>> fetchSubcollectionData(
      DocumentReference mainDocRef) async {
    var subcollectionSnapshot =
        await mainDocRef.collection('subCategories').get();
    return subcollectionSnapshot.docs;
  }

  @override
  Future<List<ProductModel>> getAllProduct() async {
    try {
      QuerySnapshot productSnapshot =
          await firebaseFirestore.collection('products').get();
      // print(productSnapshot.docs[0].data());
      List<ProductModel> products = [];
      for (var doc in productSnapshot.docs) {
        products.add(ProductModel.fromJson(doc.data() as Map<String, dynamic>));
      }
      // print(products[0].oldPrize);
      return products;
    } catch (e) {
      // print(e.toString());
      throw ServerException(e.toString());
    }
  }

  @override
  Future<bool> updateProductToFavorite(
      {required bool isFavorited, required Product product}) async {
    try {
      final userData = await getUserData();
      if (userData != null) {
        DocumentSnapshot snapshot = await firebaseFirestore
            .collection('favorite')
            .doc(userData.uid)
            .get();
        //there is no data and want to create new and add the favorite
        if (!snapshot.exists && isFavorited) {
          await firebaseFirestore.collection('favorite').doc(userData.uid).set({
            'listOfProducts': [product.productID],
          });
          //there is data and want to update the the list by adding new value
        } else if (snapshot.exists && isFavorited) {
          await firebaseFirestore
              .collection('favorite')
              .doc(userData.uid)
              .update({
            'listOfProducts': FieldValue.arrayUnion([product.productID]),
          });
          //delete the favorited from the existed data.
        } else if (!isFavorited && snapshot.exists) {
          await firebaseFirestore
              .collection('favorite')
              .doc(userData.uid)
              .update(
            {
              'listOfProducts': FieldValue.arrayRemove(
                [product.productID],
              ),
            },
          );
        }
      }
      return true;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<String>> getAllFavorite() async {
    try {
      // print('updating the favorite');
      List<String> listOfFavoritedProduct = [];
      final userData = await getUserData();
      if (userData != null) {
        final DocumentSnapshot<Map<String, dynamic>> snapshot =
            await firebaseFirestore
                .collection('favorite')
                .doc(userData.uid)
                .get();
        if (snapshot.exists && snapshot.data() != null) {
          listOfFavoritedProduct =
              List<String>.from(snapshot.data()!['listOfProducts']);
          // print(listOfFavoritedProduct.first);
        }
      }
      return listOfFavoritedProduct;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<CartModel>> getAllCart() async {
    try {
      List<CartModel> carts = [];
      final user = await getUserData();
      if (user != null) {
        final QuerySnapshot<Map<String, dynamic>> snapshot =
            await firebaseFirestore
                .collection('carts')
                .doc(user.uid)
                .collection('cart')
                .get();

        for (var document in snapshot.docs) {
          carts.add(CartModel.fromJson(document.data()));
        }
      }
      return carts;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<bool> updateProductToCart(
      {required int itemCount,
      required Product product,
      required Cart? cart}) async {
    try {
      final user = await getUserData();
      if (user != null) {
        if (cart != null && itemCount != 0) {
          //for updation
          final cartModel = CartModel(
            cartID: cart.cartID,
            productID: product.productID,
            productCount: itemCount, color: 0,
          );
          await firebaseFirestore
              .collection('carts')
              .doc(user.uid)
              .collection('cart')
              .doc(cart.cartID)
              .update(cartModel.toJson());
        } else if (cart == null && itemCount != 0) {
          //for creation
          String cartID = const Uuid().v1();
          final cartModel = CartModel(
            cartID: cartID,
            productID: product.productID,
            productCount: itemCount, color: 0,
          );
          await firebaseFirestore
              .collection('carts')
              .doc(user.uid)
              .collection('cart')
              .doc(cartID)
              .set(cartModel.toJson());
        } else if (cart != null && itemCount == 0) {
          //for deletion of the data from the firebase
          await firebaseFirestore
              .collection('carts')
              .doc(user.uid)
              .collection('cart')
              .doc(cart.cartID)
              .delete();
        }
      } else {
        throw const ServerException('Unexpected Error Occured');
      }
      return true;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<CategoryModel>> getAllSubCategory() async {
    try {
      List<CategoryModel> subcategories = [];
      final mainSnapshot =
          await firebaseFirestore.collection('categories').get();
      for (var mainCategoryDoc in mainSnapshot.docs) {
        final subSnapshotDocs =
            await fetchSubcollectionData(mainCategoryDoc.reference);
        for (var subCategoryDoc in subSnapshotDocs) {
          var subDocumentData = subCategoryDoc.data() as Map<String, dynamic>;
          CategoryModel subCategory = CategoryModel.fromJson(subDocumentData);
          subcategories.add(subCategory);
        }
      }

      return subcategories;
    } on FirebaseException catch (e) {
      throw ServerException(e.toString());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<ProductModel>> getAllCartProduct() async {
    try {
      List<ProductModel> allProduct = await getAllProduct();
      List<CartModel> allCart = await getAllCart();

      List<ProductModel> filteredList =
          getAllProductsThatIsCarted(products: allProduct, cartModels: allCart);

      return filteredList;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<ProductModel>> getAllFavoriteProduct() async {
    try {
      List<ProductModel> allProduct = await getAllProduct();
      List<String> allFavorite = await getAllFavorite();

      List<ProductModel> filteredList = getAllProductsThatIsFavorited(
          products: allProduct, favoritedModels: allFavorite);

      return filteredList;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<Map<int, List<Image>>> getImagesForProduct(
      {required String productID}) async {
    try {
      Map<int, List<ImageModel>> resultMap = {};

      // Retrieve the document containing the image map
      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await firebaseFirestore
              .collection('products')
              .doc(productID)
              .collection('images')
              .get();
      int count = 0;
      for (var document in snapshot.docs) {
        Map<String, dynamic> mapOfImages = document.data();
        mapOfImages.forEach((key, value) {
          if (resultMap.containsKey(count)) {
            resultMap[count]!.add(ImageModel(imageID: key, imageURL: value));
          } else {
            resultMap[count] = [ImageModel(imageID: key, imageURL: value)];
          }
        });
        count++;
      }

      return resultMap;
    } on ServerException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<ProductModel>> getAllBrandRelatedProduct(
      {required Product product}) async {
    try {
      final products = await getAllProduct();
      List<ProductModel> brandedModels = filterAllRelatedBrandProducts(
          products: products, brandID: product.brandID);
      return brandedModels;
    } catch (e) {
      // print(e.toString());
      throw ServerException(e.toString());
    }
  }

  @override
  Future<bool> updateLocation(
      {required String name,
      required String phoneNumber,
      required String location,
      required String apartmentHouseNumber,
      required String emailAddress,
      required String addressInstructions}) async {
    try {
      final model.UserModel? user = await getUserData();
      if (user != null) {
        final String uid = const Uuid().v1();
        LocationModel locationModel = LocationModel(
            userID: user.uid!,
            uid: uid,
            name: name,
            phoneNumber: phoneNumber,
            location: location,
            apartmentHouseNumber: apartmentHouseNumber,
            emailAddress: emailAddress,
            addressInstructions: addressInstructions);
        await firebaseFirestore
            .collection('locations')
            .doc(user.uid)
            .set(locationModel.toJson());
      }

      return true;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<LocationModel?> getCurrentLocationDetails() async {
    LocationModel? locationModel;
    try {
      final model.UserModel? user = await getUserData();

      if (user != null) {
        // print(user.username);
        final snapshot =
            await firebaseFirestore.collection('locations').doc(user.uid).get();
        // print(user.username);
        // print(snapshot.exists);
        if (snapshot.exists) {
          locationModel =
              LocationModel.fromJson(snapshot.data() as Map<String, dynamic>);
        } else {
          // print(user.username);
          throw Exception('Please Enter The Neccesary Details');
        }
      }
      return locationModel;
    } on TypeError catch (_) {
      throw const ServerException('No Location Added Yet');
    } catch (e) {
      // print(e.toString());
      throw ServerException(e.toString());
    }
  }

  @override
  Future<VendorModel?> getVendorData({required String vendorID}) async {
    try {
      // print('object');
      DocumentSnapshot docSnapshot =
          await firebaseFirestore.collection('vendors').doc(vendorID).get();
      if (docSnapshot.exists) {
        final VendorModel vendorModel =
            VendorModel.fromJson(docSnapshot.data() as Map<String, dynamic>);
        // print(vendorModel.accountNumber);
        // print(vendorModel.email);
        return vendorModel;
      } else {
        throw const ServerException('Request for Vendor Mode');
      }
    } on ServerException catch (e) {
      throw ServerException(e.toString());
    } catch (e) {
      // print(e.toString());
      throw ServerException(e.toString());
    }
    // return null;
  }

  @override
  Future<ProductModel> getAProduct({required String productID}) async {
    try {
      DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
          .collection('products')
          .doc(productID)
          .get();

      if (docSnapshot.exists) {
        return ProductModel.fromJson(
            docSnapshot.data() as Map<String, dynamic>);
      } else {
        throw const ServerException('No Prducts Exists');
      }
    } catch (e) {
      throw ServerException('Error getting product: $e');
    }
  }

  @override
  Future<List<OrderModel>> getAllOrders() async {
    try {
      final UserModel? user = await getUserData();
      List<OrderModel> listOfOrderModel = [];
      if (user != null) {
        // Fetching snapshots of the order details collection for the user
        QuerySnapshot<Map<String, dynamic>> snapshots = await FirebaseFirestore
            .instance
            .collection('userOrders')
            .doc(user.uid)
            .collection('orderDetails')
            .get();
        // Mapping each document to an OrderModel instance
        for (var doc in snapshots.docs) {
          listOfOrderModel.add(OrderModel.fromJson(doc.data()));
        }
      }
      return listOfOrderModel;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<OrderModel>> getVendorOrders() async {
    try {
      final UserModel? user = await getUserData();
      if (user == null) {
        throw const ServerException("User or vendor ID is null");
      }

      List<OrderModel> listOfVendorOrderModel = [];

      // Fetching snapshots of the order details collection for the given vendor
      QuerySnapshot<Map<String, dynamic>> orderDetailsSnapshot =
          await FirebaseFirestore.instance
              .collection('vendorOrders')
              .doc(user.vendorID)
              .collection('orderDetails')
              .get();
      // Mapping each document to an OrderModel instance
      for (var doc in orderDetailsSnapshot.docs) {
        listOfVendorOrderModel.add(OrderModel.fromJson(doc.data()));
      }

      return listOfVendorOrderModel;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<String>> getUserOwnedProducts() async {
    try {
      UserModel? user = await getUserData();
      if (user != null) {
        DocumentSnapshot docSnapshot = await firebaseFirestore
            .collection('userOwnedProducts')
            .doc(user.uid)
            .get();

        if (docSnapshot.exists && docSnapshot.data() != null) {
          var data = docSnapshot.data() as Map<String, dynamic>;
          if (data['listOfProducts'] != null) {
            return List<String>.from(data['listOfProducts']);
          }
        }
      } else {
        throw const ServerException('User Not Found, Please try again later');
      }
      return [];
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
  // @override
  // Future<List<OrderModel>> getPaymentModels() async {
  //   try {
  //     final UserModel? user = await getUserData();
  //     if (user == null) {
  //       throw const ServerException("User or user ID is null");
  //     }

  //     List<OrderModel> listOfuserOrderModel = [];

  //     print('Fetching user orders...');
  //     // Fetching snapshots of the order details collection for the given user
  //     QuerySnapshot<Map<String, dynamic>> orderDetailsSnapshot =
  //         await FirebaseFirestore.instance
  //             .collection('userOrders')
  //             .doc(user.uid)
  //             .collection('orderDetails')
  //             .get();
  //     print('Fetched user orders, processing...');
  //     // Mapping each document to an OrderModel instance
  //     for (var doc in orderDetailsSnapshot.docs) {
  //       print(doc.data());
  //       listOfuserOrderModel.add(OrderModel.fromJson(doc.data()));
  //     }
  //     print('user orders processing completed.');

  //     return listOfuserOrderModel;
  //   } catch (e) {
  //     throw ServerException(e.toString());
  //   }
  // }

  // @override
  // Future<List<OrderModel>> getUserOrders() async {
  //   try {
  //     final UserModel? user = await getUserData();
  //     if (user == null ) {
  //       throw const ServerException("User or user ID is null");
  //     }

  //     List<OrderModel> listOfuserOrderModel = [];

  //     print('Fetching user orders...');
  //     // Fetching snapshots of the order details collection for the given user
  //     QuerySnapshot<Map<String, dynamic>> orderDetailsSnapshot =
  //         await FirebaseFirestore.instance
  //             .collection('userOrders')
  //             .doc(user.uid)
  //             .collection('orderDetails')
  //             .get();
  //     print('Fetched user orders, processing...');
  //     // Mapping each document to an OrderModel instance
  //     for (var doc in orderDetailsSnapshot.docs) {
  //       print(doc.data());
  //       listOfuserOrderModel.add(OrderModel.fromJson(doc.data()));
  //     }
  //     print('user orders processing completed.');

  //     return listOfuserOrderModel;
  //   } catch (e) {
  //     throw ServerException(e.toString());
  //   }
  // }

  List<ProductModel> getAllProductsThatIsCarted({
    required List<ProductModel> products,
    required List<CartModel> cartModels,
  }) {
    List<ProductModel> filteredList = [];
    for (var product in products) {
      for (var cart in cartModels) {
        if (product.productID == cart.productID) {
          filteredList.add(product);
        }
      }
    }
    return filteredList;
  }

  List<ProductModel> getAllProductsThatIsFavorited({
    required List<ProductModel> products,
    required List<String> favoritedModels,
  }) {
    List<ProductModel> filteredList = [];
    for (var product in products) {
      for (var favorited in favoritedModels) {
        if (product.productID == favorited) {
          filteredList.add(product);
        }
      }
    }
    return filteredList;
  }

  List<ProductModel> filterAllRelatedBrandProducts(
      {required List<ProductModel> products, required String brandID}) {
    List<ProductModel> listOfBrandModels = [];
    for (var product in products) {
      if (product.brandID == brandID) {
        listOfBrandModels.add(product);
      }
    }
    return listOfBrandModels;
  }

  @override
  Future<ProductReviewModel> getProductReviewModel(
      {required String productID}) async {
    try {
      ProductReviewModel? productReviewModel;
      final snapshot =
          await firebaseFirestore.collection('reviews').doc(productID).get();
      if (snapshot.exists) {
        productReviewModel = ProductReviewModel.fromJson(
            snapshot.data() as Map<String, dynamic>);
      } else {
        throw Exception("The Review for this product Doesn't Exist");
      }
      return productReviewModel;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<ReviewModel>> getAllReviewsProduct(
      {required String productID}) async {
    try {
      final querySnapshot = await firebaseFirestore
          .collection('reviews')
          .doc(productID)
          .collection('reviewDetails')
          .get();

      if (querySnapshot.docs.isEmpty) {
        return [];
      }

      final reviews = querySnapshot.docs.map((doc) {
        return ReviewModel.fromJson(doc.data());
      }).toList();

      return reviews;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
