import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:tech_haven/core/error/exceptions.dart';
import 'package:tech_haven/user/features/profile/data/datasource/user_profile_page_data_source.dart';

class UserProfilePageDataSourceImpl implements UserProfilePageDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  UserProfilePageDataSourceImpl(
      {required this.firebaseAuth, required this.firestore});

  String? potentialVerificationId;
  @override
  Future<String> sendOtpForGoogleLogin(String phoneNumber) async {
    try {
      await getVerificationId(phoneNumber);
      if (potentialVerificationId != null) {
        return potentialVerificationId!;
      } else {
        throw const ServerException(
            'Verification ID failed to recieve , Please try again');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-phone-number') {
        throw const ServerException(
            'The phone number format is incorrect. Please enter the phone number in the format: +971 1234567890.');
      }
      throw ServerException(e.message!);
    } on ServerException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(
        e.toString(),
      );
    }
  }

  Future<void> getVerificationId(String phoneNumber) async {
    await firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (phoneAuthCredential) async {
        await firebaseAuth.signInWithCredential(phoneAuthCredential);
      },
      verificationFailed: (error) async {
        throw error;
      },
      codeSent: (verificationId, forceResendingToken) {
        log('assigning the verification id');
        assignTheVerificationId(verificationId: verificationId);
        if (kDebugMode) {
          print(potentialVerificationId);
        }
      },
      codeAutoRetrievalTimeout: (verificationId) async {},
    );
  }

  assignTheVerificationId({required String verificationId}) {
    potentialVerificationId = verificationId;
  }
}
