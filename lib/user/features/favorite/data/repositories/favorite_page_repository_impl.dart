import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/error/exceptions.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/user/features/favorite/data/datasource/favorite_page_data_source.dart';
import 'package:tech_haven/user/features/favorite/domain/repository/favorite_page_repository.dart';

class FavoritePageRepositoryImpl extends FavoritePageRepository {
  final FavoritePageDataSource favoritePageDataSource;
  FavoritePageRepositoryImpl({required this.favoritePageDataSource});
  @override
  Future<Either<Failure, List<Product>>> getAllFavoritedProducts() async {
    try {
      // print('updating the favorite');
      final result = await favoritePageDataSource.getAllFavoritedProducts();
      // print('hello how are you');

      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
  
  @override
  Future<Either<Failure, bool>> removeProductFromFavorite({required Product product})async {
      try {
      // print('updating the favorite');
      final result = await favoritePageDataSource.removeProductFromFavorite(product: product);
      // print('hello how are you');

      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}

