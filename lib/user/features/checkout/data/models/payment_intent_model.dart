import 'package:tech_haven/user/features/checkout/data/models/payment_method_options_model.dart';
import 'package:tech_haven/user/features/checkout/data/models/shipping_model.dart';

class PaymentIntentModel {
  final String id;
  final int amount;
  final String currency;
  final String clientSecret;
  final String description;
  final PaymentMethodOptionsModel paymentMethodOptionsModel;
  final ShippingModel shippingModel;
  // final String name;
  // final String address;
  // final String pin;
  // final String city;
  // final String state;
  // final String country;
  // final String totalAmount;

  PaymentIntentModel({
    required this.id,
    required this.amount,
    required this.currency,
    required this.clientSecret,
    required this.description,
    required this.paymentMethodOptionsModel,
    required this.shippingModel,
    // required this.name,
    // required this.address,
    // required this.pin,
    // required this.city,
    // required this.state,
    // required this.country,
    // required this.totalAmount,
  });

  factory PaymentIntentModel.fromJson(Map<String, dynamic> json) {
    return PaymentIntentModel(
      id: json['id'],
      amount: json['amount'],
      clientSecret: json['client_secret'],
      currency: json['currency'],
      description: json['description'],
      paymentMethodOptionsModel:
          PaymentMethodOptionsModel.fromJson(json['payment_method_options']),
      shippingModel: ShippingModel.fromJson(json['shipping']),
      // name: json['name'],
      // address: json['address'],
      // pin: json['pin'],
      // city: json['city'],
      // state: json['state'],
      // country: json['country'],
      // totalAmount: json['totalAmount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
      'currency': currency,
      'client_secret'
      'description': description,
      'payment_method_options': paymentMethodOptionsModel.toJson(),
      // 'name': name,
      'shipping': shippingModel.toJson(),
      // 'totalAmount': totalAmount,
    };
  }
}
