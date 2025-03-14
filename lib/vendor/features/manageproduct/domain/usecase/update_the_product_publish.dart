import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/core/usecase/usecase.dart';
import 'package:tech_haven/vendor/features/manageproduct/domain/repository/manage_product_repository.dart';

class UpdateTheProductPublish
    implements UseCase<void, UpdateTheProductPublishParams> {
  final ManageProductRepository manageProductRepository;
  UpdateTheProductPublish({required this.manageProductRepository});

  @override
  Future<Either<Failure, void>> call(
      UpdateTheProductPublishParams params) async {
    return manageProductRepository.updateTheProductPublish(
      product: params.product,
      publish: params.publish,
    );
  }
}

class UpdateTheProductPublishParams {
  final Product product;
  final bool publish;
  UpdateTheProductPublishParams({required this.product, required this.publish});
}
