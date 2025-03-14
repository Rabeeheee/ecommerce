import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tech_haven/core/common/data/model/order_model.dart';
import 'package:tech_haven/core/entities/user.dart';
import 'package:tech_haven/core/error/exceptions.dart';
import 'package:tech_haven/user/features/order%20history/data/datasource/user_order_history_data_source.dart';

class UserOrderHistoryDataSourceImpl implements UserOrderHistoryDataSource {
  final FirebaseFirestore firestore;

  UserOrderHistoryDataSourceImpl(this.firestore);

  @override
  Future<List<OrderModel>> getProducts({required User user}) async {
    try {
      //  await firebaseFirestore
      //     .collection('orderHistory')
      //     .doc(orderModel.userID)
      //     .collection('orderDetails')
      //     .doc(orderModel.orderID)
      //     .set(orderModel.toJson());

      final snapshot = await firestore
          .collection('orderHistory')
          .doc(user.uid)
          .collection('orderDetails')
          .get();
      return snapshot.docs
          .map((doc) => OrderModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
