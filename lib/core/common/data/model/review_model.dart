import 'package:tech_haven/core/entities/review.dart';

class ReviewModel extends Review {
  ReviewModel({
    required super.reviewID,
    required super.userReview,
    required super.listOfHelpFulUsers,
    required super.userName,
    required super.productID,
    required super.dateTime,
    required super.userID,
    required super.userProfile,
    required super.userRating,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      reviewID: json['reviewID'],
      userID: json['userID'],
      productID: json['productID'],
      dateTime: DateTime.parse(json['DateTime']),
      userProfile: json['userProfile'],
      userReview: json['userReview'],
      listOfHelpFulUsers: List<String>.from(json['listOfHelpFulUsers']),
      userName: json['userName'],
      userRating: json['userRating'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'reviewID': reviewID,
      'DateTime': dateTime.toIso8601String(),
      'userID': userID,
      'userProfile' : userProfile,
      'productID' : productID,
      'userReview': userReview,
      'listOfHelpFulUsers': listOfHelpFulUsers,
      'userName': userName,
      'userRating': userRating,
    };
  }
}
