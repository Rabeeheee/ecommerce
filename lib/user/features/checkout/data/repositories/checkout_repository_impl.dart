import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/entities/address_details.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/entities/user.dart';
import 'package:tech_haven/core/error/exceptions.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/user/features/checkout/data/datasource/checkout_data_source.dart';
import 'package:tech_haven/user/features/checkout/data/models/payment_intent_model.dart';
import 'package:tech_haven/user/features/checkout/domain/repository/checkout_repository.dart';

import '../../../../../core/entities/cart.dart';

class CheckoutRepositoryImpl extends CheckoutRepository {
  final CheckoutDataSource checkoutDataSource;
  CheckoutRepositoryImpl({required this.checkoutDataSource});
  @override
  Future<Either<Failure, PaymentIntentModel>> submitPaymentForm({
    required String name,
    required String address,
    required String pin,
    required String city,
    required String state,
    required String country,
    required String currency,
    required String amount,
  }) async {
    try {
      final result = await checkoutDataSource.submitPaymentForm(
          name: name,
          address: address,
          pin: pin,
          city: city,
          state: state,
          country: country,
          currency: currency,
          amount: amount);
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, PaymentIntentModel>> showPresentPaymentSheet(
      {required PaymentIntentModel paymentIntentModel}) async {
    try {
      final result = await checkoutDataSource.showPresentPaymentSheet(
          paymentIntentModel: paymentIntentModel);
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> sendOrder({
    required PaymentIntentModel paymentIntentModel,
    required List<Product> products,
    required List<Cart> carts,
    required User user,
  }) async {
    try {
      final result = await checkoutDataSource.sendOrder(
          paymentIntentModel: paymentIntentModel,
          products: products,
          carts: carts,
          user: user);
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<AddressDetails>>> getAllUserAddress({required String userID})async {
       try {
      final result = await checkoutDataSource.getAllUserAddress(userID: userID);
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
  
  @override
  Future<Either<Failure, void>> saveUserAddress({required String address, required String pin, required String city, required String state, required String country})async {
   try {
      await checkoutDataSource.saveUserAddress(
        address: address,
        pin: pin,
        city: city,
        state: state,
        country: country,
      );
      return right((null));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
