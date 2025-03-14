
import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/common/data/model/user_model.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/core/usecase/usecase.dart';
import 'package:tech_haven/user/features/profile%20edit/domain/repository/profile_edit_page_repository.dart';

class UpdateUserData implements UseCase<void, UpdateUserDataParams> {
  final ProfileEditPageRepository profileEditPageRepository;

  UpdateUserData(this.profileEditPageRepository);

  @override
  Future<Either<Failure, void>> call(UpdateUserDataParams params) async {
    return await profileEditPageRepository.updateUserData(params.userModel, params.newImage);
  }
}

class UpdateUserDataParams  {
  final UserModel userModel;
  final dynamic newImage;

  const UpdateUserDataParams({required this.userModel, this.newImage});

}
