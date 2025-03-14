import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/common/data/model/order_model.dart';
import 'package:tech_haven/core/common/domain/repository/repository.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/core/usecase/usecase.dart';

class GetVendorOrders implements UseCase<List<OrderModel>, NoParams> {
  final Repository repository;
  GetVendorOrders({required this.repository});

  @override
  Future<Either<Failure,List<OrderModel>>> call(NoParams params) async {
    return await repository.getVendorOrders();
  }
}
