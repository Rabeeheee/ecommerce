// ignore_for_file: unused_import

import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/common/data/model/order_model.dart';
import 'package:tech_haven/core/common/domain/repository/repository.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/core/usecase/usecase.dart';
import 'package:tech_haven/core/entities/order.dart' as model;

class GetAllOrders implements UseCase<List<OrderModel>, NoParams> {
  final Repository repository;
  GetAllOrders({required this.repository});

  @override
  Future<Either<Failure,List<OrderModel>>> call(NoParams params) async {
    return await repository.getAllOrders();
  }
}
