import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/entities/user_ordered_product.dart';
import 'package:tech_haven/core/error/failures.dart';

abstract class OrderedProductsPageRepository {
  Future<Either<Failure, List<UserOrderedProduct>>> getUserOrderProducts(String userId, String orderId);
}