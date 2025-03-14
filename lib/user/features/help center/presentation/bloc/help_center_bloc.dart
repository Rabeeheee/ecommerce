import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tech_haven/core/common/data/model/help_request_model.dart';
import 'package:tech_haven/core/common/domain/usecase/get_user_data.dart';
import 'package:tech_haven/core/entities/help_request.dart';
import 'package:tech_haven/core/entities/user.dart';
import 'package:tech_haven/core/usecase/usecase.dart';
import 'package:tech_haven/user/features/help%20center/domain/usecase/get_all_user_requests.dart';
import 'package:tech_haven/user/features/help%20center/domain/usecase/send_help_request_use_case.dart';

part 'help_center_event.dart';
part 'help_center_state.dart';

class HelpCenterBloc extends Bloc<HelpCenterEvent, HelpCenterState> {
  final SendHelpRequestUseCase _sendHelpRequestUseCase;
  final GetUserData _getUserData;
  final GetAllUserRequestsUseCase _getAllUserRequestsUseCase;

  HelpCenterBloc({
    required GetAllUserRequestsUseCase getAllUserRequestsUseCase,
    required SendHelpRequestUseCase sendHelpRequestUseCase,
    required GetUserData getUserData,
  })  : _sendHelpRequestUseCase = sendHelpRequestUseCase,
        _getUserData = getUserData,
        _getAllUserRequestsUseCase = getAllUserRequestsUseCase,
        super(HelpCenterInitial()) {
    on<HelpCenterEvent>((event, emit) {
      emit(HelpCenterLoading());
    });
    on<SendHelpRequestEvent>(_onSendHelpRequestEvent);
    on<GetAllUserRequestEvent>(_onGetAllUserRequestEvent);
    on<GetUserDataEvent>(_onGetUserDataEvent);
  }

  Future<void> _onSendHelpRequestEvent(
      SendHelpRequestEvent event, Emitter<HelpCenterState> emit) async {
    // emit(HelpCenterLoading());
    User? user;
    final userData = await _getUserData(NoParams());
    userData
        .fold((failure) => emit(RequestSendHelpCenterError(failure.message)),
            (success) async {
      user = success;
    });
    if (user != null) {
      final result = await _sendHelpRequestUseCase(SendHelpRequestParams(
        userID: user!.uid!,
        userName: event.userName,
        helpRequest: event.helpRequest,
      ));
      result.fold(
          (failure) => emit(RequestSendHelpCenterError(failure.message)),
          (_) => emit(RequestSendHelpCenterSuccess()));
    } else {
      emit(RequestSendHelpCenterError('The User is not available right now'));
    }
  }

  FutureOr<void> _onGetAllUserRequestEvent(
      GetAllUserRequestEvent event, Emitter<HelpCenterState> emit) async {
    // emit(HelpCenterLoading());
    User? user;
    final userData = await _getUserData(NoParams());
    userData.fold(
        (failure) =>
            emit(GetAllUserRequestFailedState(message: failure.message)),
        (success) async {
      user = success;
    });
    if (user != null) {
      final result = await _getAllUserRequestsUseCase(
          GetAllUserRequestsParams(userID: user!.uid!));
      result.fold(
          (failure) =>
              emit(GetAllUserRequestFailedState(message: failure.message)),
          (success) =>
              emit(GetAllUserRequestSuccessState(listOfHelpRequest: success)));
    } else {
      emit(GetAllUserRequestFailedState(
          message: 'The User is not available right now'));
    }
  }

  FutureOr<void> _onGetUserDataEvent(
      GetUserDataEvent event, Emitter<HelpCenterState> emit) async {
    final user = await _getUserData(NoParams());
    user.fold((failed) => emit(GetUserDataFailed(message: failed.message)),
        (success) => emit(GetUserDataSuccess(user: success!)));
  }
}
