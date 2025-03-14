import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/common/data/model/order_model.dart';
import 'package:tech_haven/core/entities/user.dart';
import 'package:tech_haven/core/error/failures.dart';


abstract class UserOrderHistoryRepository {
  Future<Either<Failure, List<OrderModel>>> getProducts({required User user});
}
