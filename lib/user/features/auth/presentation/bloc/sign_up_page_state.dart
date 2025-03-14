import 'package:tech_haven/core/entities/auth_sign_up_model.dart';

import 'auth_bloc.dart';

// the imitial state of the page
//for the sign up page
final class AuthSignUpPageState extends AuthState {}

//for the actions states of sign up page
final class SignUpPageActionState extends AuthSignUpPageState {}

final class OTPSendSuccess extends SignUpPageActionState {
  final AuthSignUpModel authSignUpModel;
  OTPSendSuccess({required this.authSignUpModel});
}

// final class SignUpPageDisableTextField extends SignUpPageActionState {
//   final String verificationId;
//   SignUpPageDisableTextField({required this.verificationId});
// }

// final class SignUpUserSuccess extends SignUpPageActionState {
//   final String username;
//   SignUpUserSuccess({required this.username});
// }

// final class SignUpUserFailed extends SignUpPageActionState {
//   final String message;
//   SignUpUserFailed({required this.message});
// }

// final class StartSigningUpUser extends SignUpPageActionState {
//   final String userId;
//   StartSigningUpUser({required this.userId});
// }

final class AuthGoogleSignUpFailed extends SignUpPageActionState {
  final String message;
  AuthGoogleSignUpFailed({required this.message});
}

final class AuthGoogleSignUpSuccess extends SignUpPageActionState {
  final String message;
  AuthGoogleSignUpSuccess({required this.message});
}

final class OTPSendFailed extends SignUpPageActionState {
  final String message;
  OTPSendFailed({required this.message});
}
