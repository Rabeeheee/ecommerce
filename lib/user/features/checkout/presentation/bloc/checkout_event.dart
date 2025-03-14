part of 'checkout_bloc.dart';

sealed class CheckoutEvent extends Equatable {
  const CheckoutEvent();

  @override
  List<Object> get props => [];
}

final class CheckoutInitialEmit extends CheckoutEvent {}

final class SubmitPaymentFormEvent extends CheckoutEvent {
  // final String name;
  final String address;
  final String pin;
  final String city;
  final String state;
  final String country;
  final String currency;
  final String amount;
  // final String pin;

  const SubmitPaymentFormEvent(
      {
      // required this.name,
      required this.address,
      required this.pin,
      required this.city,
      required this.state,
      required this.country,
      required this.currency,
      required this.amount});
}

final class SaveOrderEvent extends CheckoutEvent {
  final PaymentIntentModel paymentIntentModel;
  const SaveOrderEvent({required this.paymentIntentModel});
}

final class ShowPresentPaymentSheetEvent extends CheckoutEvent {
  final PaymentIntentModel paymentIntentModel;
  // final String paymentID;
  // final String amount;
  // final String currency;
  // final String description;
  // final String name;
  // final String address;
  // final String city;
  // final String country;
  // final String postalCode;
  // final String state;

  const ShowPresentPaymentSheetEvent({required this.paymentIntentModel}
      // {required this.paymentID,
      // required this.amount,
      // required this.currency,
      // required this.description,
      // required this.name,
      // required this.address,
      // required this.city,
      // required this.country,
      // required this.postalCode,
      // required this.state}
      );
}

// final class UpdateProductQuantityEvent extends CheckoutEvent{}

final class RemoveAllProductsFromTheCartAndSendOrderEvent
    extends CheckoutEvent {}

final class RemoveTheOrderEvent extends CheckoutEvent {}

class LoadAddresses extends CheckoutEvent {}

final class SelectAddressState extends CheckoutEvent {}

final class SelectAddress extends SelectAddressState {
  final AddressDetails address;
  SelectAddress(this.address);
}

final class UnselectAddress extends SelectAddressState {}

final class SaveUserAddressEvent extends CheckoutEvent {
  final String address;
  final String pin;
  final String city;
  final String state;
  final String country;

  const SaveUserAddressEvent(
      {required this.address,
      required this.pin,
      required this.city,
      required this.state,
      required this.country});
}
