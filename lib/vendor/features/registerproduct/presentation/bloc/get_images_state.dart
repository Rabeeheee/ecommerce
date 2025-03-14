part of 'get_images_bloc.dart';

sealed class GetImagesState extends Equatable {
  const GetImagesState();
  
  @override
  List<Object> get props => [];
}

final class GetImagesInitial extends GetImagesState {}

final class GetImageForRegisterProduct extends GetImagesInitial {}

final class GetImagesForRegisterProductSuccess
    extends GetImagesInitial {
  final Map<int, List<Image>> mapOfListOfImages;
  GetImagesForRegisterProductSuccess({required this.mapOfListOfImages});
}

final class GetImagesForRegisterProductFailed
    extends GetImagesInitial {
  final String message;
  GetImagesForRegisterProductFailed({required this.message});
}


