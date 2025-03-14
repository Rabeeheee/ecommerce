import 'package:tech_haven/core/entities/auth_sign_up_model.dart';

class SignUpModelImpl extends AuthSignUpModel {
  SignUpModelImpl({
    required super.phoneNumber,
    required super.email,
    required super.password,
    required super.verificationID,
  });
}
