import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/core/usecase/usecase.dart';
import 'package:tech_haven/user/features/profile/domain/repository/user_profile_page_repository.dart';

class SendOtpForGoogleLogin implements UseCase<String, SendOtpForGoogleLoginParams> {
  final UserProfilePageRepository repository;

  SendOtpForGoogleLogin(this.repository);

  @override
  Future<Either<Failure, String>> call(SendOtpForGoogleLoginParams params) async {
    return await repository.sendOtpForGoogleLogin(params.phoneNumber);
  }
}

class SendOtpForGoogleLoginParams {
  final String phoneNumber;

  const SendOtpForGoogleLoginParams({required this.phoneNumber});

}