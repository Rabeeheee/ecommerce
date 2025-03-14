
import 'package:tech_haven/core/entities/help_center_request.dart';

class HelpCenterRequestModel extends HelpCenterRequest{


  HelpCenterRequestModel({
    required super.userID,
    required super.dateTime,
    required super.userName,
  });

  factory HelpCenterRequestModel.fromJson(Map<String, dynamic> json) {
    return HelpCenterRequestModel(
      userID: json['userID'],
      dateTime: DateTime.parse(json['dateTime']),
      userName: json['userName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userID': userID,
      'dateTime': dateTime.toIso8601String(),
      'userName': userName,
    };
  }
}
