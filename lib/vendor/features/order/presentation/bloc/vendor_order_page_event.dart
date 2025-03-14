part of 'vendor_order_page_bloc.dart';

sealed class VendorOrderPageEvent extends Equatable {
  const VendorOrderPageEvent();

  @override
  List<Object> get props => [];
}

final class GetAllOrdersForVendorEvent extends VendorOrderPageEvent {}

final class UpdateOrderDeliveryEvent extends VendorOrderPageEvent {}

final class ChangeTheDeliveryDateEvent extends VendorOrderPageEvent {
  final DateTime deliveryDate;
  const ChangeTheDeliveryDateEvent({required this.deliveryDate});
}

// final class ProductDeliveredEvent extends VendorOrderPageEvent {
//   final OrderModel orderModel;
//   const ProductDeliveredEvent({required this.orderModel});
// }

final class DeliverOrderToAdminEvent extends VendorOrderPageEvent {
  final Order order;
  // final List<ProductOrderModel> listOfProductOrderModel;
  const DeliverOrderToAdminEvent({
    required this.order,
    // required this.listOfProductOrderModel,
  });
}
