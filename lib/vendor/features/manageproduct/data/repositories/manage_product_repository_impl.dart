import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/error/exceptions.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/vendor/features/manageproduct/data/datasource/manage_product_data_source.dart';
import 'package:tech_haven/vendor/features/manageproduct/domain/repository/manage_product_repository.dart';

class ManageProductRepositoryImpl extends ManageProductRepository {
  final ManageProductDataSource manageProductDataSource;
  ManageProductRepositoryImpl({required this.manageProductDataSource});

  @override
  Future<Either<Failure, List<Product>>> getAllProducts() async {
    try {
      final result = await manageProductDataSource.getAllProducts();
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> updateTheProductPublish(
      {required Product product, required bool publish}) async {
    try {
      final result = await manageProductDataSource.updateTheProductPublish(
          product: product, publish: publish);
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
