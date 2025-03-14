import 'package:tech_haven/user/features/checkout/data/models/address_model.dart';

class ShippingModel {
  final String name;
  final AddressModel addressModel;

  ShippingModel({required this.addressModel, required this.name});

  factory ShippingModel.fromJson(Map<String, dynamic> json) {
    return ShippingModel(
        addressModel: AddressModel.fromJson(json['address']),
        name: json['name']);
  }

  Map<String, dynamic> toJson() {
    return {
      'address': addressModel,
      'name': name,
    };
  }
}
