import 'package:tech_haven/core/entities/address_details.dart';

class AddressDetailsModel extends AddressDetails {
  AddressDetailsModel(
      {required super.addressID,
      required super.city,
      required super.country,
      required super.line1,
      required super.postalCode,
      required super.state});

  factory AddressDetailsModel.fromJson(Map<String, dynamic> json) {
    return AddressDetailsModel(
        addressID: json['addressID'],
        city: json['city'],
        country: json['country'],
        line1: json['address'],
        postalCode: json['postalCode'],
        state: json['state']);
  }

  Map<String, dynamic> toJson() {
    return {
      'addressID': addressID,
      'city': city,
      'country': country,
      'address': line1,
      'postalCode': postalCode,
      'state': state,
    };
  }
}
