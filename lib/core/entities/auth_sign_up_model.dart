class AuthSignUpModel {
  final String phoneNumber;
  final String email;
  final String password;
  final String verificationID;

  AuthSignUpModel({
    required this.phoneNumber,
    required this.email,
    required this.password,
    required this.verificationID,
  });
}
