import 'package:tech_haven/core/entities/product_review.dart';



class ProductReviewModel extends ProductReview {
  ProductReviewModel({
    required super.productID,
    required super.productName,
    required super.vendorID,
    required super.vendorName,
    // required super.totalReviews,
    // required super.totalRating,
  });

  factory ProductReviewModel.fromJson(Map<String, dynamic> json) {
    return ProductReviewModel(
      productID: json['productID'],
      productName: json['productName'],
      vendorID: json['vendorID'],
      // totalReviews: json['totalReviews'],
      vendorName: json['vendorName'],
      // totalRating: json['totalRating'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productID': productID,
      'productName': productName,
      'vendorID': vendorID,
      // 'totalReviews' : totalReviews,
      'vendorName': vendorName,
      // 'totalRating': totalRating,
    };
  }
}
