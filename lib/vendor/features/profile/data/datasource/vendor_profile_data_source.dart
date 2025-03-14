import 'package:tech_haven/vendor/features/registervendor/data/models/vendor_model.dart';

abstract class VendorProfileDataSource {
  Future<VendorModel> fetchVendorProfile(String vendorID);
}
