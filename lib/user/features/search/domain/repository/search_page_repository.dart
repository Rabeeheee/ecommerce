import 'package:tech_haven/core/entities/product.dart';


abstract class SearchPageRepository {
  Future<List<Product>> searchProducts(String query);
}
