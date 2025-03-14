import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tech_haven/core/common/domain/usecase/get_a_product.dart';
import 'package:tech_haven/core/common/domain/usecase/get_all_orders.dart';
import 'package:tech_haven/core/entities/order.dart'as model;
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/usecase/usecase.dart';

part 'user_order_page_event.dart';
part 'user_order_page_state.dart';

class UserOrderPageBloc extends Bloc<UserOrderPageEvent, UserOrderPageState> {
  final GetAllOrders _getAllOrders;
  // final DeliverOrderToAdmin _deliverOrderToAdmin;
  // final GetUserOrders _getUserOrders;
  UserOrderPageBloc(
      {required GetAllOrders getAllOrders,
      required GetAProduct getAProduct,
      // required GetUserOrders getUserOrders,
      // required DeliverOrderToAdmin deliverOrderToAdmin
      })
      : _getAllOrders = getAllOrders,
        super(UserOrderPageInitial()) {
    on<UserOrderPageEvent>((event, emit) {
      emit(UserOrderPageLoading());
    });
    on<UpdateOrderDeliveryEvent>(_onUpdateOrderDeliveryEvent);
    on<GetAllOrdersForUserEvent>(_onGetAllOrdersForUserEvent);
    on<ChangeTheDeliveryDateEvent>(_onChangeTheDeliveryDateEvent);
    // on<ProductDeliveredEvent>(_onProductDeliveredEvent);
    // on<DeliverOrderToAdminEvent>(_onDeliverOrderToAdminEvent);
  }

  FutureOr<void> _onUpdateOrderDeliveryEvent(
      UpdateOrderDeliveryEvent event, Emitter<UserOrderPageState> emit) {}

  FutureOr<void> _onGetAllOrdersForUserEvent(GetAllOrdersForUserEvent event,
      Emitter<UserOrderPageState> emit) async {
    final allOrders = await _getAllOrders(NoParams());
    // final paymentModel = await _

    //getring all the orders
    List<Product> listOfProducts = [];
    allOrders
        .fold((failed) => emit(GetAllOrderListFailed(message: failed.message)),
            (listOfOrders) {
      emit(GetAllOrderListSuccess(
        listOfOrderedProducts: listOfProducts,
        listOfOrderDetails: listOfOrders,
      ));
    });
  }

  FutureOr<void> _onChangeTheDeliveryDateEvent(
      ChangeTheDeliveryDateEvent event, Emitter<UserOrderPageState> emit) {}

  // FutureOr<void> _onProductDeliveredEvent(
  //     ProductDeliveredEvent event, Emitter<UserOrderPageState> emit) {}

//   FutureOr<void> _onDeliverOrderToAdminEvent(DeliverOrderToAdminEvent event,
//       Emitter<UserOrderPageState> emit) async {

//     final result = await _deliverOrderToAdmin(DeliverOrderToAdminParams(
//       order: event.order,
//     ));
// // event.order.products.forEach((element) {element.})
//     result.fold(
//         (failed) => emit(DeliverOrderToAdminFailed(message: failed.message)),
//         (success) => emit(DeliverOrderToAdminSuccess()));
//   }
}
