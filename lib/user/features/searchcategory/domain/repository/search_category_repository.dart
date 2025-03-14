import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/core/entities/category.dart';

abstract class SearchCategoryRepository {
    Future<Either<Failure, List<Category>>> getAllCategories(bool refresh);
}