

abstract class ReviewPageDataSource {
  Future<void> updateUserHelpful(
      {required String userID,
      required String productID,
      required String reviewID,required bool isLiked});
}
