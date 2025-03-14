
import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/core/usecase/usecase.dart';
import 'package:tech_haven/user/features/checkout/data/models/payment_intent_model.dart';

import '../repository/checkout_repository.dart';

class SubmitPaymentForm implements UseCase<PaymentIntentModel, SubmitPaymentFormParams> {
  final CheckoutRepository checkoutRepository;
  SubmitPaymentForm({required this.checkoutRepository});

  @override
  Future<Either<Failure, PaymentIntentModel>> call(SubmitPaymentFormParams params) async {
    return await checkoutRepository.submitPaymentForm(
        name: params.name,
        address: params.address,
        pin: params.pin,
        city: params.city,
        state: params.state,
        country: params.country,
        currency: params.currency,
        amount: params.amount);
  }
}

class SubmitPaymentFormParams {
  final String name;
  final String address;
  final String pin;
  final String city;
  final String state;
  final String country;
  final String currency;
  final String amount;

  SubmitPaymentFormParams(
      {required this.name,
      required this.address,
      required this.pin,
      required this.city,
      required this.state,
      required this.country,
      required this.currency,
      required this.amount});
}
