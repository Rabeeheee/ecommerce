import 'package:tech_haven/core/entities/revenue.dart';

class RevenueModel extends Revenue {
  RevenueModel(
      {required super.currentBalance,
      required super.vendorID,
      required super.withdrewAmount});
  factory RevenueModel.fromJson(Map<String, dynamic> json) {
    return RevenueModel(
        // paymentID: json['payment_id'],
        vendorID: json['vendorID'],
        currentBalance: json['currentBalance'],
        // totalIncomeSoFar: json['totalIncomeSoFar'],
        withdrewAmount: json['withdrewAmount']);
  }

  Map<String, dynamic> toJson() {
    return {
      'vendorID': vendorID,
      'currentBalance': currentBalance,
      // 'totalIncomeSoFar': totalIncomeSoFar,
      'withdrewAmount': withdrewAmount,
    };
  }
}
