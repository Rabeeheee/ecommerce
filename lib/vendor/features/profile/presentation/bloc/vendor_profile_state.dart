part of 'vendor_profile_bloc.dart';

sealed class VendorProfileState extends Equatable {
  const VendorProfileState();

  @override
  List<Object> get props => [];
}

class VendorProfileInitial extends VendorProfileState {}

class VendorProfileLoading extends VendorProfileState {}

class VendorProfileLoaded extends VendorProfileState {
  final Vendor vendor;

  const VendorProfileLoaded(this.vendor);
}

class VendorProfileError extends VendorProfileState {
  final String message;

  const VendorProfileError(this.message);
}
