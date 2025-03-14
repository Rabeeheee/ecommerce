import 'package:tech_haven/core/common/data/model/revenue_model.dart';
import 'package:tech_haven/core/common/data/model/vendor_payment_model.dart';

abstract interface class RevenueDataSource {
  Future<RevenueModel> getRevenue({required String vendorID});
  Future<List<VendorPaymentModel>> getListOfVendorPayment(
      {required String vendorID});
}
