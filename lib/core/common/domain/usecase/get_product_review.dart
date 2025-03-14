import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/common/domain/repository/repository.dart';
import 'package:tech_haven/core/entities/product_review.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/core/usecase/usecase.dart';

class GetProductReview
    implements UseCase<ProductReview, GetProductReviewParams> {
  final Repository repository;
  GetProductReview({required this.repository});
  @override
  Future<Either<Failure, ProductReview>> call(GetProductReviewParams params) {
    return repository.getProductReviewModel(productID: params.productID);
  }
}

class GetProductReviewParams {
  final String productID;
  GetProductReviewParams({required this.productID});
}
