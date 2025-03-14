part of 'vendor_order_page_bloc.dart';

sealed class VendorOrderPageState extends Equatable {
  const VendorOrderPageState();

  @override
  List<Object> get props => [];
}

final class VendorOrderPageInitial extends VendorOrderPageState {}

final class VendorOrderPageLoading extends VendorOrderPageState {}

final class GetAllOrderListSuccess extends VendorOrderPageState {
  final List<Product> listOfOrderedProducts;
  final List<model.Order> listOfOrderDetails;
  // final List<ProductOrder> listOfProductOrder;
  const GetAllOrderListSuccess(
      {
        required this.listOfOrderedProducts,
       required this.listOfOrderDetails,
      //  required this.listOfProductOrder
       });
}

final class GetAllOrderListFailed extends VendorOrderPageState {
  final String message;
  const GetAllOrderListFailed({required this.message});
}

//for clicking the delivered button

final class UpdateOrderDelivery extends VendorOrderPageState {}

final class UpdateOrderDeliverySuccess extends VendorOrderPageState {}

final class UpdateOrderDeliveryFailed extends VendorOrderPageState {
  final String message;
  const UpdateOrderDeliveryFailed({required this.message});
}

final class UpdateOrderDeliveryLoading extends VendorOrderPageState {}

final class DeliverOrderToAdminSuccess extends VendorOrderPageState {}

final class DeliverOrderToAdminFailed extends VendorOrderPageState {
  final String message;
  const DeliverOrderToAdminFailed({required this.message});
}
