part of 'vendor_order_details_bloc.dart';

sealed class VendorOrderDetailsState extends Equatable {
  const VendorOrderDetailsState();

  @override
  List<Object> get props => [];
}

final class VendorOrderDetailsInitial extends VendorOrderDetailsState {}

final class VendorOrderDetailsLoading extends VendorOrderDetailsState {}

final class GetAllOrderedProductsSuccess extends VendorOrderDetailsState {
  final List<Product> listOfProducts;
  const GetAllOrderedProductsSuccess({required this.listOfProducts});
}

final class GetAllOrderedProductsFailed extends VendorOrderDetailsState {
  final String message;
  const GetAllOrderedProductsFailed({required this.message});
}
