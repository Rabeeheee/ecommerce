import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tech_haven/core/common/domain/usecase/get_user_data.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/usecase/usecase.dart';
import 'package:tech_haven/vendor/features/manageproduct/domain/usecase/get_all_products.dart';
import 'package:tech_haven/vendor/features/manageproduct/domain/usecase/update_the_product_publish.dart';

part 'manage_product_event.dart';
part 'manage_product_state.dart';

class ManageProductBloc extends Bloc<ManageProductEvent, ManageProductState> {
  static bool isDataLoaded = false;
  final UpdateTheProductPublish _updateTheProductPublish;
  final GetAllProducts _getAllProducts;
  final GetUserData _getUserData;
  ManageProductBloc(
      {required GetAllProducts getAllProducts,
      required UpdateTheProductPublish updateTheProductPublish,
      required GetUserData getUserData})
      : _getUserData = getUserData,
        _getAllProducts = getAllProducts,
        _updateTheProductPublish = updateTheProductPublish,
        super(ManageProductInitial()) {
    on<ManageProductEvent>((event, emit) {
      emit(ManageProductLoadingState());
    });
    on<GetAllProductsEventForManage>(_onGetAllProductsEventForManage);
    on<UpdateTheProductPublishEvent>(_onUpdateTheProductPublishEvent);
  }

  FutureOr<void> _onGetAllProductsEventForManage(
      GetAllProductsEventForManage event, Emitter<ManageProductState> emit) async {
    final products = await _getAllProducts(NoParams());
    final user = await _getUserData(NoParams());


    String? vendorID;

    // String userFailureMessage = 'User is Failed';

    user.fold((failure) => emit(GetAllProductFailed(message: failure.message)),
        (success) => vendorID = success?.vendorID);

    products
        .fold((failure) => emit(GetAllProductFailed(message: failure.message)),
            (listOfProducts) {
      isDataLoaded = true;
      emit(GetAllProductsSuccess(
          listOfProductModel: vendorID != null
              ? listOfProducts
                  .where((element) => element.vendorID == vendorID!)
                  .toList()
              : []));
    });
  }

  FutureOr<void> _onUpdateTheProductPublishEvent(
      UpdateTheProductPublishEvent event,
      Emitter<ManageProductState> emit) async {
    final result = await _updateTheProductPublish(UpdateTheProductPublishParams(
        product: event.product, publish: event.publish));
    result.fold(
        (failed) =>
            emit(UpdateTheProductPublishFailedState(message: failed.message)),
        (success) => emit(UpdateTheProductPublishSuccessState()));
  }
}
