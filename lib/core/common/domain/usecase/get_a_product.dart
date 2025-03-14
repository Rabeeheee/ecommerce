import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/common/domain/repository/repository.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/core/usecase/usecase.dart';

class GetAProduct implements UseCase<Product, GetAProductParams> {
  final Repository repository;
  GetAProduct({required this.repository});

  @override
  Future<Either<Failure, Product>> call(GetAProductParams params) async {
    return await repository.getAProduct(productID: params.productID);
  }
}

class GetAProductParams {
  final String productID;
  GetAProductParams({required this.productID});
}
