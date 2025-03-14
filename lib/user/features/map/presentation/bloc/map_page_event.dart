part of 'map_page_bloc.dart';

sealed class MapPageEvent extends Equatable {
  const MapPageEvent();

  @override
  List<Object> get props => [];
}

final class UpdateLocationDetailsEvent extends MapPageEvent {
  final String name;
  final String phoneNumber;
  final String location;
  final String apartmentHouseNumber;
  final String emailAdress;
  final String addressInstructions;
  const UpdateLocationDetailsEvent(
      {
      required this.name,
      required this.phoneNumber,
      required this.location,
      required this.apartmentHouseNumber,
      required this.emailAdress,
      required this.addressInstructions});
}

final class GetCurrentLocationDetailsEvent extends MapPageEvent{}

final class GetCurrentUserDataEvent extends MapPageEvent{}
