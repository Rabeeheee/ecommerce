import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/core/entities/order.dart' as model;
abstract interface class OrderRepository {
  Future<Either<Failure, String>> deliverOrderToAdmin({required model.Order order
  // ,required PaymentModel paymentModel
  });
}
