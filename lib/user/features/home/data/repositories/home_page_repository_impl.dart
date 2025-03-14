import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/common/data/model/category_model.dart';
import 'package:tech_haven/core/entities/banner.dart';
import 'package:tech_haven/core/entities/trending_product.dart';
import 'package:tech_haven/core/error/exceptions.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/user/features/home/data/datasource/home_page_data_source.dart';
import 'package:tech_haven/user/features/home/domain/repository/home_page_repository.dart';

class HomePageRepositoryImpl extends HomePageRepository {
  final HomePageDataSource homePageDataSource;
  HomePageRepositoryImpl({required this.homePageDataSource});

  // @override
  // Future<Either<Failure, List<Product>>> getAllProducts() async {
  //   try {
  //     final result = await homePageDataSource.getAllProducts();
  //     print(result);
  //     return right(result);
  //   } on ServerException catch (e) {
  //     print(e);
  //     return left(Failure(e.message));
  //   }
  // }

  @override
  Future<Either<Failure, List<Banner>>> getAllBanners() async {
    try {
      final result = await homePageDataSource.getAllBanners();
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, TrendingProduct>> getTrendingProduct() async {
    try {
      final product = await homePageDataSource.fetchTrendingProduct();
      return right(product);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CategoryModel>>> getAllSubCategories() async {
    try {
      // print('updating the favorite');
      final result = await homePageDataSource.getAllSubCategories();
      // print('hello how are you');
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
