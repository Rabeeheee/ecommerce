
import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/core/usecase/usecase.dart';
import 'package:tech_haven/vendor/features/registerproduct/domain/repository/register_product_repository.dart';

class UpdateExistingProduct
    implements UseCase<bool, UpdateExistingProductParams> {
  final RegisterProductRepository registerProductRepository;
  UpdateExistingProduct({
    required this.registerProductRepository,
  });

  @override
  Future<Either<Failure, bool>> call(UpdateExistingProductParams params) async {
    return await registerProductRepository.updateExistingProduct(
      product: params.product,
      brandName: params.brandName,
      brandID: params.brandID,
      name: params.productName,
      prize: params.productPrize,
      color: params.color,
      oldPrize: params.oldProductPrize,
      quantity: params.productQuantity,
      mainCategory: params.mainCategory,
      mainCategoryID: params.mainCategoryID,
      subCategory: params.subCategory,
      subCategoryID: params.subCategoryID,
      variantCategory: params.variantCategory,
      variantCategoryID: params.variantCategoryID,
      overview: params.productOverview,
      specifications: params.specifications,
      shippingCharge: params.shippingCharge,
      productImages: params.productImages,
      deleteImagesIndexes: params.deleteImagesIndexes,
      isPublished: params.isPublished,
    );
  }
}

class UpdateExistingProductParams {
  final Product product;
  final String brandName;
  final String brandID;
  final String productName;
  final double productPrize;
  final double oldProductPrize;
  final int productQuantity;
  final String color;
  final String mainCategory;
  final String mainCategoryID;
  final String subCategory;
  final String subCategoryID;
  final String variantCategory;
  final String variantCategoryID;
  final String productOverview;
  final Map<String, String>? specifications;
  final double shippingCharge;
  final Map<int, List<dynamic>>? productImages;
  final List<int> deleteImagesIndexes;
  final bool isPublished;

  UpdateExistingProductParams({
    required this.product,
    required this.brandName,
    required this.brandID,
    required this.productName,
    required this.productPrize,required this.color,
    required this.oldProductPrize,
    required this.productQuantity,
    required this.mainCategory,
    required this.mainCategoryID,
    required this.subCategory,
    required this.subCategoryID,
    required this.variantCategory,
    required this.variantCategoryID,
    required this.productOverview,
    required this.specifications,
    required this.shippingCharge,
    required this.productImages,
    required this.deleteImagesIndexes,
    required this.isPublished,
  });
}
