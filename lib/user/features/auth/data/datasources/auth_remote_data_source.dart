import 'package:firebase_auth/firebase_auth.dart';
import 'package:tech_haven/user/features/auth/data/models/sign_up_model.dart';

abstract interface class AuthRemoteDataSource {
  //this is firebase user to get the current user
  User? get currentUser;
  //for phonenumber verification
  Future<SignUpModelImpl> sendOTPToPhoneNumber({
    required String phoneNumber,
    required String email,
    required String password,
  });
//for otp verification
  Future<String> verifyPhoneAndSignUpUser({
    required String phoneNumber,
    required String email,
    required String password,
    required String verificationId,
    required String otpCode,
  });
   Future<void> updateUserPhoneNumber({
    required bool updateNumber,
    required String phoneNumber,
    required String verificationID,
    required String otpCode,
  });

  Future<bool> createUser({
    required dynamic image,
    required String username,
    required String currency,
    required String currencySymbol,
    required int color,
  });

  Future<String> userSignIn({
    required String phoneNumber,
    required String password,
  });

  Future<String> signUpUserWithGoogle();
  Future<String> forgotPasswordSendEmail({required String phoneNumber});

  // Future<String> signInUserWithGoogle();
}
