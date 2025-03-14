import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/common/domain/repository/repository.dart';
import 'package:tech_haven/core/entities/location.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/core/usecase/usecase.dart';

class GetCurrentLocationDetails implements UseCase<Location?, NoParams> {
  final Repository repository;
  GetCurrentLocationDetails({required this.repository});

  @override
  Future<Either<Failure, Location?>> call(NoParams params) async {
    return await repository.getCurrentLocationDetails();
  }
}
