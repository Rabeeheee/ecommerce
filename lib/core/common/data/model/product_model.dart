import 'package:tech_haven/core/entities/product.dart';

class ProductModel extends Product {
  ProductModel({
    required super.brandID,
    required super.productID,
    required super.vendorName,
    required super.brandName,
    required super.displayImageURL,
    required super.color,
    required super.name,
    required super.prize,
    required super.oldPrize,
    required super.vendorID,
    required super.quantity,
    required super.mainCategory,
    required super.mainCategoryID,
    required super.subCategory,
    required super.subCategoryID,
    required super.variantCategory,
    required super.variantCategoryID,
    required super.overview,
    required super.specifications,
    required super.shippingCharge,
    // required super.productImages,
    required super.rating,
    required super.isPublished,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      productID: json['productID'],
      vendorName: json['vendorName'],
      vendorID: json['vendorID'],
      brandName: json['brandName'],
      color: json['color'],
      brandID: json['brandID'],
      displayImageURL: json['displayImageURL'],
      name: json['name'],
      prize: json['prize'] ?? 0.0, // Provide a default value if prize is null
      oldPrize: json['oldPrize'] ??
          0.0, // Provide a default value if oldPrize is null
      quantity: json['quantity'],
      mainCategory: json['mainCategory'],
      mainCategoryID: json['mainCategoryID'],
      subCategory: json['subCategory'],
      subCategoryID: json['subCategoryID'],
      variantCategory: json['variantCategory'],
      variantCategoryID: json['variantCategoryID'],
      overview: json['overview'],
      specifications: json['specifications'] != null
          ? Map<String, String>.from(json['specifications'])
          : null,
      shippingCharge: json['shippingCharge'],
      rating: json['rating'],
      isPublished: json['isPublished'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productID': productID,
      'vendorName': vendorName,
      'brandName': brandName,
      'brandID': brandID,
      'displayImageURL': displayImageURL,
      'vendorID': vendorID,
      'name': name,
      'prize': prize,
      'oldPrize': oldPrize,
      'quantity': quantity,
      'mainCategory': mainCategory,
      'mainCategoryID': mainCategoryID,
      'subCategory': subCategory,
      'color':color,
      'subCategoryID': subCategoryID,
      'variantCategory': variantCategory,
      'variantCategoryID': variantCategoryID,
      'overview': overview,
      'specifications': specifications ?? {},
      'shippingCharge': shippingCharge ?? 0,
      'rating': rating ?? 0,
      'isPublished': isPublished,
    };
  }
}
