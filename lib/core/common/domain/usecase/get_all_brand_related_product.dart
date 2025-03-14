import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/common/domain/repository/repository.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/error/failures.dart';

import '../../../usecase/usecase.dart';

class GetAllBrandRelatedProduct implements UseCase<List<Product>, GetAllBrandRelatedProductParams> {
  final Repository repository;
  GetAllBrandRelatedProduct({required this.repository});

  @override
  Future<Either<Failure, List<Product>>> call(GetAllBrandRelatedProductParams params) async {
    return await repository.getAllBrandRelatedProduct(product:params.product );
  }
}

class GetAllBrandRelatedProductParams {
  final Product product;
  GetAllBrandRelatedProductParams({required this.product});
}
