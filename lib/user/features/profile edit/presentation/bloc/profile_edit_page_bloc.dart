import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tech_haven/core/common/data/model/user_model.dart';
import 'package:tech_haven/core/common/domain/usecase/get_user_data.dart';
import 'package:tech_haven/core/entities/user.dart';
import 'package:tech_haven/core/usecase/usecase.dart';
import 'package:tech_haven/user/features/profile%20edit/domain/usecase/update_user_data.dart';

part 'profile_edit_page_event.dart';
part 'profile_edit_page_state.dart';

class ProfileEditPageBloc
    extends Bloc<ProfileEditPageEvent, ProfileEditPageState> {
 final GetUserData _getUserData;
  final UpdateUserData _updateUserData;
  ProfileEditPageBloc({   required GetUserData getUserData,
    required UpdateUserData updateUserData,})
      : _getUserData = getUserData,_updateUserData = updateUserData,
        super(ProfileEditPageInitial()) {
    on<ProfileEditPageEvent>((event, emit) {
      emit(ProfileEditPageLoading());
    });
    on<GetUserDataEvent>(_onGetUserDataEvent);
    on<UpdateUserDataEvent>(_onUpdateUserDataEvent);
  }

  FutureOr<void> _onGetUserDataEvent(
      GetUserDataEvent event, Emitter<ProfileEditPageState> emit) async {
    final userData = await _getUserData(NoParams());
    userData.fold(
        (failure) => emit(GetUserDataFailedState(message: failure.message)),
        (success) => emit(GetUserDataSuccessState(user: success!)));
  }

  FutureOr<void> _onUpdateUserDataEvent(
      UpdateUserDataEvent event, Emitter<ProfileEditPageState> emit) async {  final result = await _updateUserData(UpdateUserDataParams(userModel: event.userModel, newImage: event.newImage));
    result.fold(
      (failure) => emit(UpdateUserDataFailedState(message: failure.message)),
      (_) => emit(UpdateUserDataSuccessState()),
    );}
}
