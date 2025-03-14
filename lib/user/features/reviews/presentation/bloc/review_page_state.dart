part of 'review_page_bloc.dart';

sealed class ReviewPageState extends Equatable {
  const ReviewPageState();

  @override
  List<Object> get props => [];
}

final class ReviewPageInitial extends ReviewPageState {}

final class UpdateHelpfulUsersSuccessState extends ReviewPageState {}

final class UpdateHelpfulUsersFailedState extends ReviewPageState {
  final String message;
  const UpdateHelpfulUsersFailedState({required this.message});
}
