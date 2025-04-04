import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:tech_haven/core/common/data/model/user_model.dart' as model;
import 'package:tech_haven/core/error/exceptions.dart';
import 'package:tech_haven/core/utils/auth_utils.dart';
import 'package:tech_haven/user/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:tech_haven/user/features/auth/data/models/sign_up_model.dart';
import 'package:uuid/uuid.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth;
  final FirebaseStorage firebaseStorage;
  final GoogleSignIn googleSignIn;
  AuthRemoteDataSourceImpl({
    required this.firebaseAuth,
    required this.googleSignIn,
    required this.firebaseFirestore,
    required this.firebaseStorage,
  });

  @override
  Future<bool> createUser({
    required dynamic image,
    required String username,
    required String currency,
    required String currencySymbol,
    required int color,
  }) async {
    String imageID = const Uuid().v1();
    User? user = firebaseAuth.currentUser;
    try {
//if image is not null then we upload the image into storage and get the download url and create a user doc

      if (user != null) {
        String? downloadURL;
        if (image != null) {
          Reference reference = firebaseStorage
              .ref('user')
              .child('usersProfilePicture')
              .child(user.uid)
              .child(imageID);

          UploadTask uploadTask = image is File
              ? reference.putFile(image)
              : reference.putData(image);
          TaskSnapshot taskSnapshot = await uploadTask;

          downloadURL = await taskSnapshot.ref.getDownloadURL();
        }
        final CollectionReference collectionReference =
            firebaseFirestore.collection('users');

        model.UserModel userModel = model.UserModel(
          email: user.email!,
          userAllowed: true,
          phoneNumber: user.phoneNumber!,
          userImageID: imageID,
          uid: user.uid,
          username: username,
          currency: currency,
          vendorID: null,
          currencySymbol: currencySymbol,
          isProfilePhotoUploaded: image != (null),
          color: color,
          profilePhoto: downloadURL ?? '',
          isVendor: false,
        );

        await collectionReference.doc(user.uid).set(userModel.toJson());
      }
      return true;
    } on ServerException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  String? potentialVerificationId;
  @override
  Future<SignUpModelImpl> sendOTPToPhoneNumber({
    required String phoneNumber,
    required String email,
    required String password,
  }) async {
    try {
      await getVerificationId(phoneNumber);
      return SignUpModelImpl(
        phoneNumber: phoneNumber,
        email: email,
        password: password,
        verificationID: potentialVerificationId!,
      );
      // } else {}
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message!);
    } on ServerException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  Future<void> getVerificationId(String phoneNumber) async {
    await firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (phoneAuthCredential) {
        //  firebaseAuth.signInWithCredential(phoneAuthCredential);
      },
      verificationFailed: (error) {
        throw ServerException(error.message!);
      },
      codeSent: (verificationId, forceResendingToken) {
        potentialVerificationId = verificationId;
      },
      codeAutoRetrievalTimeout: (verificationId) {
        potentialVerificationId = verificationId;
      },
    );
  }

  Future<void> assignTheVerificationId({required String verificationId}) async {
    potentialVerificationId = verificationId;
  }

  @override
  Future<String> verifyPhoneAndSignUpUser({
    required String phoneNumber,
    required String email,
    required String password,
    required String verificationId,
    required String otpCode,
  }) async {
    try {
      // Create a new phoneAuthCredential with the verificationId and otp code received
      if (kDebugMode) {
        print('start');
      }
      PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otpCode,
      );
      if (kDebugMode) {
        print(phoneAuthCredential.smsCode);
      }

      // Attempt to create user with email and password
      UserCredential userCredential = await createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (kDebugMode) {
        print(userCredential.user!.email ?? userCredential.user!.phoneNumber);
      }

      User? user = userCredential.user;
      if (kDebugMode) {
        print(user != null);
      }
      if (user != null) {
        // Link the phone credential with the newly created user
        await user.linkWithCredential(phoneAuthCredential);

        // Check if email verification is required and send verification email if necessary
        if (!user.emailVerified) {
          await user.sendEmailVerification();
        }

        // Return the username if available, otherwise extract name from email
        return user.displayName ?? AuthUtils.extractNameFromEmail(user.email!);
      } else {
        throw const ServerException(
          'Exception Caught While Linking Phone Number',
        );
      }
    } on FirebaseAuthException catch (e) {
      throw handleFirebaseAuthException(e);
    } catch (e) {
      // Handle general exceptions
      throw ServerException(e.toString());
    }
  }

  ServerException handleFirebaseAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'credential-already-in-use':
        throw const ServerException(
          'The account corresponding to the credential already exists among your users.',
        );
      case 'provider-already-linked':
        throw const ServerException(
          'The provider has already been linked to the user.',
        );
      case 'invalid-credential':
        throw const ServerException(
          'The provider\'s credential is not valid. It might have expired or is using invalid tokens.',
        );
      case 'email-already-in-use':
        throw const ServerException(
          'The email corresponding to the credential already exists among your users.',
        );
      case 'operation-not-allowed':
        throw const ServerException(
          'You have not enabled the provider in the Firebase Console.',
        );
      case 'invalid-email':
        throw const ServerException(
          'The email used is invalid.',
        );
      case 'invalid-password':
        throw const ServerException(
          'The password used is not correct or the user does not have a password.',
        );
      case 'invalid-verification-code':
        throw const ServerException(
          'The verification code of the credential is not valid.',
        );
      case 'invalid-verification-id':
        throw const ServerException(
          'The verification ID of the credential is not valid.',
        );
      default:
        throw ServerException(e.message!);
    }
  }

  @override
  Future<void> updateUserPhoneNumber({
    required bool updateNumber,
    required String phoneNumber,
    required String verificationID,
    required String otpCode,
  }) async {
    try {
      // Verify OTP
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationID,
        smsCode: otpCode,
      );
      final User? currentUser = firebaseAuth.currentUser;
      // Update phone number in Firebase Auth
      if (currentUser != null) {
        if (updateNumber) {
          await currentUser.updatePhoneNumber(credential);
        } else {
          await currentUser.linkWithCredential(credential);
        }

        final User? updateUser = firebaseAuth.currentUser;

        await firebaseFirestore
            .collection('users')
            .doc(currentUser.uid)
            .update({
          'phoneNumber': updateUser!.phoneNumber,
        });
      } else {
        throw const ServerException("The user doesn't Exist");
      }
      return;
      // Update phone number in Firestore
    } on ServerException catch (e) {
      throw ServerException(e.toString());
    } on FirebaseAuthException catch (e) {
      throw handleFirebaseAuthException(e);
    }
  }

  Future<UserCredential> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCredential;
    } on ServerException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      rethrow;
    }
  }

  @override
  User? get currentUser => firebaseAuth.currentUser;

  @override
  Future<String> userSignIn({
    required String phoneNumber,
    required String password,
    // required String verificationID,
    // required String otpCode,
  }) async {
    try {
      UserCredential userCredential;
      // Fetch the user document from Firestore based on the provided phone number
      //check if there is a user with this number with email.
      final User? currentUser = firebaseAuth.currentUser;
      if (currentUser != null) {
        // Sign out the current user before signing in with a different email
        //  GoogleSignIn googleSignIn =
        //                                         GoogleSignIn();
        googleSignIn.signOut();
        await firebaseAuth.signOut();
      }
      // print(phoneNumber);
      // Fetch the user document from Firestore based on the provided phone number
      final QuerySnapshot snapshot = await firebaseFirestore
          .collection('users')
          .where('phoneNumber', isEqualTo: phoneNumber)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final userData = snapshot.docs.first.data() as Map<String, dynamic>;
        final email = userData['email'];
        // Fetch user document based on uid
        // final userDoc =
        //     await FirebaseFirestore.instance.collection('users').doc(uid).get();
        // final userDataFromDoc = userDoc.data();
        // If the user is found, sign in with the user's email and password
        userCredential = await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
        // await firebaseAuth.signInWithCredential(credential);
        return userCredential.user!.email!;
        // Navigate to the next screen or perform any desired action
      } else {
        throw const ServerException(
          "create an account first to sign in",
        );
      }
    } on FirebaseAuthException catch (e) {
      throw handleFirebaseAuthException(e);
    } on ServerException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> signUpUserWithGoogle() async {
    try {
      User? user;
      if (kIsWeb) {
        final GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();
        final userCredential =
            await firebaseAuth.signInWithPopup(googleAuthProvider);
        user = userCredential.user;
      } else {
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
        if (googleUser == null) {
          throw Exception('The Google user is not initiated');
        }
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        // print(googleAuth.accessToken);
        // print(googleAuth.accessToken);
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        final userCredential =
            await firebaseAuth.signInWithCredential(credential);
        user = userCredential.user;
      }

      if (user != null) {
        // Check if the user already exists in Firestore
        final doc =
            await firebaseFirestore.collection('users').doc(user.uid).get();
        if (!doc.exists) {
          // Create a User object with the necessary details
          final newUser = model.UserModel(
            uid: user.uid,
            userImageID: null,
            phoneNumber: user.phoneNumber,
            userAllowed: true,
            username: user.displayName,
            currency: 'USD', // Assign default or fetch from a settings screen
            vendorID: null, // Assign default or generate dynamically
            currencySymbol:
                '\$', // Assign default or fetch from a settings screen
            email: user.email,
            profilePhoto: user.photoURL,
            isVendor: false, // Assign default or fetch from a settings screen
            isProfilePhotoUploaded: user.photoURL != null,
            color: 0xFF000000, // Assign default or fetch from a settings screen
          );

          // Save the user data to Firestore
          await firebaseFirestore
              .collection('users')
              .doc(user.uid)
              .set(newUser.toJson());
        }
        return user.email!;
      } else {
        throw Exception('User is Not Registered');
      }
    } on FirebaseAuthException catch (e) {
      throw handleFirebaseAuthException(e);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> forgotPasswordSendEmail({required String phoneNumber}) async {
    try {
      // firebaseAuth.confirmPasswordReset(code: code, newPassword: newPassword)
      final QuerySnapshot snapshot = await firebaseFirestore
          .collection('users')
          .where('phoneNumber', isEqualTo: phoneNumber)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final userData = snapshot.docs.first.data() as Map<String, dynamic>;
        final String email = userData['email'];
        // Fetch user document based on uid
        // final userDoc =
        //     await FirebaseFirestore.instance.collection('users').doc(uid).get();
        // final userDataFromDoc = userDoc.data();
        // If the user is found, sign in with the user's email and password
        await firebaseAuth.sendPasswordResetEmail(email: email);
        // await firebaseAuth.signInWithCredential(credential);
        // return userCredential.user!.email!;
        // Navigate to the next screen or perform any desired action

        return 'Change your Password from the link that is send to your email $email';
      } else {
        throw const ServerException(
          "User doesn't Exist with this phone number",
        );
      }
      // return potentialVerificationId!;
    } on FirebaseAuthException catch (e) {
      throw handleFirebaseAuthException(e);
    } on ServerException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(
        e.toString(),
      );
    }
  }
}
