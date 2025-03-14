// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tech_haven/core/common/domain/usecase/get_a_product.dart';
import 'package:tech_haven/core/common/domain/usecase/get_all_orders.dart';
import 'package:tech_haven/core/common/domain/usecase/get_vendor_orders.dart';
import 'package:tech_haven/core/entities/order.dart' as model;
import 'package:tech_haven/core/entities/order.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/usecase/usecase.dart';
import 'package:tech_haven/vendor/features/order/domain/usecase/delete_order.dart';

part 'vendor_order_page_event.dart';
part 'vendor_order_page_state.dart';

class VendorOrderPageBloc
    extends Bloc<VendorOrderPageEvent, VendorOrderPageState> {
  // final GetAllOrders _getAllOrders;
  final DeliverOrderToAdmin _deliverOrderToAdmin;
  // final GetAProduct _getAProduct;
  final GetVendorOrders _getVendorOrders;
  VendorOrderPageBloc(
      {required GetAllOrders getAllOrders,
      required GetAProduct getAProduct,
      required GetVendorOrders getVendorOrders,
      required DeliverOrderToAdmin deliverOrderToAdmin})
      :
      //  _getAllOrders = getAllOrders,
        _deliverOrderToAdmin = deliverOrderToAdmin,
        _getVendorOrders = getVendorOrders,
        // _getAProduct = getAProduct,
        super(VendorOrderPageInitial()) {
    on<VendorOrderPageEvent>((event, emit) {
      emit(VendorOrderPageLoading());
    });
    on<UpdateOrderDeliveryEvent>(_onUpdateOrderDeliveryEvent);
    on<GetAllOrdersForVendorEvent>(_onGetAllOrdersForVendorEvent);
    on<ChangeTheDeliveryDateEvent>(_onChangeTheDeliveryDateEvent);
    // on<ProductDeliveredEvent>(_onProductDeliveredEvent);
    on<DeliverOrderToAdminEvent>(_onDeliverOrderToAdminEvent);
  }

  FutureOr<void> _onUpdateOrderDeliveryEvent(
      UpdateOrderDeliveryEvent event, Emitter<VendorOrderPageState> emit) {}

  FutureOr<void> _onGetAllOrdersForVendorEvent(GetAllOrdersForVendorEvent event,
      Emitter<VendorOrderPageState> emit) async {
    final allOrders = await _getVendorOrders(NoParams());
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
      ChangeTheDeliveryDateEvent event, Emitter<VendorOrderPageState> emit) {}

  // FutureOr<void> _onProductDeliveredEvent(
  //     ProductDeliveredEvent event, Emitter<VendorOrderPageState> emit) {}

  FutureOr<void> _onDeliverOrderToAdminEvent(DeliverOrderToAdminEvent event,
      Emitter<VendorOrderPageState> emit) async {

    final result = await _deliverOrderToAdmin(DeliverOrderToAdminParams(
      order: event.order,
    ));
// event.order.products.forEach((element) {element.})
    result.fold(
        (failed) => emit(DeliverOrderToAdminFailed(message: failed.message)),
        (success) => emit(DeliverOrderToAdminSuccess()));
  }
}
