import 'auth_bloc.dart';

//for the otp page
final class AuthOTPPageState extends AuthState {}

final class OTPPageActionState extends AuthOTPPageState {}

final class UserCreationFailed extends OTPPageActionState {
  final String message;
  UserCreationFailed({required this.message});
}

final class UserCreationSuccess extends OTPPageActionState {
  final String username;
  UserCreationSuccess({required this.username});
}

final class UpdateUserPhoneNumberSuccess extends OTPPageActionState {}

final class UpdateUserPhoneNumberFailed extends OTPPageActionState {
  final String message;
  UpdateUserPhoneNumberFailed({required this.message});
}
