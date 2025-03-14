
import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/core/usecase/usecase.dart';
import 'package:tech_haven/vendor/features/manageproduct/domain/repository/manage_product_repository.dart';

class GetAllProducts implements UseCase<List<Product>, NoParams> {
  final ManageProductRepository manageProductRepository;
  GetAllProducts({required this.manageProductRepository});

  @override
  Future<Either<Failure, List<Product>>> call(NoParams params) async {
    return manageProductRepository.getAllProducts();
  }
}
