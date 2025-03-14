part of 'profile_bloc.dart';

sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class GetProfileDataState extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class GetProfileDataSuccessState extends GetProfileDataState {
  final User user;
  GetProfileDataSuccessState({required this.user});
}

final class GetProfileDataLoadingState extends GetProfileDataState {}

final class GetProfileDataFailedState extends GetProfileDataState {
  final String message;
  GetProfileDataFailedState({required this.message});
}

final class PhoneVerificationState extends ProfileState {}

final class GoToOTPPageState extends PhoneVerificationState {
  final String verificationID;
  GoToOTPPageState({required this.verificationID});
}

final class FailedToGetVerificationID extends PhoneVerificationState {
  final String message;
  FailedToGetVerificationID({required this.message});
}
