part of 'register_vendor_bloc.dart';

sealed class RegisterVendorState extends Equatable {
  const RegisterVendorState();

  @override
  List<Object> get props => [];
}

final class RegisterVendorInitial extends RegisterVendorState {}

final class RegisterVendorLoading extends RegisterVendorState {}

final class SendRequestForVendorState extends RegisterVendorState {}

final class SendRequestForVendorSuccess extends SendRequestForVendorState {
  final String vendorID;
  SendRequestForVendorSuccess({required this.vendorID});
}

final class SendRequestForVendorFailed extends SendRequestForVendorState {
  final String message;
  SendRequestForVendorFailed({required this.message});
}

final class CheckForVendorStatusState extends RegisterVendorState {}

final class CheckForVendorStatusSuccess extends CheckForVendorStatusState {
  final Vendor vendor;
  CheckForVendorStatusSuccess({required this.vendor});
}

final class CheckForVendorStatusFailed extends CheckForVendorStatusState {
  final String message;
  CheckForVendorStatusFailed({required this.message});
}
