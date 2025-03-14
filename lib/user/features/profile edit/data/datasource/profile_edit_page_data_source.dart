
import 'package:tech_haven/core/common/data/model/user_model.dart';

abstract class ProfileEditPageDataSource{
Future<void> updateUserData(UserModel userModel, dynamic newImage);
}