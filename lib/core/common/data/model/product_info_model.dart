import 'package:tech_haven/core/entities/product_info.dart';

class ProductInfoModel extends ProductInfo {
  ProductInfoModel({
    required super.brandName,
    required super.brandID,
    required super.mainCategoryName,
    required super.mainCategoryID,
    required super.subCategoryName,
    required super.subCategoryID,
    required super.variantCategoryName,
    required super.variantCategoryID,
    required super.productID,    required super.color,
    required super.productName,
  });

  factory ProductInfoModel.fromJson(Map<String, dynamic> json) {
    return ProductInfoModel(
      brandName: json['brandName'],   color: json['color'],
      brandID: json['brandID'],
      mainCategoryName: json['mainCategoryName'],
      mainCategoryID: json['mainCategoryID'],
      subCategoryName: json['subCategoryName'],
      subCategoryID: json['subCategoryID'],
      variantCategoryName: json['variantCategoryName'],
      variantCategoryID: json['variantCategoryID'],
      productID: json['productID'],
      productName: json['productName'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'brandName' : brandName,
      'brandID' : brandID,
      'mainCategoryName': mainCategoryName,
      'mainCategoryID': mainCategoryID,
      'subCategoryName': subCategoryName,   'color':color,
      'subCategoryID': subCategoryID,
      'variantCategoryName': variantCategoryName,
      'variantCategoryID': variantCategoryID,
      'productID': productID,
      'productName': productName,
    };
  }
}
