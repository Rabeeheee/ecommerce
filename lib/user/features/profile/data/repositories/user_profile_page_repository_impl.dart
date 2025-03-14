import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/error/exceptions.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/user/features/profile/data/datasource/user_profile_page_data_source.dart';
import 'package:tech_haven/user/features/profile/domain/repository/user_profile_page_repository.dart';

class UserProfilePageRepositoryImpl implements UserProfilePageRepository {
  final UserProfilePageDataSource dataSource;

  UserProfilePageRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, String>> sendOtpForGoogleLogin(String phoneNumber) async {
    try {
    final result = await dataSource.sendOtpForGoogleLogin(phoneNumber);
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}