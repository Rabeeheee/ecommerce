import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/common/domain/repository/repository.dart';
import 'package:tech_haven/core/entities/category.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/core/usecase/usecase.dart';

class GetAllBrands implements UseCase<List<Category>, NoParams> {
  final Repository repository;
  GetAllBrands({
    required this.repository,
  });

  @override
  Future<Either<Failure, List<Category>>> call(NoParams params) async {
    return await repository.getAllBrands();
  }
}