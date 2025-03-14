import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/common/domain/repository/repository.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/core/usecase/usecase.dart';

class UpdateProductToFavorite
    implements UseCase<bool, UpdateProductToFavoriteParams> {
  final Repository repository;
  UpdateProductToFavorite({required this.repository});

  @override
  Future<Either<Failure, bool>> call(
      UpdateProductToFavoriteParams params) async {
    return await repository.updateProductToFavorite(isFavorited: params.isFavorited, product: params.product);
  }
}

class UpdateProductToFavoriteParams {
  final bool isFavorited;
  final Product product;

  UpdateProductToFavoriteParams(
      {required this.isFavorited, required this.product});
}
