import 'package:tech_haven/core/entities/location.dart';

class LocationModel extends Location {
  LocationModel(
      {
        required super.uid,
        required super.userID,
        required super.name,
      required super.phoneNumber,
      required super.location,
      required super.apartmentHouseNumber,
      required super.emailAddress,
      required super.addressInstructions});
  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      uid: json['uid'],
      userID: json['userID'],
        name: json['name'],
        phoneNumber: json['phoneNumber'],
        location: json['location'],
        apartmentHouseNumber: json['apartmentHouseNumber'],
        emailAddress: json['emailAddress'],
        addressInstructions: json['addressInstructions']);
  }

  Map<String, dynamic> toJson() {
    return {
      'uid' : uid,
      'userID' : userID,
      'name': name,
      'phoneNumber': phoneNumber,
      'location': location,
      'apartmentHouseNumber': apartmentHouseNumber,
      'emailAddress': emailAddress,
      'addressInstructions': addressInstructions,
    };
  }
}
