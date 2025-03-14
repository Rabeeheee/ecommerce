import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/core/usecase/usecase.dart';
import 'package:tech_haven/user/features/favorite/domain/repository/favorite_page_repository.dart';

class GetAllFavoritedProductFavoritePage implements UseCase<List<Product>, NoParams> {
  final FavoritePageRepository favoritePageRepository;
  GetAllFavoritedProductFavoritePage({required this.favoritePageRepository});

  @override
  Future<Either<Failure, List<Product>>> call(NoParams params) async {
    return await favoritePageRepository.getAllFavoritedProducts();
  }
}
