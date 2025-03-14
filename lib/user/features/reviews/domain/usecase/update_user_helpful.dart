import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/core/usecase/usecase.dart';
import 'package:tech_haven/user/features/reviews/domain/repository/review_page_repository.dart';

class UpdateUserHelpful implements UseCase<void, UpdateUserHelpfulParams> {
  final ReviewPageRepository reviewPageRepository;
  UpdateUserHelpful({required this.reviewPageRepository});

  @override
  Future<Either<Failure, void>> call(UpdateUserHelpfulParams params) async {
    return await reviewPageRepository.updateUserHelpful(
        userID: params.userID,
        isLiked: params.isLiked,
        productID: params.productID,
        reviewID: params.reviewID);
  }
}

class UpdateUserHelpfulParams {
  final bool isLiked;
  final String userID;
  final String productID;
  final String reviewID;

  UpdateUserHelpfulParams(
      {required this.userID, required this.productID, required this.reviewID,required this.isLiked});
}
