
// class UpdateProductToCartHomePage
//     implements UseCase<List<Cart>, UpdateProductToCartHomePageParams> {
//   final HomePageRepository homePageRepository;
//   UpdateProductToCartHomePage({required this.homePageRepository});

//   @override
//   Future<Either<Failure, List<Cart>>> call(
//       UpdateProductToCartHomePageParams params) async {
//     return await homePageRepository.updateProductToCart(itemCount: params.itemCount, product: params.product,cart: params.cart);
//   }
// }

// class UpdateProductToCartHomePageParams {
//   final int itemCount;
//   final Product product;
//   final Cart? cart;
//   UpdateProductToCartHomePageParams(
//       {required this.itemCount, required this.product,required this.cart,});
// }
