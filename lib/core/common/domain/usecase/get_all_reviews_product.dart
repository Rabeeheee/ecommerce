import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/common/domain/repository/repository.dart';
import 'package:tech_haven/core/entities/review.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/core/usecase/usecase.dart';

class GetAllReviewsProduct
    implements UseCase<List<Review>, GetAllReviewsProductParams> {
  final Repository repository;
  GetAllReviewsProduct({required this.repository});
  @override
  Future<Either<Failure, List<Review>>> call(
      GetAllReviewsProductParams params) {
    return repository.getAllReviewsProduct(productID: params.productID);
  }
}

class GetAllReviewsProductParams {
  final String productID;
  GetAllReviewsProductParams({required this.productID});
}
