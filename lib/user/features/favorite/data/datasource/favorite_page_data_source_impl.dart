import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tech_haven/core/common/data/datasource/data_source.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/error/exceptions.dart';
import 'package:tech_haven/user/features/favorite/data/datasource/favorite_page_data_source.dart';

class FavoritePageDataSourceImpl extends FavoritePageDataSource {
  final DataSource dataSource;
  final FirebaseFirestore firebaseFirestore;
  FavoritePageDataSourceImpl(
      {required this.dataSource, required this.firebaseFirestore});
  @override
  Future<List<Product>> getAllFavoritedProducts() async {
    try {
      final allFavoritedProducts = await dataSource.getAllFavorite();
      final allProducts = await dataSource.getAllProduct();

      return allProducts
          .where((element) => allFavoritedProducts.contains(element.productID))
          .toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<bool> removeProductFromFavorite({required Product product}) async {
    try {
      return await dataSource.updateProductToFavorite(
          isFavorited: false, product: product);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
