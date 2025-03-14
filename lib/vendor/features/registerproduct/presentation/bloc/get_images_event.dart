part of 'get_images_bloc.dart';

sealed class GetImagesEvent extends Equatable {
  const GetImagesEvent();

  @override
  List<Object> get props => [];
}

final class GetImagesForTheProductEvent extends GetImagesEvent {
  final String productID;
  const GetImagesForTheProductEvent({required this.productID});
}

final class EmitInitialEvent extends GetImagesEvent {}
