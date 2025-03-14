import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:tech_haven/core/common/data/model/revenue_model.dart';
import 'package:tech_haven/core/error/exceptions.dart';
import 'package:tech_haven/vendor/features/registervendor/data/datasource/register_vendor_datasource.dart';
import 'package:tech_haven/core/entities/user.dart' as model;
import 'package:tech_haven/vendor/features/registervendor/data/models/vendor_model.dart';
import 'package:uuid/uuid.dart';

class RegisterVendorDataSourceImpl implements RegisterVendorDataSource {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth;
  final FirebaseStorage firebaseStorage;

  RegisterVendorDataSourceImpl(
      {required this.firebaseAuth,
      required this.firebaseFirestore,
      required this.firebaseStorage});
  @override
  Future<String> sendRequestForVendor(
      {required model.User user,
      required dynamic businessPicture,
      required String businessName,
      required String physicalAddress,
      required String accountNumber}) async {
    try {
      String vendorID = const Uuid().v4();
      String? downloadURL;
      if (businessPicture != null) {
        String imageID = const Uuid().v1();

        Reference reference = firebaseStorage
            .ref('vendors')
            .child('vendorsBusinessPicture')
            .child(vendorID)
            .child(imageID);

        UploadTask uploadTask = businessPicture is File
            ? reference.putFile(businessPicture)
            : reference.putData(businessPicture);
        TaskSnapshot taskSnapshot = await uploadTask;
        downloadURL = await taskSnapshot.ref.getDownloadURL();
      }
      RevenueModel revenueModel = RevenueModel(
          currentBalance: 0, vendorID: vendorID, withdrewAmount: 0);
      await firebaseFirestore
          .collection('revenues')
          .doc(vendorID)
          .set(revenueModel.toJson());

      await firebaseFirestore
          .collection('users')
          .doc(user.uid)
          .update({'vendorID': vendorID});
      await firebaseFirestore
          .collection('vendors')
          .doc(vendorID)
          .set(VendorModel(
            vendorID: vendorID,
            isVendor: false,
            businessProfileUploaded: businessPicture == null ? false : true,
            userID: user.uid ?? '',
            color: user.color,
            businessName: businessName,
            physicalAddress: physicalAddress,
            accountNumber: accountNumber,
            email: user.email!,
            phoneNumber: user.phoneNumber!,
            userName: user.username!,
            businessPicture: downloadURL,
          ).toJson());
      return vendorID;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> checkForVendorStatus({required String vendorID}) async {
    try {
      return '';
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
