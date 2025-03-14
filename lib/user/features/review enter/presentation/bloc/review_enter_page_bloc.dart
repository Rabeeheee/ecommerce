import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tech_haven/core/common/domain/usecase/add_review.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/entities/review.dart';

part 'review_enter_page_event.dart';
part 'review_enter_page_state.dart';

class ReviewEnterPageBloc
    extends Bloc<ReviewEnterPageEvent, ReviewEnterPageState> {
  final AddReview _addReview;
  ReviewEnterPageBloc({required AddReview addReview})
      : _addReview = addReview,
        super(ReviewEnterPageInitial()) {
    on<ReviewEnterPageEvent>((event, emit) {
      emit(ReviewEnterPageLoading());
    });
    on<AddReviewEvent>(_onAddReviewEvent);
  }

  FutureOr<void> _onAddReviewEvent(
      AddReviewEvent event, Emitter<ReviewEnterPageState> emit) async {
    final result = await _addReview(AddReviewParams(
        userRating: event.userRating,
        listOfReviews: event.listOfReviews,
        userReivew: event.userReview,
        product: event.product));
    result.fold(
        (failure) => emit(ReviewEnterPageError(message: failure.message)),
        (success) => emit(const ReviewEnterPageSuccess(
            message: 'the Review is Added successfully')));
  }
}
