import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/core/usecase/usecase.dart';
import 'package:tech_haven/vendor/features/registervendor/domain/repository/register_vendor_repository.dart';
class CheckForVendorStatus
    implements UseCase<String, CheckForVendorStatusParams> {
  final RegisterVendorRepository registerVendorRepository;
  CheckForVendorStatus({required this.registerVendorRepository});

  @override
  Future<Either<Failure, String>> call(
      CheckForVendorStatusParams params) async {
    return await registerVendorRepository.checkForVendorStatus(
     vendorID: params.vendorID
    );
  }
}

class CheckForVendorStatusParams {
  final String vendorID;

  CheckForVendorStatusParams({
    required this.vendorID
  });
}
