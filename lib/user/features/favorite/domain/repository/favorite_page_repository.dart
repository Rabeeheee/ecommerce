import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/error/failures.dart';

abstract class FavoritePageRepository {
  Future<Either<Failure, List<Product>>> getAllFavoritedProducts();
  Future<Either<Failure, bool>> removeProductFromFavorite({required Product product});
}


