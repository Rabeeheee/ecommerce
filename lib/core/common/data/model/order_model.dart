import 'package:tech_haven/core/common/data/model/product_order_model.dart';
import 'package:tech_haven/core/entities/order.dart';

class OrderModel extends Order {
  OrderModel({
    required super.orderID,
    required super.orderDate,
    required super.deliveryDate,   
    // required super.shippingCharge,
    required super.products,
    required super.deliveredProducts,
    required super.totalAmount,
    required super.userID,
    required super.name,
    required super.paymentID,
    required super.address,
    required super.pin,
    required super.city,
    required super.state,
    required super.country,
    required super.currency,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    // print(json['totalAmount'].runtimeType);
    return OrderModel(
      orderID: json['orderID'],  
      deliveryDate: DateTime.parse(json['deliveryDate']),
      orderDate: DateTime.parse(json['orderDate']),
      products: (json['products'] as List)
          .map((productJson) => ProductOrderModel.fromJson(productJson))
          .toList(),
      totalAmount: json['totalAmount'] as int,
      deliveredProducts: (json['deliveredProducts'] as List)
          .map((productJson) => ProductOrderModel.fromJson(productJson))
          .toList(),
      userID: json['userID'],
      paymentID: json['paymentID'],
      name: json['name'],
      // shippingCharge: json['shippingCharge'],
      address: json['address'],
      pin: json['pin'],
      city: json['city'],
      state: json['state'],
      country: json['country'],
      currency: json['currency'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'orderID': orderID,   
      'orderDate': orderDate.toIso8601String(),
      'products': products.map((product) => product.toJson()).toList(),
      'deliveredProducts':
          deliveredProducts.map((products) => products.toJson()).toList(),
      'totalAmount': totalAmount,
      'deliveryDate': deliveryDate.toIso8601String(),
      'userID': userID,
      'paymentID': paymentID,
      'name': name,
      // 'shippingCharge': shippingCharge,
      'address': address,
      'pin': pin,
      'city': city,
      'state': state,
      'country': country,
      'currency': currency,
    };
  }
}
