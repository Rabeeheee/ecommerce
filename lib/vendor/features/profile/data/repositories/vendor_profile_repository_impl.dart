import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/entities/vendor.dart';
import 'package:tech_haven/core/error/exceptions.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/vendor/features/profile/data/datasource/vendor_profile_data_source.dart';
import 'package:tech_haven/vendor/features/profile/domain/repository/vendor_profile_repository.dart';

class VendorProfileRepositoryImpl implements VendorProfileRepository {
  final VendorProfileDataSource vendorProfileDataSource;

  VendorProfileRepositoryImpl({required this.vendorProfileDataSource});
  
  @override
  Future<Either<Failure, Vendor>> getVendorProfile(String vendorID) async{
      try {
      final vendor = await vendorProfileDataSource.fetchVendorProfile(vendorID);
      return right(vendor);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
