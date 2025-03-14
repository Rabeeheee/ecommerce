import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/user/features/details/data/datasource/details_data_source.dart';
import 'package:tech_haven/user/features/details/domain/repository/details_repository.dart';

import '../../../../../core/common/data/model/review_model.dart';

class DetailsRepositoryImpl implements DetailsRepository {
  final DetailsDataSource dataSource;

  DetailsRepositoryImpl(this.dataSource);

   @override
  Future<Either<Failure, List<ReviewModel>>> getReviewsForProduct(String productId) async {
    try {
      final reviews = await dataSource.getReviewsForProduct(productId);
      return right(reviews);
    } catch (e) {
      return left(Failure('Failed to fetch reviews: $e'));
    }
  }
}