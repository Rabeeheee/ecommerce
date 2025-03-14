
// class UpdateProductToFavoriteCartPage
//     implements UseCase<bool, UpdateProductToFavoriteCartPageParams> {
//   final CartPageRepository cartPageRepository;
//   UpdateProductToFavoriteCartPage({required this.cartPageRepository});

//   @override
//   Future<Either<Failure, bool>> call(
//       UpdateProductToFavoriteCartPageParams params) async {
//     return await cartPageRepository.updateProductToFavorite(isFavorited: params.isFavorited, product: params.product);
//   }
// }

// class UpdateProductToFavoriteCartPageParams {
//   final bool isFavorited;
//   final Product product;

//   UpdateProductToFavoriteCartPageParams(
//       {required this.isFavorited, required this.product});
// }
