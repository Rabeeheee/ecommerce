part of 'vendor_order_details_bloc.dart';

sealed class VendorOrderDetailsEvent extends Equatable {
  const VendorOrderDetailsEvent();

  @override
  List<Object> get props => [];
}

final class GetAllOrderedProductsEvent extends VendorOrderDetailsEvent {
  final List<ProductOrder> listOfOrderModel;
  const GetAllOrderedProductsEvent({required this.listOfOrderModel});
}
