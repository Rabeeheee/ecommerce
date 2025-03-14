import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/entities/order.dart' as model;
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/core/usecase/usecase.dart';
import 'package:tech_haven/vendor/features/order/domain/repository/order_repository.dart';

class DeliverOrderToAdmin
    implements UseCase<String, DeliverOrderToAdminParams> {
  final OrderRepository orderRepository;
  DeliverOrderToAdmin({required this.orderRepository});
  @override
  Future<Either<Failure, String>> call(DeliverOrderToAdminParams params) async {
    return await orderRepository.deliverOrderToAdmin(order: params.order
    // ,paymentModel: params.paymentModel
    );
  }
}

class DeliverOrderToAdminParams {
  final model.Order order;
  // final PaymentModel paymentModel;
  // final List<Product> listOfProducts;
  DeliverOrderToAdminParams({required this.order,
  // required this.paymentModel
  });
}
