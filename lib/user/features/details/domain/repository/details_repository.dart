import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/common/data/model/review_model.dart';
import 'package:tech_haven/core/error/failures.dart';

abstract class DetailsRepository {
Future<Either<Failure, List<ReviewModel>>> getReviewsForProduct(String productId);
}
