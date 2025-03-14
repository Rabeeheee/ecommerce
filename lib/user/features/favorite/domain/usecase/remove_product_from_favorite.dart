import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/core/usecase/usecase.dart';
import 'package:tech_haven/user/features/favorite/domain/repository/favorite_page_repository.dart';

class RemoveProductFavorite implements UseCase<bool, RemoveProductFavoriteParams> {
  final FavoritePageRepository favoritePageRepository;
  RemoveProductFavorite({required this.favoritePageRepository});

  @override
  Future<Either<Failure,bool>> call(RemoveProductFavoriteParams params) async {
    return await favoritePageRepository.removeProductFromFavorite(product: params.product);
  }
}


class RemoveProductFavoriteParams {
  final Product product;
  RemoveProductFavoriteParams({required this.product});
}