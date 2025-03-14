//for the sign in page
import 'auth_bloc.dart';
final class AuthSignInPageState extends AuthState {}

final class SignInPageActionState extends AuthSignInPageState {}

final class AuthSignInSuccess extends SignInPageActionState {
  final String message;
  AuthSignInSuccess({required this.message});
}

final class AuthSignInFailed extends SignInPageActionState {
  final String message;
  AuthSignInFailed({required this.message});
}
final class AuthGoogleSignInFailed extends SignInPageActionState {
  final String message;
  AuthGoogleSignInFailed({required this.message});
}

final class AuthGoogleSignInSuccess extends SignInPageActionState {
  final String message;
  AuthGoogleSignInSuccess({
    required this.message,
  });
}
