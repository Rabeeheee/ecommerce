import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/common/domain/repository/repository.dart';
import 'package:tech_haven/core/entities/cart.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/core/usecase/usecase.dart';

class UpdateProductToCart
    implements UseCase<bool, UpdateProductToCartParams> {
  final Repository repository;
  UpdateProductToCart({required this.repository});

  @override
  Future<Either<Failure, bool>> call(
      UpdateProductToCartParams params) async {
    return await repository.updateProductToCart(itemCount: params.itemCount, product: params.product,cart: params.cart);
  }
}

class UpdateProductToCartParams {
  final int itemCount;
  final Product product;
  final Cart? cart;
  UpdateProductToCartParams(
      {required this.itemCount, required this.product,required this.cart,});
}
