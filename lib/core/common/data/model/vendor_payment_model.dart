import 'package:tech_haven/core/entities/vendor_payment.dart';

class VendorPaymentModel extends VendorPayment {
  VendorPaymentModel(
      {required super.dateTime,
      required super.paymentID,
      required super.totalAmount,
      required super.orderID,
      required super.vendorID});

  factory VendorPaymentModel.fromJson(Map<String, dynamic> json) {
    // print(json['DateTime']);
    // print(DateTime.parse(json['DateTime']));
    return VendorPaymentModel(
      dateTime: DateTime.parse(json['DateTime']),
      vendorID: json['vendorID'],
      paymentID: json['paymentID'],
      orderID: json['orderID'],
      totalAmount: json['totalAmount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'vendorID': vendorID,
      'DateTime': dateTime.toIso8601String(),
      'paymentID': paymentID,
      'orderID': orderID,
      'totalAmount': totalAmount,
    };
  }
}
