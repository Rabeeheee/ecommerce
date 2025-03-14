import 'package:tech_haven/core/entities/product_order.dart';

class ProductOrderModel extends ProductOrder {
  // If ProductOrder class has these fields, then no need to redefine them here
  // final String productID;
  // final int quantity;
  // final double price;

  ProductOrderModel({
    required super.vendorID,
    required super.color,
    required super.productID,
    required super.shippingCharge,
    required super.productName,
    required super.quantity,
    required super.price,
  });

  factory ProductOrderModel.fromJson(Map<String, dynamic> json) {
    return ProductOrderModel(
      productName: json['productName'],
      vendorID: json['vendorID'],
      shippingCharge: json['shippingCharge'],
      productID: json['productID'],
      color: json['color'] ?? 1,
      quantity: json['quantity'] ,
      price: json['price'] 
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'vendorID': vendorID,
      'shippingCharge': shippingCharge,
      'productID': productID,
      'quantity': quantity,
      'productName': productName,
      'color': color,
      'price': price,
    };
  }
}
