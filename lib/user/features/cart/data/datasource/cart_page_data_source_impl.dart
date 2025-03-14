
// class CartPageDataSourceImpl extends CartPageDataSource {
//   final DataSource dataSource;
//   final FirebaseFirestore firebaseFirestore;
//   // final FirebaseStorage firebaseStorage;
//   CartPageDataSourceImpl({
//     required this.dataSource,
//     required this.firebaseFirestore,
//     // required this.firebaseStorage
//   });
//   @override
//   Future<List<ProductModel>> getAllProducts() async {
//     try {
//       final allCartedProducts = await dataSource.getAllCart();
//       // print(allCartedProducts);
//       final allProducts = await dataSource.getAllProduct();
//       List<ProductModel> filteredProducts = getAllProductsThatIsCarted(
//           products: allProducts, cartModels: allCartedProducts);
//       // print(filteredProducts);
//       return filteredProducts;
//     } catch (e) {
//       throw ServerException(e.toString());
//     }
//   }

//   @override
//   Future<List<BannerModel>> getAllBanners() async {
//     try {
//       QuerySnapshot<Map<String, dynamic>> bannerSnapshot =
//           await firebaseFirestore.collection('banners').get();

//       List<BannerModel> listOfBannerModel = [];
//       for (var doc in bannerSnapshot.docs) {
//         listOfBannerModel.add(BannerModel.fromJson(doc.data()));
//       }
//       return listOfBannerModel;
//     } catch (e) {
//       throw ServerException(e.toString());
//     }
//   }

//   @override
//   Future<bool> updateProductToFavorite(
//       {required bool isFavorited, required Product product}) async {
//     try {
//       await dataSource.updateProductToFavorite(
//         isFavorited: isFavorited,
//         product: product,
//       );
//       return true;
//     } catch (e) {
//       throw ServerException(e.toString());
//     }
//   }

//   // @override
//   // Future<List<String>> getAllFavoritedProducts() async {
//   //   try {
//   //     return await dataSource.getAllFavoriteProduct();
//   //     // return true;
//   //   } catch (e) {
//   //     throw ServerException(e.toString());
//   //   }
//   // }

//   // @override
//   // Future<List<CartModel>> updateProductToCart(
//   //     {required int itemCount,
//   //     required Product product,
//   //     required Cart? cart}) async {
//   //   try {
//   //     return await dataSource.updateProductToCart(
//   //         itemCount: itemCount, product: product, cart: cart);
//   //   } catch (e) {
//   //     throw ServerException(e.toString());
//   //   }
//   // }

//   @override
//   Future<List<CartModel>> getAllCart() async {
//     try {
//       return await dataSource.getAllCart();
//     } catch (e) {
//       throw ServerException(e.toString());
//     }
//   }
  
//   @override
//   Future<List<Cart>> updateProductToCart({required int itemCount, required Product product, required Cart? cart}) {
//     // TODO: implement updateProductToCart
//     throw UnimplementedError();
//   }
// }


