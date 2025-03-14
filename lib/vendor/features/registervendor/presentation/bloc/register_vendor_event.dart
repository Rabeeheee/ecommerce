part of 'register_vendor_bloc.dart';

sealed class RegisterVendorEvent extends Equatable {
  const RegisterVendorEvent();

  @override
  List<Object> get props => [];
}

final class SendRequestForVendorEvent extends RegisterVendorEvent {
  final User user;
  final String businessName;
  final dynamic businessPicuture;
  final String physicalAddress;
  final String accountNumber;
  const SendRequestForVendorEvent(
      {required this.user,
      required this.businessPicuture,
      required this.businessName,
      required this.physicalAddress,
      required this.accountNumber});
}

final class CheckForVendorStatusEvent extends RegisterVendorEvent {
  final String vendorID;
  const CheckForVendorStatusEvent({required this.vendorID});
}
