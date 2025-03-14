import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/entities/address_details.dart';
import 'package:tech_haven/core/entities/cart.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/entities/user.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/user/features/checkout/data/models/payment_intent_model.dart';

abstract class CheckoutRepository {
  Future<Either<Failure, PaymentIntentModel>> submitPaymentForm({
    required String name,
    required String address,
    required String pin,
    required String city,
    required String state,
    required String country,
    required String currency,
    required String amount,
  });
  Future<Either<Failure, PaymentIntentModel>> showPresentPaymentSheet({
    required PaymentIntentModel paymentIntentModel,
  });
  Future<Either<Failure, String>> sendOrder({
    required PaymentIntentModel paymentIntentModel,
    required List<Product> products,
    required List<Cart> carts,
    required User user,
  });
  Future<Either<Failure, List<AddressDetails>>> getAllUserAddress(
      {required String userID});

 Future<Either<Failure, void>> saveUserAddress({
    required String address,
    required String pin,
    required String city,
    required String state,
    required String country,
  });
}
