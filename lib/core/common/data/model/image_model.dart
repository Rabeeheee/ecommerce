import 'package:tech_haven/core/entities/image.dart';

class ImageModel extends Image {
  ImageModel({required super.imageID, required super.imageURL});

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      imageID: json['imageID'],
      imageURL: json['imageURL'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'imageID': imageID,
      'imageURL': imageURL,
    };
  }
}
