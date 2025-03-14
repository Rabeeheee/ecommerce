part of 'user_order_history_page_bloc.dart';
abstract class UserOrderHistoryState {}

class UserOrderHistoryInitial extends UserOrderHistoryState {}

class UserOrderHistoryLoading extends UserOrderHistoryState {}

class UserOrderHistoryLoaded extends UserOrderHistoryState {
  final List<OrderModel> orders;

  UserOrderHistoryLoaded(this.orders);
}

class UserOrderHistoryError extends UserOrderHistoryState {
  final String message;

  UserOrderHistoryError(this.message);
}
