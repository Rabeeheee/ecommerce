import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tech_haven/core/common/data/model/user_ordered_product_model.dart';
import 'package:tech_haven/core/error/exceptions.dart';
import 'package:tech_haven/user/features/ordredProducts/data/datasource/ordered_products_page_data_source.dart';

class OrderedProductsPageDataSourceImpl
    implements OrderedProductsPageDataSource {
  final FirebaseFirestore firebaseFirestore;

  OrderedProductsPageDataSourceImpl(this.firebaseFirestore);

  @override
  Future<List<UserOrderedProductModel>> getUserOrderProducts(
      String userId, String orderId) async {
    try {
      final snapshot = await firebaseFirestore
          .collection('userOrderedProducts')
          .doc(userId)
          .collection('orders')
          .doc(orderId)
          .collection('products')
          .get();

      return snapshot.docs
          .map((doc) => UserOrderedProductModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
