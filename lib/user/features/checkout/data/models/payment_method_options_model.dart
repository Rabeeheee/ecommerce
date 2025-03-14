import 'package:tech_haven/user/features/checkout/data/models/card_options_model.dart';

class PaymentMethodOptionsModel {
  final CardOptionsModel cardOptionsModel;

  PaymentMethodOptionsModel({required this.cardOptionsModel});

  factory PaymentMethodOptionsModel.fromJson(Map<String, dynamic> json) {
    return PaymentMethodOptionsModel(
      cardOptionsModel: CardOptionsModel.fromJson(json['card']),
    );
  }

  Map<String, dynamic> toJson() {
    // print(cardOptionsModel.network)
    return {
      'card': cardOptionsModel.toJson(),
    };
  }
}
