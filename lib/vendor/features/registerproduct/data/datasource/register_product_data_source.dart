
import 'package:tech_haven/core/common/data/model/category_model.dart';
import 'package:tech_haven/core/entities/image.dart' as model;
import 'package:tech_haven/core/entities/product.dart';

abstract class RegisterProductDataSource {
  Future<List<CategoryModel>> getAllCategoryModel(bool refresh);
  Future<bool> registerNewProduct({
    required String brandName,
    required String brandID,
    required String name,
    required double prize,
    required double oldPrize,
    required int quantity,
    // required String vendorID,
    required String mainCategory,
    required String mainCategoryID,
    required String subCategory,
    required String subCategoryID,
    required String color,
    required String variantCategory,
    required String variantCategoryID,
    required String overview,
    required Map<String, String>? specifications,
    required double? shippingCharge,
    required Map<int, List<dynamic>> productImages,
    required bool isPublished,
  });
  // Future<Map<int, List<model.Image>>> getImagesForTheProduct(
  //     {required String productID});

  Future<bool> deleteProduct(
      {required Product productModel,
      required Map<int, List<model.Image>> mapOfListOfImages});

  Future<bool> updateExistingProduct({
    required Product product,
    required String brandName,
    required String brandID,
    required String name,
    required double prize,
    required double oldPrize,
    required int quantity,
    required String mainCategory,
    required String mainCategoryID,
    required String subCategory,required String color,
    required String subCategoryID,
    required String variantCategory,
    required String variantCategoryID,
    required String overview,
    required Map<String, String>? specifications,
    required double? shippingCharge,
    required Map<int, List<dynamic>>? productImages,
    required List<int> deleteImagesIndexes,
    required bool isPublished,
  });

  Future<List<CategoryModel>> getAllBrands();
}
