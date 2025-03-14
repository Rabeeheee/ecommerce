import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/error/failures.dart';

abstract class ReviewPageRepository {
  Future<Either<Failure, void>> updateUserHelpful({required String userID, required String productID, required String reviewID,required bool isLiked});
}
