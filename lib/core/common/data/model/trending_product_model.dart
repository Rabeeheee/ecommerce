import 'package:tech_haven/core/entities/trending_product.dart';

class TrendingProductModel extends TrendingProduct {
  TrendingProductModel({
    required super.trendingText,
    required super.productID,
    required super.productImageURL,
    required super.trendingImageID,
    required super.productName,
  });

  factory TrendingProductModel.fromJson(Map<String, dynamic> json) {
    return TrendingProductModel(
      trendingText: json['TrendingText'],
      productID: json['productID'],
      trendingImageID: json['trendingImageID'],
      productImageURL: json['productImageURL'],
      productName: json['productName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'TrendingText': trendingText,
      'productID': productID,
      'trendingImageID': trendingImageID,
      'productImageURL': productImageURL,
      'productName': productName,
    };
  }
}
