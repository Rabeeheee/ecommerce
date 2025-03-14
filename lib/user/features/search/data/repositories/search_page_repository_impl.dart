
import 'package:tech_haven/core/common/data/model/product_model.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/user/features/search/data/datasource/search_page_data_source.dart';
import 'package:tech_haven/user/features/search/domain/repository/search_page_repository.dart';

class SearchPageRepositoryImpl implements SearchPageRepository {
  final SearchPageDataSource dataSource;

  SearchPageRepositoryImpl(this.dataSource);

   @override
  Future<List<Product>> searchProducts(String query) async {
    final result = await dataSource.searchProducts(query);
    return result.map((doc) => ProductModel.fromJson(doc.data() as Map<String,dynamic>)).toList();
  }
}
