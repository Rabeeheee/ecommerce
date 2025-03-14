part of 'user_order_page_bloc.dart';

sealed class UserOrderPageEvent extends Equatable {
  const UserOrderPageEvent();

  @override
  List<Object> get props => [];
}

final class GetAllOrdersForUserEvent extends UserOrderPageEvent {}

final class UpdateOrderDeliveryEvent extends UserOrderPageEvent {}

final class ChangeTheDeliveryDateEvent extends UserOrderPageEvent {
  final DateTime deliveryDate;
  const ChangeTheDeliveryDateEvent({required this.deliveryDate});
}

// final class ProductDeliveredEvent extends UserOrderPageEvent {
//   final OrderModel orderModel;
//   const ProductDeliveredEvent({required this.orderModel});
// }

final class DeliverOrderToAdminEvent extends UserOrderPageEvent {
  final model.Order order;
  // final List<ProductOrderModel> listOfProductOrderModel;
  const DeliverOrderToAdminEvent({
    required this.order,
    // required this.listOfProductOrderModel,
  });
}
