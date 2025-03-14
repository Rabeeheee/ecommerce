import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/entities/vendor.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/core/usecase/usecase.dart';
import 'package:tech_haven/vendor/features/profile/domain/repository/vendor_profile_repository.dart';
class GetVendorProfile implements UseCase<Vendor, GetVendorProfileParams> {
  final VendorProfileRepository vendorRepository;

  GetVendorProfile({required this.vendorRepository});

  @override
  Future<Either<Failure, Vendor>> call(GetVendorProfileParams params) async {
    return await vendorRepository.getVendorProfile(params.vendorID);
  }
}

class GetVendorProfileParams {
  final String vendorID;

  GetVendorProfileParams({required this.vendorID});
}
