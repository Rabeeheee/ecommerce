import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/common/domain/repository/repository.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/core/usecase/usecase.dart';

class GetAllFavoritedProduct implements UseCase<List<Product>, NoParams> {
  final Repository repository;
  GetAllFavoritedProduct({required this.repository});

  @override
  Future<Either<Failure, List<Product>>> call(NoParams params) async {
    return await repository.getAllCartProduct();
  }
}
