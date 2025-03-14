part of 'profile_edit_page_bloc.dart';

sealed class ProfileEditPageState extends Equatable {
  const ProfileEditPageState();

  @override
  List<Object> get props => [];
}

final class ProfileEditPageInitial extends ProfileEditPageState {}

final class ProfileEditPageLoading extends ProfileEditPageState {}

final class GetUserDataState extends ProfileEditPageState {}

final class GetUserDataFailedState extends GetUserDataState {
  final String message;
  GetUserDataFailedState({required this.message});
}

final class GetUserDataSuccessState extends GetUserDataState {
  final User user;
  GetUserDataSuccessState({required this.user});
}

final class UpdateUserDataState extends ProfileEditPageState {}

final class UpdateUserDataSuccessState extends UpdateUserDataState {}

final class UpdateUserDataFailedState extends UpdateUserDataState {
  final String message;
  UpdateUserDataFailedState({required this.message});
}
