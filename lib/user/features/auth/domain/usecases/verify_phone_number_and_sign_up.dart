import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/core/usecase/usecase.dart';
import 'package:tech_haven/user/features/auth/domain/repository/auth_repository.dart';

class VerifyPhoneAndSignUpUser
    implements UseCase<String, VerifyPhoneAndSignUpUserParams> {
  final AuthRepository authRepository;
  const VerifyPhoneAndSignUpUser(this.authRepository);

  @override
  Future<Either<Failure, String>> call(
      VerifyPhoneAndSignUpUserParams params) async {
    return await authRepository.verifyPhoneAndSignUpUser(
      phoneNumber: params.phoneNumber,
      email: params.email,
      password: params.password,
      otpCode: params.otpCode,
      verificationId: params.verificationId,
    );
  }
}

class VerifyPhoneAndSignUpUserParams {
  final String phoneNumber;
  final String email;
  final String password;
  final String verificationId;
  final String otpCode;

  VerifyPhoneAndSignUpUserParams({
    required this.phoneNumber,
    required this.email,
    required this.password,
    required this.verificationId,
    required this.otpCode,
  });
}
