
import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/common/domain/repository/repository.dart';
import 'package:tech_haven/core/entities/user.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/core/usecase/usecase.dart';

class GetUserData implements UseCase<User?, NoParams> {
  final Repository repository;
  GetUserData({required this.repository});

  @override
  Future<Either<Failure, User?>> call(NoParams params) async {
    return await repository.getUserData();
  }
}
