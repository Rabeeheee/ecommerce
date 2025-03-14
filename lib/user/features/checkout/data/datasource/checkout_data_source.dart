import 'package:tech_haven/core/common/data/model/address_details_model.dart';
import 'package:tech_haven/core/entities/cart.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/entities/user.dart';
import 'package:tech_haven/user/features/checkout/data/models/payment_intent_model.dart';

abstract class CheckoutDataSource {
  Future<PaymentIntentModel> submitPaymentForm({
    required String name,
    required String address,
    required String pin,
    required String city,
    required String state,
    required String country,
    required String currency,
    required String amount,
  });
  Future<PaymentIntentModel> showPresentPaymentSheet(
      {required PaymentIntentModel paymentIntentModel});
  Future<String> sendOrder({
    required PaymentIntentModel paymentIntentModel,
    required List<Product> products,
    required List<Cart> carts,
    required User user,
  });

  Future<List<AddressDetailsModel>> getAllUserAddress({required String userID});

 Future<void> saveUserAddress({
    required String address,
    required String pin,
    required String city,
    required String state,
    required String country,
  });
}
