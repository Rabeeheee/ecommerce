import 'package:tech_haven/core/common/data/model/order_model.dart';
import 'package:tech_haven/core/entities/user.dart';

abstract class UserOrderHistoryDataSource {
  Future<List<OrderModel>> getProducts({required User user});
}
