import 'package:tech_haven/core/entities/product.dart';

abstract class FavoritePageDataSource {
  Future<List<Product>> getAllFavoritedProducts();
  Future<bool> removeProductFromFavorite({required Product product});
}
