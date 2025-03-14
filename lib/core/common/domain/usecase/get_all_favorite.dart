import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/common/domain/repository/repository.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/core/usecase/usecase.dart';

class GetAllFavorite implements UseCase<List<String>, NoParams> {
  final Repository repository;
  GetAllFavorite({required this.repository});

  @override
  Future<Either<Failure, List<String>>> call(NoParams params) async {
    return await repository.getAllFavorite();
  }
}
