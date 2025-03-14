import 'package:tech_haven/core/common/data/model/category_model.dart';
import 'package:tech_haven/core/entities/trending_product.dart';
import 'package:tech_haven/user/features/home/data/models/banner_model.dart';

abstract class HomePageDataSource {
  // Future<List<ProductModel>> getAllProducts();
  Future<List<BannerModel>> getAllBanners(); Future<TrendingProduct> fetchTrendingProduct();
    Future<List<CategoryModel>> getAllSubCategories();
}
