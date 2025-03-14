import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tech_haven/user/features/search/data/datasource/search_page_data_source.dart';

class SearchPageDataSourceImpl implements SearchPageDataSource {
  final FirebaseFirestore firestore;

  SearchPageDataSourceImpl(this.firestore);

  @override
  Future<List<DocumentSnapshot>> searchProducts(String query) async {
    query.toLowerCase();
    final result = await firestore
        .collection('products')
        .where('name', isGreaterThanOrEqualTo: query, )
        .where('name', isLessThanOrEqualTo: '$query\uf8ff')
        .get();

    return result.docs;
  }
}
