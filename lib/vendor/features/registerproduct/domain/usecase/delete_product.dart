import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/core/usecase/usecase.dart';
import 'package:tech_haven/vendor/features/registerproduct/domain/repository/register_product_repository.dart';
import 'package:tech_haven/core/entities/image.dart' as model;

class DeleteProduct implements UseCase<bool, DeleteProductParams> {
  final RegisterProductRepository registerProductRepository;
  DeleteProduct({
    required this.registerProductRepository,
  });

  @override
  Future<Either<Failure, bool>> call(DeleteProductParams params) async {
    return await registerProductRepository.deleteProduct(
        product: params.product, mapOfListOfImages: params.mapOfListOfImages);
  }
}

class DeleteProductParams {
  final Product product;
  final Map<int, List<model.Image>> mapOfListOfImages;
  DeleteProductParams({required this.product, required this.mapOfListOfImages});
}
