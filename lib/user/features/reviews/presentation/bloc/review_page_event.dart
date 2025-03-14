part of 'review_page_bloc.dart';

sealed class ReviewPageEvent extends Equatable {
  const ReviewPageEvent();

  @override
  List<Object> get props => [];
}

final class AddUserToHelpfulEvent extends ReviewPageEvent {
  final String userID;
  final String productID;
  final bool isLiked;
  final String reviewID;
  const AddUserToHelpfulEvent(
      {required this.userID, required this.productID, required this.reviewID,required this.isLiked});
}
