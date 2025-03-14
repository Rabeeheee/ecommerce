import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:tech_haven/core/common/data/model/order_model.dart';
import 'package:tech_haven/core/common/domain/usecase/get_user_data.dart';
import 'package:tech_haven/core/entities/user.dart';
import 'package:tech_haven/core/usecase/usecase.dart';
import 'package:tech_haven/user/features/order%20history/domain/usecase/get_all_user_order_history.dart';

part 'user_order_page_history_event.dart';
part 'user_order_page_history_state.dart';

class UserOrderHistoryPageBloc
    extends Bloc<UserOrderHistoryEvent, UserOrderHistoryState> {
  final GetAllUserOrderHistoryUseCase _getAllUserOrderHistoryUseCase;
  final GetUserData _getUserData;

  UserOrderHistoryPageBloc(
      {required GetAllUserOrderHistoryUseCase getAllUserOrderHistoryUseCase,
      required GetUserData getUserData})
      : _getAllUserOrderHistoryUseCase = getAllUserOrderHistoryUseCase,
        _getUserData = getUserData,
        super(UserOrderHistoryInitial()) {
    on<UserOrderHistoryEvent>((event, emit) {
      emit(UserOrderHistoryLoading());
    });
    on<GetUserOrderHistoryEvent>(_onGetUserOrderHistoryEvent);
  }

  FutureOr<void> _onGetUserOrderHistoryEvent(GetUserOrderHistoryEvent event,
      Emitter<UserOrderHistoryState> emit) async {
    User? user;
    final userdata = await _getUserData(NoParams());
    userdata.fold((failed) => emit(UserOrderHistoryError(failed.message)),
        (success) => user = success);
    if (user != null) {
      final result = await _getAllUserOrderHistoryUseCase(
          GetAllUserOrderHistoryUseCaseParams(user: user!));
      result.fold((failed) => emit(UserOrderHistoryError(failed.message)),
          (success) => emit(UserOrderHistoryLoaded(success)));
    }
  }
}
