import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tech_haven/core/common/data/model/order_model.dart';
import 'package:tech_haven/core/error/exceptions.dart';
import 'package:tech_haven/vendor/features/order/data/datasource/order_data_source.dart';
import 'package:tech_haven/core/entities/order.dart' as model;

class OrderDataSourceImpl implements OrderDataSource {
  final FirebaseFirestore firebaseFirestore;
  OrderDataSourceImpl({required this.firebaseFirestore});

  @override
  Future<String> deliverOrderToAdmin({required model.Order order
      // ,required PaymentModel paymentModel
      }) async {
    try {
      final listOfProductOrderModel =
          order.products.map((productOrder) => productOrder.toJson()).toList();
      // print(order.orderID);
      await firebaseFirestore
          .collection('userOrders')
          .doc(order.userID)
          .collection('orderDetails')
          .doc(order.orderID)
          .update({
        'deliveredProducts': FieldValue.arrayUnion(listOfProductOrderModel),
      });

      await firebaseFirestore
          .collection('vendorOrders')
          .doc(order.products[0].vendorID)
          .collection('orderDetails')
          .doc(order.orderID)
          .update({
        'deliveredProducts': FieldValue.arrayUnion(listOfProductOrderModel),
      });

      final orderModel = OrderModel(
          orderID: order.orderID,
          orderDate: order.orderDate,
          deliveryDate: order.deliveryDate,
          products: order.products,
          deliveredProducts: order.products,
          totalAmount: order.totalAmount,
          userID: order.userID,
          name: order.name,
          paymentID: order.paymentID,
          address: order.address,
          pin: order.pin,
          city: order.city,
          state: order.state,
          country: order.country,
          currency: order.currency,);

      await firebaseFirestore
          .collection('vendorOrderHistory')
          .doc(order.products[0].vendorID)
          .collection('orderDetails')
          .doc(order.orderID)
          .set(orderModel.toJson());

      await firebaseFirestore
          .collection('vendorOrders')
          .doc(order.products[0].vendorID)
          .collection('orderDetails')
          .doc(order.orderID)
          .delete();
      await firebaseFirestore
          .collection('vendorOrders')
          .doc(order.products[0].vendorID)
          .delete();

      // await firebaseFirestore.collection('vendorDeliveredItems').doc()
      return 'Hello';
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
