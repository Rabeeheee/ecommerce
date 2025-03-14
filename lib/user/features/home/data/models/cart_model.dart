import 'package:tech_haven/core/entities/cart.dart';

class CartModel extends Cart {
  CartModel({
    required super.cartID,
    required super.productID,
    required super.productCount,
    required super.color,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
      cartID: json['cartID'],
      color: json['color'],
      productID: json['productID'],
      productCount: json['productCount']);

  Map<String, dynamic> toJson() => {
        'cartID': cartID,
        'productID': productID,
        'color':color,
        'productCount': productCount,
      };
}
