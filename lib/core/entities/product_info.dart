class ProductInfo {
  final String brandName;
  final String brandID;
  final String mainCategoryName;
  final String mainCategoryID;
  final String subCategoryName;
  final String subCategoryID;
  final String variantCategoryName;
  final String variantCategoryID;
  final String productID;
  final String productName;
  final int color;

  ProductInfo({
    required this.brandID,
    required this.brandName,
    required this.mainCategoryName,
    required this.mainCategoryID,
    required this.subCategoryName,
    required this.subCategoryID,
    required this.variantCategoryName,
    required this.variantCategoryID,
    required this.productID,
    required this.productName,
    required this.color
  });
}
