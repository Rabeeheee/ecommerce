import 'package:tech_haven/core/entities/banner.dart';

class BannerModel extends Banner {
  BannerModel(
      {required super.productID,
      required super.name,
      required super.id,
      required super.imageURL});

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
      id: json['id'],
      productID: json['productID'],
      name: json['name'],
      imageURL: json['imageURL']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'productID': productID,
        'name': name,
        'imageURL': imageURL,
      };
}
