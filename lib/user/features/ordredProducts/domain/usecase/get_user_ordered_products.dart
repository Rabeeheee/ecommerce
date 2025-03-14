import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/entities/user_ordered_product.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/core/usecase/usecase.dart';
import 'package:tech_haven/user/features/ordredProducts/domain/repository/ordered_products_page_repository.dart';

class GetUserOrderProducts implements UseCase<List<UserOrderedProduct>, GetUserOrderProductsParams> {
  final OrderedProductsPageRepository repository;

  GetUserOrderProducts(this.repository);

  @override
  Future<Either<Failure, List<UserOrderedProduct>>> call(GetUserOrderProductsParams params) async {
    return await repository.getUserOrderProducts(params.userId, params.orderId);
  }
}

class GetUserOrderProductsParams {
  final String userId;
  final String orderId;

  const GetUserOrderProductsParams({
    required this.userId,
    required this.orderId,
  });

}