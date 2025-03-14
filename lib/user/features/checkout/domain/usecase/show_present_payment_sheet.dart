import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/core/usecase/usecase.dart';
import 'package:tech_haven/user/features/checkout/data/models/payment_intent_model.dart';
import 'package:tech_haven/user/features/checkout/domain/repository/checkout_repository.dart';

class ShowPresentPaymentSheet implements UseCase<PaymentIntentModel, ShowPresentPaymentSheetParams> {
  final CheckoutRepository checkoutRepository;
  ShowPresentPaymentSheet({required this.checkoutRepository});

  @override
  Future<Either<Failure, PaymentIntentModel>> call(ShowPresentPaymentSheetParams params) async {
    return await checkoutRepository.showPresentPaymentSheet(paymentIntentModel: params.paymentIntentModel);
  }
}

class ShowPresentPaymentSheetParams {
  final PaymentIntentModel paymentIntentModel;
  ShowPresentPaymentSheetParams({required this.paymentIntentModel});
}
