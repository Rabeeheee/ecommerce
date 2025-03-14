import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tech_haven/core/common/domain/usecase/get_current_location_details.dart';
import 'package:tech_haven/core/common/domain/usecase/get_user_data.dart';
import 'package:tech_haven/core/common/domain/usecase/update_product_to_favorite.dart';
import 'package:tech_haven/core/entities/location.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/entities/user.dart';
import 'package:tech_haven/core/usecase/usecase.dart';

part 'common_event.dart';
part 'common_state.dart';

class CommonBloc extends Bloc<CommonEvent, CommonState> {
  // final UpdateProductToFavorite _updateProductToFavorite;
  final GetUserData _getUserData;
  final GetCurrentLocationDetails _getCurrentLocationDetails;
  CommonBloc(
      {required GetCurrentLocationDetails getCurrentLocationDetails,
      required GetUserData getUserData,
      required UpdateProductToFavorite updateProductToFavorite})
      :
        //  _updateProductToFavorite = updateProductToFavorite,
        _getCurrentLocationDetails = getCurrentLocationDetails,
        _getUserData = getUserData,
        super(CommonInitial()) {
    on<CommonEvent>((event, emit) {});
    on<GetUserLocationDataEvent>(_onGetUserLocationDataEvent);
    on<LoadUserDataEventForCommon>(_onLoadUserDataEventForCommon);
    // on<UpdateProductToFavoriteEvent>(_onUpdateProductToFavoriteEvent);
  }

  FutureOr<void> _onGetUserLocationDataEvent(
      GetUserLocationDataEvent event, Emitter<CommonState> emit) async {
    final result = await _getCurrentLocationDetails(NoParams());
    result.fold((failed) => emit(LocationFailedState(message: failed.message)),
        (success) => emit(LocationSuccessState(location: success)));
  }

  FutureOr<void> _onLoadUserDataEventForCommon(
      LoadUserDataEventForCommon event, Emitter<CommonState> emit) async {
    final result = await _getUserData(NoParams());
    result.fold(
        (failed) =>
            emit(LoadUserDataCommonFailedState(message: failed.message)),
        (success) => emit(LoadUserDataCommonSuccessState(user: success!)));
  }
}
