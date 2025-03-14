import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tech_haven/core/common/domain/usecase/get_a_product.dart';
import 'package:tech_haven/core/common/domain/usecase/get_all_product.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/entities/product_order.dart';
part 'vendor_order_details_event.dart';
part 'vendor_order_details_state.dart';

class VendorOrderDetailsBloc
    extends Bloc<VendorOrderDetailsEvent, VendorOrderDetailsState> {
  final GetAProduct _getAProduct;
  // final GetAllProduct _getAllProduct;
  VendorOrderDetailsBloc(
      {required GetAProduct getAProduct, required GetAllProduct getAllProduct})
      : _getAProduct = getAProduct,
        // _getAllProduct = getAllProduct,
        super(VendorOrderDetailsInitial()) {
    on<VendorOrderDetailsEvent>((event, emit) {
      emit(VendorOrderDetailsLoading());
    });
    on<GetAllOrderedProductsEvent>(_onGetAllOrderedProductsEvent);
  }
  Future<void> _onGetAllOrderedProductsEvent(GetAllOrderedProductsEvent event,
      Emitter<VendorOrderDetailsState> emit) async {
    List<Product> listOfProducts = [];
    // List<ProductOrderModel> listOfProductOrderModel = [];

    for (var element in event.listOfOrderModel) {
      // listOfProductOrderModel = eleme
      final productResult =
          await _getAProduct(GetAProductParams(productID: element.productID));
      productResult.fold((failure) {
        // Handle the failure if needed
      }, (product) {
        listOfProducts.add(product);
      });
    }

    // Emit the success state with the filtered list of products
    if (listOfProducts.isNotEmpty) {
      emit(GetAllOrderedProductsSuccess(listOfProducts: listOfProducts));
    } else {
      emit(const GetAllOrderedProductsFailed(
          message: 'The list is empty at the momnet'));
    }
  }
}
