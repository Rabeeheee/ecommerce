import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/vendor/features/order/data/datasource/order_data_source.dart';
import 'package:tech_haven/vendor/features/order/domain/repository/order_repository.dart';

import '../../../../../core/error/exceptions.dart';
import 'package:tech_haven/core/entities/order.dart' as model;

class OrderRepositoryImpl implements OrderRepository {
  final OrderDataSource orderDataSource;
  OrderRepositoryImpl({required this.orderDataSource});
  @override
  Future<Either<Failure, String>> deliverOrderToAdmin(
      {required model.Order order
      // ,required PaymentModel paymentModel
      }) async {
    try {
      final result = await orderDataSource.deliverOrderToAdmin(order: order ,
      // paymentModel: paymentModel
      );
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
