import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/entities/cart.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/entities/user.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/core/usecase/usecase.dart';
import 'package:tech_haven/user/features/checkout/data/models/payment_intent_model.dart';
import 'package:tech_haven/user/features/checkout/domain/repository/checkout_repository.dart';

class SendOrder implements UseCase<dynamic, SendOrderParams> {
  final CheckoutRepository checkoutRepository;
  SendOrder({required this.checkoutRepository});

  @override
  Future<Either<Failure, String>> call(SendOrderParams params) async {
    return await checkoutRepository.sendOrder(
        paymentIntentModel: params.paymentIntentModel,
        user: params.user,
        products: params.products,
        carts: params.carts,
        );
  }
}

class SendOrderParams {
  final PaymentIntentModel paymentIntentModel;
  final User user;
  final List<Product> products;
  final List<Cart> carts;

  SendOrderParams({
    required this.paymentIntentModel,required this.user,
    required this.products,
    required this.carts,
  });
}
