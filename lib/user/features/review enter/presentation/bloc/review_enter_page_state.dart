part of 'review_enter_page_bloc.dart';

abstract class ReviewEnterPageState extends Equatable {
  const ReviewEnterPageState();

  @override
  List<Object> get props => [];
}

class ReviewEnterPageInitial extends ReviewEnterPageState {}

class ReviewEnterPageLoading extends ReviewEnterPageState {}

class ReviewEnterPageSuccess extends ReviewEnterPageState {
  final String message;

  const ReviewEnterPageSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class ReviewEnterPageError extends ReviewEnterPageState {
  final String message;

  const ReviewEnterPageError({required this.message});

  @override
  List<Object> get props => [message];
}
