import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tech_haven/core/common/data/model/revenue_model.dart';
import 'package:tech_haven/core/common/data/model/vendor_payment_model.dart';
import 'package:tech_haven/core/error/exceptions.dart';
import 'package:tech_haven/vendor/features/revenue/data/datasource/revenue_data_source.dart';

class RevenueDataSourceImpl implements RevenueDataSource {
  final FirebaseFirestore firebaseFirestore;
  RevenueDataSourceImpl({required this.firebaseFirestore});
  @override
  Future<RevenueModel> getRevenue({required String vendorID}) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> revenueSnapshot =
          await firebaseFirestore.collection('revenues').doc(vendorID).get();
      if (revenueSnapshot.exists) {
        final data = revenueSnapshot.data() as Map<String, dynamic>;
        if (data.isNotEmpty) {
          return RevenueModel.fromJson(data);
        } else {
          throw const ServerException("Failed to parse revenue data");
        }
      } else {
        throw const ServerException("The Particular Vendor Doesn't exist");
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<VendorPaymentModel>> getListOfVendorPayment(
      {required String vendorID}) async {
    try {
      final QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('revenues')
          .doc(vendorID)
          .collection('paymentHistory')
          .get();

      return snapshot.docs
          .map((doc) =>
              VendorPaymentModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
