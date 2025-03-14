// ignore: unused_import
import 'package:tech_haven/core/common/data/model/payment_model.dart';
import 'package:tech_haven/core/entities/order.dart';

abstract  class OrderDataSource {
  Future<String> deliverOrderToAdmin({required Order order
  // ,required PaymentModel paymentModel
  });
}
