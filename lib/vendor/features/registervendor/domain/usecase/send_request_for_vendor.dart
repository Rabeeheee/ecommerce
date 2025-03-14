

import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/entities/user.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/core/usecase/usecase.dart';
import 'package:tech_haven/vendor/features/registervendor/domain/repository/register_vendor_repository.dart';

class SendRequestForVendor
    implements UseCase<String, SendRequestForVendorParams> {
  final RegisterVendorRepository registerVendorRepository;
  SendRequestForVendor({required this.registerVendorRepository});

  @override
  Future<Either<Failure, String>> call(
      SendRequestForVendorParams params) async {
    return await registerVendorRepository.sendRequestForVendor(
      businessPicture: params.businessPicture,
      user: params.user,
      physicalAddress: params.physicalAddress,
      businessName: params.businessName,
      accountNumber: params.accountNumber,
    );
  }
}

class SendRequestForVendorParams {
  final dynamic businessPicture;
  final User user;
  final String businessName;
  final String physicalAddress;
  final String accountNumber;

  SendRequestForVendorParams({
    required this.user,
    required this.businessPicture,
    required this.businessName,
    required this.physicalAddress,
    required this.accountNumber,
  });
}
