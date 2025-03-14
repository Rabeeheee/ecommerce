import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:tech_haven/core/common/domain/usecase/get_user_data.dart';
import 'package:tech_haven/core/entities/user.dart';
import 'package:tech_haven/core/usecase/usecase.dart';
import 'package:tech_haven/user/features/profile/domain/usecase/send_otp_for_google_login.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetUserData _getUserData;
  final SendOtpForGoogleLogin _sendOtpForGoogleLogin;
  ProfileBloc(
      {required GetUserData getUserData,
      required SendOtpForGoogleLogin sendOtpForGoogleLogin})
      : _getUserData = getUserData,
        _sendOtpForGoogleLogin = sendOtpForGoogleLogin,
        super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) {
      emit(ProfileLoading());
    });
    on<GetUserProfileDataEvent>(_onGetUserProfileDataEvent);

    on<ProfileSignOutUserEvent>(_onSignOutUserEvent);
    on<SendOTPForGoogleLoginEvent>(_onSendOTPForGoogleLoginEvent);
  }

  FutureOr<void> _onSignOutUserEvent(
      ProfileSignOutUserEvent event, Emitter<ProfileState> emit) {}

  FutureOr<void> _onGetUserProfileDataEvent(
      GetUserProfileDataEvent event, Emitter<ProfileState> emit) async {
    final result = await _getUserData(NoParams());
    result.fold(
        (failure) => emit(GetProfileDataFailedState(message: failure.message)),
        (success) => emit(GetProfileDataSuccessState(user: success!)));
  }

  FutureOr<void> _onSendOTPForGoogleLoginEvent(
      SendOTPForGoogleLoginEvent event, Emitter<ProfileState> emit) async {
    final result = await _sendOtpForGoogleLogin(
        SendOtpForGoogleLoginParams(phoneNumber: event.phoneNumber));
    result.fold(
        (failed) => emit(FailedToGetVerificationID(message: failed.message)),
        (success) => emit(GoToOTPPageState(verificationID: success)));
  }
}
