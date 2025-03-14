class Review {
  final DateTime dateTime;
  final String reviewID;
  final double userRating;
  final String? userProfile;
  final String userReview;
  final String productID;
  final String userID;
  final String userName;
  final List<String> listOfHelpFulUsers;

  Review(
      {required this.reviewID,
      required this.userReview,
      required this.dateTime,
      required this.userProfile,
      required this.userID,
      required this.productID,
      required this.listOfHelpFulUsers,
      required this.userName,
      required this.userRating});
}
