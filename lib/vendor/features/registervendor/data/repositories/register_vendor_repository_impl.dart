
import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/entities/user.dart';
import 'package:tech_haven/core/error/exceptions.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/vendor/features/registervendor/data/datasource/register_vendor_datasource.dart';
import 'package:tech_haven/vendor/features/registervendor/domain/repository/register_vendor_repository.dart';

class RegisterVendorRepositoryImpl implements RegisterVendorRepository {
  final RegisterVendorDataSource registerVendorDataSource;
  RegisterVendorRepositoryImpl({required this.registerVendorDataSource});
  @override
  Future<Either<Failure, String>> sendRequestForVendor({
    required User user,
    required dynamic businessPicture,
    required String businessName,
    required String physicalAddress,
    required String accountNumber,
  }) async {
    try {
      final result = await registerVendorDataSource.sendRequestForVendor(
        user: user,
        businessPicture: businessPicture,
        businessName: businessName,
        physicalAddress: physicalAddress,
        accountNumber: accountNumber,
      );
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> checkForVendorStatus(
      {required String vendorID}) async {
    try {
      final result = await registerVendorDataSource.checkForVendorStatus(
          vendorID: vendorID);
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
