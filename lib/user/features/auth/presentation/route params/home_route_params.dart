
class OTPParams {
  // final User? user;
  final String phoneNumber;
  final String? email;
  final String? password;
  final String verificaionID;
  final bool isForSignUp;
  OTPParams(
      { this.email,
      //  this.user,
       this.password,
    required   this.phoneNumber,
      
      required this.verificaionID,required this.isForSignUp});
}
