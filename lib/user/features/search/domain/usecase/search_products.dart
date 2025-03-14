
import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/user/features/search/domain/repository/search_page_repository.dart';
class SearchProducts {
  final SearchPageRepository repository;

  SearchProducts(this.repository);

  Future<Either<Exception, List<Product>>> call(String query) async {
    try {
      final result = await repository.searchProducts(query);
      return right(result);
    } catch (e) {
      return left(Exception('Failed to search products'));
    }
  }
}
