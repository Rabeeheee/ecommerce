part of 'common_bloc.dart';

sealed class CommonState extends Equatable {
  const CommonState();

  @override
  List<Object> get props => [];
}

final class CommonInitial extends CommonState {}

final class LocationState extends CommonState {}

final class LocationSuccessState extends LocationState {
  final Location? location;
  LocationSuccessState({required this.location});
}

final class LocationFailedState extends LocationState {
  final String message;
  LocationFailedState({required this.message});
}

final class FavoriteButtonState extends CommonState {}

final class UpdateFavoriteSuccess extends FavoriteButtonState {}

final class UpdateFavoriteFailed extends FavoriteButtonState {
  final String message;
  UpdateFavoriteFailed({required this.message});
}

final class LoadUserDataCommonState extends CommonState {}

final class LoadUserDataCommonSuccessState extends LoadUserDataCommonState {
  final User user;
  LoadUserDataCommonSuccessState({required this.user});
}

final class LoadUserDataCommonFailedState extends LoadUserDataCommonState {
  final String message;
  LoadUserDataCommonFailedState({required this.message});
}
