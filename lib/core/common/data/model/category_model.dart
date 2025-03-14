import 'package:tech_haven/core/entities/category.dart';

class CategoryModel extends Category {
  CategoryModel({
    required super.id,
    required super.categoryName,
    required super.imageURL,
    required super.subCategories,
  });

    factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
      id: json['id'],
      categoryName: json['categoryName'],
      imageURL: json['imageURL'],
      subCategories: []);

  Map<String, dynamic> toJson() => {
        'id': id,
        'categoryName': categoryName,
        'imageURL': imageURL,
      };
}
