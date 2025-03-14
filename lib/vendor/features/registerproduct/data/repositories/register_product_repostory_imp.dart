
import 'package:tech_haven/core/entities/image.dart' as model;
import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/entities/category.dart';
// import 'package:tech_haven/core/entities/image.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/error/exceptions.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/vendor/features/registerproduct/data/datasource/register_product_data_source.dart';
import 'package:tech_haven/vendor/features/registerproduct/domain/repository/register_product_repository.dart';

class RegisterProductRepositoryImpl extends RegisterProductRepository {
  final RegisterProductDataSource registerProductDataSource;
  RegisterProductRepositoryImpl({required this.registerProductDataSource});
  @override
  Future<Either<Failure, List<Category>>> getAllCategories(bool refresh) async {
    try {
      final result =
          await registerProductDataSource.getAllCategoryModel(refresh);
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> registerNewProduct({
    required String brandName,
    required String brandID,
    required String name,
    required double prize,
    required double oldPrize,
    required int quantity,
    required String mainCategory,
    // required String vendorID,
    required String mainCategoryID,
    required String subCategory,
    required String subCategoryID,
    required String variantCategory,
    required String variantCategoryID,
    required String overview,
    required Map<String, String>? specifications,
    required double? shippingCharge,required String color,
    required Map<int, List<dynamic>> productImages,
    required bool isPublished,
  }) async {
    try {
      final result = await registerProductDataSource.registerNewProduct(
        brandName: brandName,
        brandID: brandID,
        oldPrize: oldPrize,
        name: name,color: color,
        prize: prize,
        quantity: quantity,
        mainCategory: mainCategory,
        mainCategoryID: mainCategoryID,
        subCategory: subCategory,
        subCategoryID: subCategoryID,
        variantCategory: variantCategory,
        variantCategoryID: variantCategoryID,
        overview: overview,
        specifications: specifications,
        shippingCharge: shippingCharge,
        productImages: productImages,
        isPublished: isPublished,
      );
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  // @override
  // Future<Either<Failure, Map<int, List<Image>>>> getImagesForTheProduct(
  //     String productID) async {
  //   try {
  //     final result = await registerProductDataSource.getImagesForTheProduct(
  //         productID: productID);
  //     return right(result);
  //   } on ServerException catch (e) {
  //     return left(Failure(e.message));
  //   }
  // }

  @override
  Future<Either<Failure, bool>> deleteProduct(
      {required Product product,
      required Map<int, List<model.Image>> mapOfListOfImages}) async {
    try {
      final result = await registerProductDataSource.deleteProduct(
          productModel: product, mapOfListOfImages: mapOfListOfImages);
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> updateExistingProduct(
      {required Product product,
      required String brandName,
      required String brandID,
      required String name,
      required double prize,
      required double oldPrize,
      required int quantity,
      required String mainCategory,
      required String mainCategoryID,
      required String subCategory,
      required String subCategoryID,
      required String variantCategory,
      required String variantCategoryID,required String color,
      required String overview,
      required Map<String, String>? specifications,
      required double? shippingCharge,
      required Map<int, List<dynamic>>? productImages,
      required List<int> deleteImagesIndexes,
      required bool isPublished}) async {
    try {
      final result = await registerProductDataSource.updateExistingProduct(
        product: product,
        brandName: brandName,
        brandID: brandID,
        name: name,
        prize: prize,
        oldPrize: oldPrize,
        quantity: quantity,color: color,
        mainCategory: mainCategory,
        mainCategoryID: mainCategoryID,
        subCategory: subCategory,
        subCategoryID: subCategoryID,
        variantCategory: variantCategory,
        variantCategoryID: variantCategoryID,
        overview: overview,
        specifications: specifications,
        shippingCharge: shippingCharge,
        productImages: productImages,
        deleteImagesIndexes: deleteImagesIndexes,
        isPublished: isPublished,
      );
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Category>>> getAllBrands() async {
    try {
      final result = await registerProductDataSource.getAllBrands();
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
