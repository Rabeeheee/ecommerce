import 'package:tech_haven/core/common/data/model/review_model.dart';

abstract class DetailsDataSource {
  Future<List<ReviewModel>> getReviewsForProduct(String productId);
}
