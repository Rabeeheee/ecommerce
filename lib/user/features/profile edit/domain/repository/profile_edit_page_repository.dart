
import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/common/data/model/user_model.dart';
import 'package:tech_haven/core/error/failures.dart';

abstract interface class  ProfileEditPageRepository{
Future<Either<Failure, void>> updateUserData(UserModel userModel, dynamic newImage);
}