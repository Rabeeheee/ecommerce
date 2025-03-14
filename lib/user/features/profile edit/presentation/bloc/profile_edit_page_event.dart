part of 'profile_edit_page_bloc.dart';

sealed class ProfileEditPageEvent extends Equatable {
  const ProfileEditPageEvent();

  @override
  List<Object> get props => [];
}

final class GetUserDataEvent extends ProfileEditPageEvent {}

final class UpdateUserDataEvent extends ProfileEditPageEvent {
  final UserModel userModel;
  final dynamic newImage;
  const UpdateUserDataEvent({required this.userModel,required this.newImage});
}
