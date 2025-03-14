import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/error/exceptions.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/core/entities/category.dart';
import 'package:tech_haven/user/features/searchcategory/data/datasource/search_category_data_source.dart';
import 'package:tech_haven/user/features/searchcategory/domain/repository/search_category_repository.dart';

class SearchCategoryRepositoryImpl implements SearchCategoryRepository {
  final SearchCategoryDataSource searchCategoryDataSource;
  SearchCategoryRepositoryImpl({required this.searchCategoryDataSource});
  @override
  Future<Either<Failure, List<Category>>> getAllCategories(bool refresh) async {
    try {
      final result = await searchCategoryDataSource.getAllCategoryModel(refresh);
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
