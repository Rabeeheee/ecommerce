part of 'map_page_bloc.dart';

sealed class MapPageState extends Equatable {
  const MapPageState();

  @override
  List<Object> get props => [];
}

final class MapPageInitial extends MapPageState {}

final class GetLocationDetailsSuccess extends MapPageState {
  final User user;
  final Location? location;
  const GetLocationDetailsSuccess({required this.location, required this.user});
}

final class GetLocationDetailsFailed extends MapPageState {
  final User? user;
  final String message;
  const GetLocationDetailsFailed({required this.message, required this.user});
}

final class UpdateLocationDetailsSuccess extends MapPageState {}

final class UpdateLocationDetailsFailed extends MapPageState {
  final String message;
  const UpdateLocationDetailsFailed({required this.message});
}

final class UpdateLocationDetailsLoading extends MapPageState {}

final class GetCurrentUserDataSuccess extends MapPageState {
  final User? user;
  const GetCurrentUserDataSuccess({required this.user});
}

final class GetCurrentUserDataFailed extends MapPageState {
  final String message;
  const GetCurrentUserDataFailed({required this.message});
}
