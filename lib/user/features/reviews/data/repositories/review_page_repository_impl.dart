import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/error/exceptions.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/user/features/reviews/data/datasource/review_page_data_source.dart';
import 'package:tech_haven/user/features/reviews/domain/repository/review_page_repository.dart';

class ReviewPageRepositoryImpl implements ReviewPageRepository {
  final ReviewPageDataSource dataSource;

  ReviewPageRepositoryImpl(this.dataSource);


@override
   Future<Either<Failure, void>> updateUserHelpful({required String userID, required String productID, required String reviewID,required bool isLiked})async{
try{
  final result = await dataSource.updateUserHelpful(userID: userID, productID: productID, reviewID: reviewID,isLiked: isLiked);
  return right(result);
}on ServerException catch(e){
  return left(Failure(e.message));
}
   }
}
