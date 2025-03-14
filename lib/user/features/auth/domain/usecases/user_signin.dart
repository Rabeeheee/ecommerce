
import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/core/usecase/usecase.dart';
import 'package:tech_haven/user/features/auth/domain/repository/auth_repository.dart';

class UserSignIn implements UseCase<String, UserSignInParams> {
  final AuthRepository authRepository;
  UserSignIn({required this.authRepository});
  @override
  Future<Either<Failure, String>> call(UserSignInParams params) async{
 return    await authRepository.userSignIn(
        phoneNumber: params.phoneNumber, password: params.password);
  }
}

class UserSignInParams {
  final String phoneNumber;
  final String password;

  UserSignInParams({required this.phoneNumber, required this.password});
}
