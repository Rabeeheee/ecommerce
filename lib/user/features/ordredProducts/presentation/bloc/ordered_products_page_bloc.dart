import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tech_haven/core/common/domain/usecase/get_user_data.dart';
import 'package:tech_haven/core/entities/user_ordered_product.dart';
import 'package:tech_haven/core/usecase/usecase.dart';
import 'package:tech_haven/user/features/ordredProducts/domain/usecase/get_user_ordered_products.dart';

part 'ordered_products_page_event.dart';
part 'ordered_products_page_state.dart';

class OrderedProductsPageBloc
    extends Bloc<OrderedProductsPageEvent, OrderedProductsPageState> {
  final GetUserOrderProducts _getUserOrderProducts;
  final GetUserData _getUserData;
  OrderedProductsPageBloc(
      {required GetUserOrderProducts getUserOrderProducts,
      required GetUserData getUserData})
      : _getUserOrderProducts = getUserOrderProducts,
        _getUserData = getUserData,
        super(OrderedProductsPageInitial()) {
    on<OrderedProductsPageEvent>((event, emit) {
    });
    on<FetchOrderProductsEvent>(_onFetchOrderProductsEvent);
  }
  void _onFetchOrderProductsEvent(FetchOrderProductsEvent event,
      Emitter<OrderedProductsPageState> emit) async {
    emit(OrderedProductsPageLoading());
    String? userID;
    final user = await _getUserData(NoParams());
    user.fold(
        (failed) => emit(OrderedProductsPageError(message: failed.message)),
        (user) => userID = user!.uid);
    if (userID != null) {
      final failureOrProducts =
          await _getUserOrderProducts(GetUserOrderProductsParams(
        userId: userID!,
        orderId: event.orderId,
      ));

      emit(failureOrProducts.fold(
        (failure) =>
            const OrderedProductsPageError(message: 'Failed to fetch products'),
        (products) => OrderedProductsPageLoaded(products: products),
      ));
    }
  }
}
