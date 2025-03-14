import 'package:tech_haven/core/entities/vendor.dart';

class VendorModel extends Vendor {
  // final String userID;
  // final String vendorID;
  // final String email;
  // final String phoneNumber;
  // final bool businessProfileUploaded;
  // final int color;
  // final String userName;
  // final bool isVendor;
  // final String businessPicture;
  // final String businessName;
  // final String physicalAddress;
  // final String accountNumber;

  VendorModel({
    required super.vendorID,
    required super.businessProfileUploaded,
    required super.isVendor,
    required super.userID,
    required super.email,
    required super.color,
    required super.phoneNumber,
    required super.userName,
    required super.businessPicture,
    required super.businessName,
    required super.physicalAddress,
    required super.accountNumber,
  });

  factory VendorModel.fromJson(Map<String, dynamic> json) {
    return VendorModel(
      isVendor: json['isVendor'] as bool,
      vendorID: json['vendorID'] as String,
      businessPicture: json['businessPicture'],
      color: json['color'] as int,
      email: json['email'] as String,
      businessProfileUploaded: json['businessProfileUploaded'] as bool,
      phoneNumber: json['phoneNumber'],
      userName: json['userName'] as String,
      // isVendor: : json['isVendor'] as bool,
      userID: json['userID'] as String,
      businessName: json['businessName'] as String,
      physicalAddress: json['physicalAddress'] as String,
      accountNumber: json['accountNumber'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isVendor': isVendor,
      'vendorID': vendorID,
      'userID': userID,
      'email': email,
      'color': color,
      'businessProfileUploaded': businessProfileUploaded,
      'phoneNumber': phoneNumber,
      'userName': userName,
      'businessPicture': businessPicture,
      'businessName': businessName,
      'physicalAddress': physicalAddress,
      'accountNumber': accountNumber,
    };
  }
}
