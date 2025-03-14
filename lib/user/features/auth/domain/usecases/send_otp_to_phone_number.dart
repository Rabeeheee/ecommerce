import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/entities/auth_sign_up_model.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/core/usecase/usecase.dart';
import 'package:tech_haven/user/features/auth/domain/repository/auth_repository.dart';


class SendOTPToPhoneNumber
    implements UseCase<AuthSignUpModel, SendOTPToPhoneNumberParams> {
  final AuthRepository authRepository;
  const SendOTPToPhoneNumber(this.authRepository);

  @override
  Future<Either<Failure, AuthSignUpModel>> call(
      SendOTPToPhoneNumberParams params) async {
    return await authRepository.sendOTPToPhoneNumber(
      phoneNumber: params.phonenumber,
      email: params.email,
      password: params.password,
    );
  }
  
}

class SendOTPToPhoneNumberParams {
  final String phonenumber;
  final String email;
  final String password;

  SendOTPToPhoneNumberParams({
    required this.phonenumber,
    required this.email,
    required this.password,
  });
}
