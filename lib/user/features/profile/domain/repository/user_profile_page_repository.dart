import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/error/failures.dart';

abstract class UserProfilePageRepository {
  Future<Either<Failure, String>> sendOtpForGoogleLogin(String phoneNumber);
}