import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/common/domain/repository/repository.dart';
import 'package:tech_haven/core/entities/vendor.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/core/usecase/usecase.dart';

class GetVendorData implements UseCase<Vendor?, GetVendorDataParams> {
  final Repository repository;
  GetVendorData({required this.repository});

  @override
  Future<Either<Failure, Vendor?>> call(GetVendorDataParams params) async {
    return await repository.getVendorData(vendorID: params.vendorID);
  }
}

class GetVendorDataParams {
  final String vendorID;
  GetVendorDataParams({required this.vendorID});
}
