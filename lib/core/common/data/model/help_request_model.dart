import 'package:tech_haven/core/entities/help_request.dart';

class HelpRequestModel extends HelpRequest {
  HelpRequestModel({
    required super.userID,
    required super.email,
    required super.dateTime,
    required super.requestID,
    required super.name,
    required super.subject,
    required super.body,
    super.answer,
  });

  factory HelpRequestModel.fromJson(Map<String, dynamic> json) {
    return HelpRequestModel(
      requestID: json['requestID'],
      userID: json['userID'],
      email: json['email'],
      dateTime: DateTime.parse(json['dateTime']),
      name: json['name'],
      subject: json['subject'],
      body: json['body'],
      answer: json['answer'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userID': userID,
      'email': email,
      'name': name,
      'subject': subject,
      'body': body,
      'requestID': requestID,
      'dateTime': dateTime.toIso8601String(),
      'answer': answer,
    };
  }
}
