import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tech_haven/core/common/domain/usecase/get_current_location_details.dart';
import 'package:tech_haven/core/common/domain/usecase/get_user_data.dart';
import 'package:tech_haven/core/entities/location.dart';
import 'package:tech_haven/core/entities/user.dart';
import 'package:tech_haven/core/usecase/usecase.dart';
import 'package:tech_haven/user/features/map/domain/usecase/update_location.dart';

part 'map_page_event.dart';
part 'map_page_state.dart';

class MapPageBloc extends Bloc<MapPageEvent, MapPageState> {
  final UpdateLocation _updateLocation;
  final GetUserData _getUserData;
  final GetCurrentLocationDetails _getCurrentLocationDetails;
  MapPageBloc(
      {required UpdateLocation updateLocation,
      required GetUserData getUserData,
      required GetCurrentLocationDetails getCurrentLocationDetails})
      : _updateLocation = updateLocation,
        _getUserData = getUserData,
        _getCurrentLocationDetails = getCurrentLocationDetails,
        super(MapPageInitial()) {
    on<MapPageEvent>((event, emit) {
      emit(UpdateLocationDetailsLoading());
    });
    on<GetCurrentLocationDetailsEvent>(_onGetCurrentLocationDetailsEvent);
    on<UpdateLocationDetailsEvent>(_onUpdateLocationDetailsEvent);
    // on<GetCurrentUserDataEvent>(_onGetCurrentUserDataEvent);
  }

  FutureOr<void> _onUpdateLocationDetailsEvent(
      UpdateLocationDetailsEvent event, Emitter<MapPageState> emit) async {
    final result = await _updateLocation(UpdateLocationParams(
      name: event.name,
      phoneNumber: event.phoneNumber,
      location: event.location,
      apartmentHouseNumber: event.apartmentHouseNumber,
      emailAddress: event.emailAdress,
      addressInstructions: event.addressInstructions,
    ));

    result.fold(
        (failed) => emit(UpdateLocationDetailsFailed(message: failed.message)),
        (r) => emit(UpdateLocationDetailsSuccess()));
  }

  FutureOr<void> _onGetCurrentLocationDetailsEvent(
      GetCurrentLocationDetailsEvent event, Emitter<MapPageState> emit) async {
    User? userData;
    final user = await _getUserData(NoParams());
    user.fold(
        (failure) => emit(GetLocationDetailsFailed(message: failure.message,user: userData)),
        (success) => userData = success);
    if (userData != null) {
      final result = await _getCurrentLocationDetails(NoParams());

      result.fold(
          (failure) {
            return emit(GetLocationDetailsFailed(message: failure.message,user: userData));
          },
          (success) => emit(
              GetLocationDetailsSuccess(location: success, user: userData!)));
    }
  }

  // FutureOr<void> _onGetCurrentUserDataEvent(
  //     GetCurrentUserDataEvent event, Emitter<MapPageState> emit) async {
  //   final result = await _getUserData(NoParams());

  //   result.fold((failed) => emit(GetCurrentUserDataFailed(message: failed.message )), (userdata) => emit(GetCurrentUserDataSuccess(user: userdata)));
  // }
}
