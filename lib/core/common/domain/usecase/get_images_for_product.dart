import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/common/domain/repository/repository.dart';
import 'package:tech_haven/core/entities/image.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/core/usecase/usecase.dart';

class GetImagesForProduct implements UseCase<Map<int,List<Image>>, GetImagesForProductParams> {
  final Repository repository;
  GetImagesForProduct({
    required this.repository,
  });

  @override
  Future<Either<Failure, Map<int,List<Image>>>> call(GetImagesForProductParams params) async {
    return await repository.getImagesForProduct(productID:params.productID);
  }
}

class GetImagesForProductParams {
  final String productID;
  GetImagesForProductParams({required this.productID});
}
