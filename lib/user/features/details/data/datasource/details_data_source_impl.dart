import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tech_haven/core/common/data/model/review_model.dart';
import 'package:tech_haven/core/error/exceptions.dart';
import 'package:tech_haven/user/features/details/data/datasource/details_data_source.dart';

class DetailsDataSourceImpl implements DetailsDataSource {
  final FirebaseFirestore firestore;

  DetailsDataSourceImpl(this.firestore);

  @override
  Future<List<ReviewModel>> getReviewsForProduct(String productId) async {
    try {
      final querySnapshot = await firestore
          .collection('reviews')
          .doc(productId)
          .collection('reviewDetails')
          .get();

      return querySnapshot.docs
          .map((doc) => ReviewModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw ServerException('Failed to fetch reviews: $e');
    }
  }
}
