import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tech_haven/core/common/domain/usecase/get_images_for_product.dart';
import 'package:tech_haven/core/entities/image.dart';


part 'get_images_event.dart';
part 'get_images_state.dart';

class GetImagesBloc extends Bloc<GetImagesEvent, GetImagesState> {
  final GetImagesForProduct _getImagesForProduct;
  GetImagesBloc({required GetImagesForProduct getImagesForProduct})
      : _getImagesForProduct = getImagesForProduct,
        super(GetImagesInitial()) {
    on<GetImagesEvent>((event, emit) {
      emit(GetImagesInitial());
    });
    on<EmitInitialEvent>((event, emit) {
      emit(GetImagesInitial());
    });

    on<GetImagesForTheProductEvent>(_onGetImagesForProductEvent);
  }
  FutureOr<void> _onGetImagesForProductEvent(
      GetImagesForTheProductEvent event, Emitter<GetImagesState> emit) async {
    emit(GetImagesInitial());
    final hello = await _getImagesForProduct(
        GetImagesForProductParams(productID: event.productID));
    hello.fold(
        (failure) =>
            emit(GetImagesForRegisterProductFailed(message: failure.message)),
        (mapOfListOfImages) {
      return emit(GetImagesForRegisterProductSuccess(
          mapOfListOfImages: mapOfListOfImages));
    });
  }
}
