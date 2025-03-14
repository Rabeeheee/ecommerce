part of 'auth_bloc.dart';

class AuthEvent {}

final class SendOTPEvent extends AuthEvent {
  final String phoneNumber;
  final String email;
  final String password;
  SendOTPEvent({
    required this.email,
    required this.password,
    required this.phoneNumber,
  });
}

final class VerifyPhoneAndSignUpUserEvent extends AuthEvent {
  final String phoneNumber;
  final String email;
  final String password;
  final String verificationId;
  final String otpCode;
  VerifyPhoneAndSignUpUserEvent({
    required this.phoneNumber,
    required this.email,
    required this.password,
    required this.verificationId,
    required this.otpCode,
  });
}

// final class SendOTPForGoogleLogin extends AuthEvent {
//   final String phoneNumber;
//   SendOTPForGoogleLogin({required this.phoneNumber});
// }

final class UpdateThePhoneNumberOfUser extends AuthEvent {
  final bool updateNumber;
  final String phoneNumber;
  final String verificationID;
  final String otpCode;
  UpdateThePhoneNumberOfUser({
    required this.phoneNumber,
    required this.updateNumber,
    required this.verificationID,
    required this.otpCode,
  });
}

final class CreateUserEvent extends AuthEvent {
  final String username;
  final String currency;
  final String currencySymbol;
  final dynamic image;
  final int color;

  CreateUserEvent({
    required this.username,
    required this.currency,
    required this.currencySymbol,
    required this.image,
    required this.color,
  });
}

final class UserSignInEvent extends AuthEvent {
  final String phoneNumber;
  final String password;

  UserSignInEvent({
    required this.phoneNumber,
    required this.password,
  });
}

final class NavigateToSignUpPageEvent extends AuthEvent {
  final String userId;
  NavigateToSignUpPageEvent({required this.userId});
}

final class AuthSignUpEvent extends AuthEvent {
  final String phoneNumberVerifiedUID;
  final String username;
  final String phoneNumber;
  final String email;
  final String password;
  AuthSignUpEvent({
    required this.phoneNumberVerifiedUID,
    required this.username,
    required this.phoneNumber,
    required this.email,
    required this.password,
  });
}

final class SignUpWelcomePageProfileUploadEvent extends AuthEvent {
  final String uid;
  final bool isProfilePhotoUploaded;
  final File? image;
  final String username;
  final int color;

  SignUpWelcomePageProfileUploadEvent({
    required this.uid,
    required this.isProfilePhotoUploaded,
    required this.image,
    required this.username,
    required this.color,
  });
}

final class SignUpWithGoogleAccount extends AuthEvent {}

final class SignInWithGoogleAccount extends AuthEvent {}

final class AuthIsUserLoggedInEvent extends AuthEvent {}

final class ForgotPasswordSendEmailEvent extends AuthEvent {
  final String phoneNumber;
  ForgotPasswordSendEmailEvent({required this.phoneNumber});
}

final class ForgotPasswordOTPVerificaion extends AuthEvent {
  final String otpCode;
  final String verificationID;
  ForgotPasswordOTPVerificaion({
    required this.otpCode,
    required this.verificationID,
  });
}
