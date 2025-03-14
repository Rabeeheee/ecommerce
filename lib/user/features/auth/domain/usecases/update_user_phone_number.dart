import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/core/usecase/usecase.dart';
import 'package:tech_haven/user/features/auth/domain/repository/auth_repository.dart';

class UpdateUserPhoneNumber
    implements UseCase<void, UpdateUserPhoneNumberParams> {
  final AuthRepository repository;

  UpdateUserPhoneNumber(this.repository);

  @override
  Future<Either<Failure, void>> call(UpdateUserPhoneNumberParams params) async {
    return await repository.updateUserPhoneNumber(
      updateNumber: params.updateNumber,
      phoneNumber: params.phoneNumber,
      verificationID: params.verificationID,
      otpCode: params.otpCode,
    );
  }
}

class UpdateUserPhoneNumberParams {
  final bool updateNumber;
  final String phoneNumber;
  final String verificationID;
  final String otpCode;

  const UpdateUserPhoneNumberParams({
    required this.updateNumber,
    required this.phoneNumber,
    required this.verificationID,
    required this.otpCode,
  });
}
