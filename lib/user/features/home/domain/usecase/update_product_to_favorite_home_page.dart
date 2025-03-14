// import 'package:fpdart/fpdart.dart';
// import 'package:tech_haven/core/entities/product.dart';
// import 'package:tech_haven/core/error/failures.dart';
// import 'package:tech_haven/core/usecase/usecase.dart';
// import 'package:tech_haven/user/features/home/domain/repository/home_page_repository.dart';

// class UpdateProductToFavoriteHomePage
//     implements UseCase<bool, UpdateProductToFavoriteHomePageParams> {
//   final HomePageRepository homePageRepository;
//   UpdateProductToFavoriteHomePage({required this.homePageRepository});

//   @override
//   Future<Either<Failure, bool>> call(
//       UpdateProductToFavoriteHomePageParams params) async {
//     return await homePageRepository.updateProductToFavorite(isFavorited: params.isFavorited, product: params.product);
//   }
// }

// class UpdateProductToFavoriteHomePageParams {
//   final bool isFavorited;
//   final Product product;

//   UpdateProductToFavoriteHomePageParams(
//       {required this.isFavorited, required this.product});
// }
