part of 'help_center_bloc.dart';

sealed class HelpCenterEvent extends Equatable {
  const HelpCenterEvent();

  @override
  List<Object> get props => [];
}

class SendHelpRequestEvent extends HelpCenterEvent {
  final String userName;
  final HelpRequestModel helpRequest;

  const SendHelpRequestEvent({
    required this.userName,
    required this.helpRequest,
  });
}

class GetAllUserRequestEvent extends HelpCenterEvent{

}

final class GetUserDataEvent extends HelpCenterEvent{

}