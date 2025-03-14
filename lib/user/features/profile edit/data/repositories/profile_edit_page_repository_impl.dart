
import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/common/data/model/user_model.dart';
import 'package:tech_haven/core/error/exceptions.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/user/features/profile%20edit/data/datasource/profile_edit_page_data_source.dart';
import 'package:tech_haven/user/features/profile%20edit/domain/repository/profile_edit_page_repository.dart';

class ProfileEditPageRepositoryImpl implements ProfileEditPageRepository {
  final ProfileEditPageDataSource profileEditPageDataSource;
  ProfileEditPageRepositoryImpl({required this.profileEditPageDataSource});
  @override
  Future<Either<Failure, void>> updateUserData(
      UserModel userModel, dynamic newImage) async {
    try {
      await profileEditPageDataSource.updateUserData(userModel, newImage);
      return right((null));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
