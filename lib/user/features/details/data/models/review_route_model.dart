import 'package:tech_haven/core/entities/review.dart';

class ReviewRouteModel {
  final List<Review> listOfReview;
  final String userID;
  ReviewRouteModel({required this.listOfReview,required this.userID});
}
