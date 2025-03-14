part of 'register_product_bloc.dart';

sealed class RegisterProductEvent {
  const RegisterProductEvent();
}

final class GetAllCategoryEvent extends RegisterProductEvent {
  final bool refreshPage;

  GetAllCategoryEvent({required this.refreshPage});
}

final class RegisterNewProductEvent extends RegisterProductEvent {
  final String brandName;
  final String brandID;
  final String productName;
  final double productPrize;
  final Map<String, String> specifications;
  final String color;
  final double productOldPrize;
  final int productQuantity;
  final String mainCategory;
  final String mainCategoryID;
  final String subCategory;
  final String subCategoryID;
  final String variantCategory;
  final String variantCategoryID;
  final String productOverview;
  final double shippingCharge;
  final Map<int, List<dynamic>> productImages;
  final bool isPublished;

  RegisterNewProductEvent({
    required this.brandName,
    required this.brandID,
    required this.productName,
    required this.productPrize,
    required this.color,
    required this.productOldPrize,
    required this.productQuantity,
    required this.specifications,
    required this.mainCategory,
    required this.mainCategoryID,
    required this.subCategory,
    required this.subCategoryID,
    required this.variantCategory,
    required this.variantCategoryID,
    required this.productOverview,
    required this.shippingCharge,
    required this.productImages,
    required this.isPublished,
  });
}

final class DeleteTheProductEvent extends RegisterProductEvent {
  final Product product;
  final Map<int, List<model.Image>> mapOfListOfImages;
  DeleteTheProductEvent({
    required this.product,
    required this.mapOfListOfImages,
  });
}

final class UpdateExistingProductEvent extends RegisterProductEvent {
  final Product product;
  final String brandName;
  final String brandID;
  final String productName;
  final double productPrize;
  final double productOldPrize;
  final int productQuantity;
  final String mainCategory;
  final String mainCategoryID;
  final String color;
  final Map<String, String> specifications;
  final String subCategory;
  final String subCategoryID;
  final String variantCategory;
  final String variantCategoryID;
  final String productOverview;
  final double shippingCharge;
  final Map<int, List<dynamic>>? productImages;
  final List<int> deleteImagesIndexes;
  final bool isPublished;

  UpdateExistingProductEvent({
    required this.product,
    required this.specifications,
    required this.brandName,
    required this.brandID,
    required this.productName,
    required this.productPrize,
    required this.productOldPrize,
    required this.color,
    required this.productQuantity,
    required this.mainCategory,
    required this.mainCategoryID,
    required this.subCategory,
    required this.subCategoryID,
    required this.variantCategory,
    required this.variantCategoryID,
    required this.productOverview,
    required this.shippingCharge,
    required this.productImages,
    required this.deleteImagesIndexes,
    required this.isPublished,
  });
}

final class GetAllBrandEvent extends RegisterProductEvent {}
final class OnChangeDynamicFormEvent extends RegisterProductEvent {
  final Map<String, String> data;
  OnChangeDynamicFormEvent({required this.data});
}


