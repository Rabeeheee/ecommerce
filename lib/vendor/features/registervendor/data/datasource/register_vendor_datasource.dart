
import 'package:tech_haven/core/entities/user.dart';

abstract interface class RegisterVendorDataSource {
  Future<String> sendRequestForVendor(
      {required User user,
      required dynamic businessPicture,
      required String businessName,
      required String physicalAddress,
      required String accountNumber});
        Future<String> checkForVendorStatus(
      {required String vendorID,});
}
