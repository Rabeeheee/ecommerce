import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/entities/auth_sign_up_model.dart';
import 'package:tech_haven/core/error/failures.dart';

abstract interface class AuthRepository {
  //interface for the verification of the user phone number
  //this will return either fauilure or string with verificaitonId in it
  //if it's failure we will display a snackbar telling the issue else we will proceed to create a user with phone number
  Future<Either<Failure, AuthSignUpModel>> sendOTPToPhoneNumber({
    required String phoneNumber,
    required String email,
    required String password,
  });

  //this is for the verification of the otp code that the user has entered
  //if it's failure we will display a snackbar telling the issue else we will give a second chance for the user to enter the otp again
  Future<Either<Failure, String>> verifyPhoneAndSignUpUser({
    required String phoneNumber,
    required String email,
    required String password,
    required String verificationId,
    required String otpCode,
  });
   Future<Either<Failure, void>> updateUserPhoneNumber({
   required bool updateNumber,
    required String phoneNumber,
    required String verificationID,
    required String otpCode,
  });
  //for user sign up using email/password
  // Future<Either<Failure, UserDataModel>> signUpWithEmailPasswordAndCreateUser({
  //   required String phoneNumberVerifiedUID,
  //   required String phoneNumber,
  //   required String username,
  //   required String email,
  //   required String password,
  // });

  Future<Either<Failure, bool>> createUser({
    required dynamic? image,
    required String username,
    
  required String currency,
  required String currencySymbol,
    required int color,
  });

  Future<Either<Failure, String>> userSignIn({
    required String phoneNumber,
    required String password,
  });

  // Future<Either<Failure, User>> currentUser();
  // //for sign in using phone number
  // Future<Either<Failure, User>> signInWithPhoneNumberAndPassword({
  //   required String phonenumber,
  //   required String password,
  // });

  Future<Either<Failure, String>> signUpUserWithGoogle();
  Future<Either<Failure, String>> forgotPasswordSendEmail({required String phoneNumber});

  // Future<Either<Failure, String>> signInUserWithGoogle();
}
