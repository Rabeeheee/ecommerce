import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/common/domain/repository/repository.dart';
import 'package:tech_haven/core/entities/category.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/core/usecase/usecase.dart';

class GetAllCategory implements UseCase<List<Category>, GetAllCategoryParams> {
  final Repository repository;
  GetAllCategory({required this.repository});

  @override
  Future<Either<Failure, List<Category>>> call(GetAllCategoryParams params) async {
    return await repository.getAllCategory();
  }
}

class GetAllCategoryParams {
  final bool refreshPage;
  GetAllCategoryParams({required this.refreshPage});
}
