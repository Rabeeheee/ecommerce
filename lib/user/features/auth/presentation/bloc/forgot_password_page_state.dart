import 'auth_bloc.dart';

final class AuthForgotPasswordPageState extends AuthState {}

final class ForgotPasswordPageActionState extends AuthForgotPasswordPageState {}

final class UserEmailForgotPasswordSuccess extends AuthForgotPasswordPageState {
  final String message;
  UserEmailForgotPasswordSuccess({required this.message});
}

final class UserEmailForgotPasswordFailed extends AuthForgotPasswordPageState {
  final String message;
  UserEmailForgotPasswordFailed({required this.message});
}
