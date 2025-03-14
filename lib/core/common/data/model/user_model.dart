import 'package:tech_haven/core/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.isVendor,
    required super.isProfilePhotoUploaded,
    required super.uid,
    required super.userImageID,
    required super.phoneNumber,
    required super.userAllowed,
    required super.username,
    required super.currency,
    required super.currencySymbol,
    required super.email,
    required super.profilePhoto,
    required super.color,
    required super.vendorID,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      userImageID: json['userImageID'],
      phoneNumber: json['phoneNumber'],
      username: json['username'],
      currency: json['currency'],
      userAllowed: json['userAllowed'],
      currencySymbol: json['currencySymbol'],
      email: json['email'],
      vendorID: json['vendorID'],
      profilePhoto: json['profilePhoto'],
      isVendor: json['isVendor'],
      isProfilePhotoUploaded: json['isProfilePhotoUploaded'],
      color: json['color'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'phoneNumber': phoneNumber,
      'username': username,
      'userAllowed': userAllowed,
      'currency': currency,
      'userImageID' : userImageID,
      'vendorID': vendorID,
      'currencySymbol': currencySymbol,
      'email': email,
      'profilePhoto': profilePhoto,
      'isVendor': isVendor,
      'isProfilePhotoUploaded': isProfilePhotoUploaded,
      'color': color,
    };
  }
}
