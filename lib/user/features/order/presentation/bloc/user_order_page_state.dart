part of 'user_order_page_bloc.dart';

sealed class UserOrderPageState extends Equatable {
  const UserOrderPageState();

  @override
  List<Object> get props => [];
}


final class UserOrderPageInitial extends UserOrderPageState {}

final class UserOrderPageLoading extends UserOrderPageState {}

final class GetAllOrderListSuccess extends UserOrderPageState {
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

final class GetAllOrderListFailed extends UserOrderPageState {
  final String message;
  const GetAllOrderListFailed({required this.message});
}

//for clicking the delivered button

final class UpdateOrderDelivery extends UserOrderPageState {}

final class UpdateOrderDeliverySuccess extends UserOrderPageState {}

final class UpdateOrderDeliveryFailed extends UserOrderPageState {
  final String message;
  const UpdateOrderDeliveryFailed({required this.message});
}

final class UpdateOrderDeliveryLoading extends UserOrderPageState {}

final class DeliverOrderToAdminSuccess extends UserOrderPageState {}

final class DeliverOrderToAdminFailed extends UserOrderPageState {
  final String message;
  const DeliverOrderToAdminFailed({required this.message});
}
