import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/common/data/model/order_model.dart';
import 'package:tech_haven/core/entities/user.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/core/usecase/usecase.dart';
import 'package:tech_haven/user/features/order%20history/domain/repository/user_order_history_repositry.dart';

class GetAllUserOrderHistoryUseCase implements UseCase<List<OrderModel>, GetAllUserOrderHistoryUseCaseParams> {
  final UserOrderHistoryRepository userOrderHistoryRepository;

  GetAllUserOrderHistoryUseCase({required this.userOrderHistoryRepository});

  @override
  Future<Either<Failure, List<OrderModel>>> call(GetAllUserOrderHistoryUseCaseParams params) async {
    return await userOrderHistoryRepository.getProducts(user:params.user );
  }
}

class GetAllUserOrderHistoryUseCaseParams {
  final User user;
  GetAllUserOrderHistoryUseCaseParams({required this.user});
}
