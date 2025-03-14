import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/common/data/model/user_ordered_product_model.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/user/features/ordredProducts/data/datasource/ordered_products_page_data_source.dart';
import 'package:tech_haven/user/features/ordredProducts/domain/repository/ordered_products_page_repository.dart';

class OrderedProductsPageRepositoryImpl implements OrderedProductsPageRepository {
  final OrderedProductsPageDataSource dataSource;

  OrderedProductsPageRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, List<UserOrderedProductModel>>> getUserOrderProducts(String userId, String orderId) async {
    try {
      final products = await dataSource.getUserOrderProducts(userId, orderId);
      return right(products);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}