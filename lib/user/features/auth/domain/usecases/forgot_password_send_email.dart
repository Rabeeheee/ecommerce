
import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/core/usecase/usecase.dart';
import 'package:tech_haven/user/features/auth/domain/repository/auth_repository.dart';

class ForgotPasswordSendEmail implements UseCase<String, ForgotPasswordSendEmailParams> {
  final AuthRepository authRepository;
  ForgotPasswordSendEmail({required this.authRepository});
  @override
  Future<Either<Failure, String>> call(ForgotPasswordSendEmailParams params) async {
    return await authRepository.forgotPasswordSendEmail(
      phoneNumber: params.phoneNumber,
    );
  }
}

class ForgotPasswordSendEmailParams {
  final String phoneNumber;
  ForgotPasswordSendEmailParams({required this.phoneNumber});
}

// class CreateUserParams {
//   final File? image;
//   final String username;
//   final int color;

//   CreateUserParams({
//     required this.image,
//     required this.username,
//     required this.color,
//   });
// }
