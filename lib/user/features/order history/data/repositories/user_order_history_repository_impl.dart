import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/common/data/model/order_model.dart';
import 'package:tech_haven/core/entities/user.dart';
import 'package:tech_haven/core/error/exceptions.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/user/features/order%20history/data/datasource/user_order_history_data_source.dart';
import 'package:tech_haven/user/features/order%20history/domain/repository/user_order_history_repositry.dart';

class UserOrderHistoryRepositoryImpl implements UserOrderHistoryRepository {
  final UserOrderHistoryDataSource dataSource;

  UserOrderHistoryRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, List<OrderModel>>> getProducts({required User user}) async {
    try {
      final result = await dataSource.getProducts(user: user);
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
