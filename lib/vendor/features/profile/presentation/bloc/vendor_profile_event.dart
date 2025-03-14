part of 'vendor_profile_bloc.dart';

sealed class VendorProfileEvent extends Equatable {
  const VendorProfileEvent();

  @override
  List<Object> get props => [];
}

class GetVendorProfileEvent extends VendorProfileEvent {

  const GetVendorProfileEvent();
}
