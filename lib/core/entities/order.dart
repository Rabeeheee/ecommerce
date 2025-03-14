import 'package:tech_haven/core/common/data/model/product_order_model.dart';

class Order {
  final String orderID;
  final DateTime orderDate;
  final DateTime deliveryDate;
  final String paymentID;
  final List<ProductOrderModel> products;
  final List<ProductOrderModel> deliveredProducts;
  // final int shippingCharge;
  final String userID;
  final String name;
  final String address;
  final String pin;
  final String city;
  final String state;
  final String country;
  final String currency;
  final int totalAmount;
  Order({
    required this.orderID,
    required this.orderDate,
    required this.paymentID,
    required this.deliveryDate,
    required this.products,
    required this.deliveredProducts,
    required this.userID,
    required this.name,
    // required this.shippingCharge,
    required this.address,
    required this.pin,
    required this.city,
    required this.state,
    required this.country,
    required this.currency,
    required this.totalAmount,
  });
}

// class OrderModel extends Order {
//   OrderModel({
//     required super.orderID,
//     required super.orderDate,
//     required super.products,
//     required super.totalAmount,
//     required super.userID,
//     required super.shippingAddress,
//   });
// }
//   factory OrderModel.fromJson(Map<String, dynamic> json) {
//     return OrderModel(
//       orderID: json['orderID'],
//       orderDate: DateTime.parse(json['orderDate']),
//       products: (json['products'] as List)
//           .map((productJson) => ProductOrder.fromJson(productJson))
//           .toList(),
//       totalAmount: json['totalAmount'],
//       userID: json['userID'],
//       shippingAddress: json['shippingAddress'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'orderID': orderID,
//       'orderDate': orderDate.toIso8601String(),
//       'products': products.map((product) => product.toJson()).toList(),
//       'totalAmount': totalAmount,
//       'userID': userID,
//       'shippingAddress': shippingAddress,
//     };
//   }
// }