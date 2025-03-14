
import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/core/usecase/usecase.dart';
import 'package:tech_haven/vendor/features/registerproduct/domain/repository/register_product_repository.dart';

class RegisterNewProduct implements UseCase<bool, RegisterNewProductParams> {
  final RegisterProductRepository registerProductRepository;
  RegisterNewProduct({
    required this.registerProductRepository,
  });

  @override
  Future<Either<Failure, bool>> call(RegisterNewProductParams params) async {
    return await registerProductRepository.registerNewProduct(
      brandName: params.brandName,
      brandID: params.brandID,
      oldPrize: params.oldPrize,color:params.color ,
      name: params.productName,
      prize: params.productPrize,
      quantity: params.productQuantity,
      // vendorID: params.vendorID,
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
      isPublished: params.isPublished,
    );
  }
}

class RegisterNewProductParams {
  final String brandName;
  final String brandID;
  final String productName;
  final double productPrize;
  final double oldPrize;
  final int productQuantity;
  final String mainCategory;
  final String mainCategoryID;
  // final String vendorID;
  final String subCategory;final String color;
  final String subCategoryID;
  final String variantCategory;
  final String variantCategoryID;
  final String productOverview;
  final Map<String, String>? specifications;
  final double shippingCharge;
  final Map<int, List<dynamic>> productImages;
  final bool isPublished;

  RegisterNewProductParams({
    required this.brandName,
    required this.brandID,
    required this.productName,required this.color,
    // required this.vendorID,
    required this.productPrize,
    required this.oldPrize,
  
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
    required this.isPublished,
  });
}
