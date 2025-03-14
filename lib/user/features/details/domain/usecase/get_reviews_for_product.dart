import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/entities/review.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/core/usecase/usecase.dart';
import 'package:tech_haven/user/features/details/domain/repository/details_repository.dart';

class GetReviewsForProduct implements UseCase<List<Review>,GetReviewForProductParams> {
  final DetailsRepository repository;

  GetReviewsForProduct(this.repository);


  
  @override
  Future<Either<Failure, List<Review>>> call(GetReviewForProductParams params)async {
   return await repository.getReviewsForProduct(params.productID);
  }
}

class GetReviewForProductParams {
  final String productID;
  GetReviewForProductParams({required this.productID});
}
