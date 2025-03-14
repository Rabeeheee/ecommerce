import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tech_haven/core/error/exceptions.dart';
import 'package:tech_haven/user/features/reviews/data/datasource/review_page_data_source.dart';

class ReviewPageDataSourceImpl implements ReviewPageDataSource {
  final FirebaseFirestore firestore;

  ReviewPageDataSourceImpl(this.firestore);

  @override
  Future<void> updateUserHelpful(
      {required String userID,
      required bool isLiked,
      required String productID,
      required String reviewID}) async {
    try {
      if (isLiked) {
        return await firestore
            .collection('reviews')
            .doc(productID)
            .collection('reviewDetails')
            .doc(reviewID)
            .update({
          'listOfHelpFulUsers': FieldValue.arrayUnion([userID]),
        });
      } else {
        return await firestore
            .collection('reviews')
            .doc(productID)
            .collection('reviewDetails')
            .doc(reviewID)
            .update({
          'listOfHelpFulUsers': FieldValue.arrayRemove([userID]),
        });
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
