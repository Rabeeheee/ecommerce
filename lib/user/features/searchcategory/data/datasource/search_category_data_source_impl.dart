import 'package:tech_haven/core/common/data/datasource/data_source.dart';
import 'package:tech_haven/core/error/exceptions.dart';
import 'package:tech_haven/user/features/searchcategory/data/datasource/search_category_data_source.dart';
import 'package:tech_haven/core/common/data/model/category_model.dart';

class SearchCategoryDataSourceImpl implements SearchCategoryDataSource {
  final DataSource dataSource;
  SearchCategoryDataSourceImpl({required this.dataSource});
  @override
  Future<List<CategoryModel>> getAllCategoryModel(bool refresh) async {
    try {
      final listOfCategories = await dataSource.getAllCategory(refresh);
      return listOfCategories;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
