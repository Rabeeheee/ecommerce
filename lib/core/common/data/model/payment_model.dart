import 'package:tech_haven/core/entities/payment.dart';

class PaymentModel extends Payment {
  PaymentModel({
    required super.paymentID,
    required super.userID,
    required super.userName,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(userID: json['userID'], userName: json['userName'],paymentID: json['paymentID']);
  }
  Map<String, dynamic> toJson() => {
    'paymentID': paymentID,
        'userID': userID,
        'userName': userName,
      };
}
