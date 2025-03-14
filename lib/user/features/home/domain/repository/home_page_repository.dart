import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/common/data/model/category_model.dart';
import 'package:tech_haven/core/entities/banner.dart';
import 'package:tech_haven/core/entities/trending_product.dart';

import '../../../../../core/error/failures.dart';

abstract class HomePageRepository {
  // Future<Either<Failure, List<Product>>> getAllProducts();
  Future<Either<Failure, List<Banner>>> getAllBanners();
  // Future<Either<Failure, bool>> updateProductToFavorite({
  //   required bool isFavorited,
  //   required Product product,
  // });
  // Future<Either<Failure, List<String>>> getAllFavoritedProducts();
  // Future<Either<Failure, List<Cart>>> updateProductToCart({
  //   required int itemCount,
  //   required Product product,
  //   required Cart? cart,
  // });
  Future<Either<Failure, TrendingProduct>> getTrendingProduct();
    Future<Either<Failure, List<CategoryModel>>> getAllSubCategories();
}
