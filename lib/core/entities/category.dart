class Category {
  final String id;
  final String categoryName;
  final String imageURL;
  List<Category> subCategories;
  Category({
    required this.id,
    required this.categoryName,
    required this.imageURL,
    required this.subCategories,
  });
}
