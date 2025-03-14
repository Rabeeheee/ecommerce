import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tech_haven/user/features/reviews/domain/usecase/update_user_helpful.dart';
part 'review_page_event.dart';
part 'review_page_state.dart';

class ReviewPageBloc extends Bloc<ReviewPageEvent, ReviewPageState> {
  final UpdateUserHelpful _updateUserHelpful;
  ReviewPageBloc({required UpdateUserHelpful updateUserHelpful})
      : _updateUserHelpful = updateUserHelpful,
        super(ReviewPageInitial()) {
    on<ReviewPageEvent>((event, emit) {

    });
    on<AddUserToHelpfulEvent>(_onAddUserToHelpfulEvent);
  }

  FutureOr<void> _onAddUserToHelpfulEvent(
      AddUserToHelpfulEvent event, Emitter<ReviewPageState> emit) async {
    final result = await _updateUserHelpful(UpdateUserHelpfulParams(
      isLiked: event.isLiked,
        userID: event.userID,
        productID: event.productID,
        reviewID: event.reviewID));
    result.fold((failure) => emit(UpdateHelpfulUsersFailedState(message: failure.message)), (success) => emit(UpdateHelpfulUsersSuccessState()));
  }
}
