import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/entities/review.dart';

class ReviewEnterRouteModel {
  final Product product;
  final double userRating;
  final List<Review> listOfReview;
  ReviewEnterRouteModel({required this.product, required this.userRating,required this.listOfReview});
}
