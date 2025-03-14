part of 'review_enter_page_bloc.dart';

abstract class ReviewEnterPageEvent extends Equatable {
  const ReviewEnterPageEvent();

  @override
  List<Object> get props => [];
}

class AddReviewEvent extends ReviewEnterPageEvent {
  final Product product;
  final String userReview;
  final double userRating;
  final List<Review> listOfReviews;

  const AddReviewEvent(
      {required this.userRating,
      required this.userReview,
      required this.listOfReviews,
      required this.product});

  @override
  List<Object> get props => [userRating, userReview, product];
}
