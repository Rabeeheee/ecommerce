
import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/common/data/datasource/data_source.dart';
import 'package:tech_haven/core/common/data/model/category_model.dart';
import 'package:tech_haven/core/common/data/model/location_model.dart';
import 'package:tech_haven/core/common/data/model/order_model.dart';
import 'package:tech_haven/core/common/data/model/product_model.dart';
import 'package:tech_haven/core/common/data/model/product_review_model.dart';
import 'package:tech_haven/core/common/data/model/user_model.dart';
import 'package:tech_haven/core/common/domain/repository/repository.dart';
import 'package:tech_haven/core/entities/cart.dart';
import 'package:tech_haven/core/entities/category.dart';
import 'package:tech_haven/core/entities/image.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/entities/review.dart';
import 'package:tech_haven/core/entities/vendor.dart';
import 'package:tech_haven/core/error/exceptions.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/user/features/home/data/models/cart_model.dart';

class RepositoryImpl implements Repository {
  final DataSource dataSource;
  RepositoryImpl({required this.dataSource});
  @override
  Future<Either<Failure, List<ProductModel>>> getAllCartProduct() async {
    try {
      final result = await dataSource.getAllCartProduct();
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<ProductModel>>> getAllFavoriteProduct() async {
    try {
      final result = await dataSource.getAllFavoriteProduct();
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<ProductModel>>> getAllProduct() async {
    try {
      final result = await dataSource.getAllProduct();
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> updateProductToCart(
      {required int itemCount,
      required Product product,
      required Cart? cart}) async {
    try {
      // print('updating the favorite');
      final result = await dataSource.updateProductToCart(
          itemCount: itemCount, product: product, cart: cart);
      // print('hello how are you');
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> updateProductToFavorite({
    required bool isFavorited,
    required Product product,
  }) async {
    try {
      final result = await dataSource.updateProductToFavorite(
          isFavorited: isFavorited, product: product);
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<CategoryModel>>> getAllCategory() async {
    try {
      final result = await dataSource.getAllCategory(false);
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<CartModel>>> getAllCart() async {
    try {
      // print('updating the favorite');
      final result = await dataSource.getAllCart();
      // print('hello how are you');
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getAllFavorite() async {
    try {
      // print('updating the favorite');
      final result = await dataSource.getAllFavorite();
      // print('hello how are you');
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getUserOwnedProducts() async {
    try {
      // print('updating the favorite');
      final result = await dataSource.getUserOwnedProducts();
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Map<int, List<Image>>>> getImagesForProduct(
      {required String productID}) async {
    try {
      // print('updating the favorite');
      final result = await dataSource.getImagesForProduct(productID: productID);
      // print('hello how are you');
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<ProductModel>>> getAllBrandRelatedProduct(
      {required Product product}) async {
    try {
      // print('updating the favorite');
      final result =
          await dataSource.getAllBrandRelatedProduct(product: product);
      // print('hello how are you');
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> updateLocation(
      {required String name,
      required String phoneNumber,
      required String location,
      required String apartmentHouseNumber,
      required String emailAddress,
      required String addressInstructions}) async {
    try {
      final result = await dataSource.updateLocation(
          name: name,
          phoneNumber: phoneNumber,
          location: location,
          apartmentHouseNumber: apartmentHouseNumber,
          emailAddress: emailAddress,
          addressInstructions: addressInstructions);
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, LocationModel?>> getCurrentLocationDetails() async {
    try {
      final result = await dataSource.getCurrentLocationDetails();
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, UserModel?>> getUserData() async {
    try {
      final result = await dataSource.getUserData();
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Vendor?>> getVendorData(
      {required String vendorID}) async {
    try {
      final result = await dataSource.getVendorData(vendorID: vendorID);
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> updateProductFields(
      {required String productID,
      required Map<String, dynamic> updates}) async {
    try {
      final result = await dataSource.updateProductFields(productID, updates);
      // print(result);
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, ProductModel>> getAProduct(
      {required String productID}) async {
    try {
      final result = await dataSource.getAProduct(productID: productID);
      // print(result);
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<OrderModel>>> getAllOrders() async {
    try {
      final result = await dataSource.getAllOrders();
      // print(result);
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<OrderModel>>> getVendorOrders() async {
    try {
      final result = await dataSource.getVendorOrders();
      // print(result);
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Review>>> getAllReviewsProduct(
      {required String productID}) async {
    try {
      final result =
          await dataSource.getAllReviewsProduct(productID: productID);
      // print(result);
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> addReview(
      {required Product product,
      required String userReview,
      required List<Review> listOfReviews,
      required double userRating}) async {
    try {
      final result = await dataSource.addReview(
        listOfReview: listOfReviews,
          product: product, userReview: userReview, userRating: userRating);
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, ProductReviewModel>> getProductReviewModel(
      {required String productID}) async {
    try {
      final result =
          await dataSource.getProductReviewModel(productID: productID);
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Category>>> getAllBrands()async {
    try {
      final result =
          await dataSource.getAllBrands();
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  //   @override
  // Future<Either<Failure, List<OrderModel>>> getUserOrders() async {
  //   try {
  //     final result = await dataSource.getAllOrders();
  //     // print(result);
  //     return right(result);
  //   } on ServerException catch (e) {
  //     return left(Failure(e.message));
  //   }
  // }
}
