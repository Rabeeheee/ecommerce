class Product {
  final String productID;
  final String vendorName;
  final String vendorID;
  final String brandName;
  final String brandID;
  final String displayImageURL;
  final String name;
  final String color;
  final num prize;
  final num oldPrize;
  final num quantity;
  final String mainCategory;
  final String mainCategoryID;
  final String subCategory;
  final String subCategoryID;
  final String variantCategory;
  final String variantCategoryID;
  final String overview;
  final Map<String, String>? specifications;
  final num? shippingCharge;

  // final Map<int,List<Image>> productImages;
  final num? rating;
  final bool isPublished;

  Product({
    required this.productID,
    required this.color,
    required this.vendorName,
    required this.vendorID,
    required this.brandName,
    required this.brandID,
    required this.displayImageURL,
    required this.name,
    required this.prize,
    required this.oldPrize,
    required this.quantity,
    required this.mainCategory,
    required this.mainCategoryID,
    required this.subCategory,
    required this.subCategoryID,
    required this.variantCategory,
    required this.variantCategoryID,
    required this.overview,
    required this.specifications,
    required this.shippingCharge,
    // required this.productImages,
    required this.rating,
    required this.isPublished,
  });
}
