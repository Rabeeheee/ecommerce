import 'package:cloud_firestore/cloud_firestore.dart';

abstract class SearchPageDataSource {
  Future<List<DocumentSnapshot>> searchProducts(String query);

  // updateUserHelpful() {}
}
