import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/entities/vendor.dart';
import 'package:tech_haven/core/error/failures.dart';

abstract class VendorProfileRepository {
 Future<Either<Failure, Vendor>> getVendorProfile(String vendorID);
}
