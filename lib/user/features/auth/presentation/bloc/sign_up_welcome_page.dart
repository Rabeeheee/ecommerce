//states for signup welcome page.
import 'package:tech_haven/core/entities/user.dart';
import 'auth_bloc.dart';
final class AuthSignUpWelcomPageState extends AuthState {}

//for action states of sign up welcome page
final class SignUpWelcomePageActionState extends AuthSignUpWelcomPageState {}

final class CreateUserSuccess extends SignUpWelcomePageActionState {
  final bool userCreated;
  CreateUserSuccess({required this.userCreated});
}

final class CreateUserFailed extends SignUpWelcomePageActionState {
  final String message;
  CreateUserFailed({required this.message});
}

final class AuthIsUserLoggedInFailed extends SignUpWelcomePageActionState {
  final String message;
  AuthIsUserLoggedInFailed({required this.message});
}

final class AuthIsUserLoggedInSuccess extends SignUpWelcomePageActionState {
  final User user;
  AuthIsUserLoggedInSuccess({required this.user});
}
