part of 'help_center_bloc.dart';

sealed class HelpCenterState extends Equatable {
  const HelpCenterState();

  @override
  List<Object> get props => [];
}

final class HelpCenterInitial extends HelpCenterState {}

class HelpCenterLoading extends HelpCenterState {}

class SendRequestState extends HelpCenterState {}

class RequestSendHelpCenterSuccess extends SendRequestState {}

class RequestSendHelpCenterError extends SendRequestState {
  final String message;

  RequestSendHelpCenterError(this.message);
}

class GetAllUserRequestState extends HelpCenterState {}

class GetAllUserRequestSuccessState extends GetAllUserRequestState {
  final List<HelpRequest> listOfHelpRequest;
  GetAllUserRequestSuccessState({required this.listOfHelpRequest});
}

class GetAllUserRequestFailedState extends GetAllUserRequestState {
  final String message;
  GetAllUserRequestFailedState({required this.message});
}

final class GetUserDataSuccess extends SendRequestState {
  final User user;
  GetUserDataSuccess({required this.user});
}

final class GetUserDataFailed extends SendRequestState {
  final String message;
  GetUserDataFailed({required this.message});
}
