import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/entities/vendor_payment.dart';
import 'package:tech_haven/core/usecase/usecase.dart';
import 'package:tech_haven/vendor/features/revenue/domain/repository/revenue_repository.dart';

import '../../../../../core/error/failures.dart';

class GetListOfRevenueData
    implements UseCase<List<VendorPayment>, GetListOfRevenueDataParams> {
  final RevenueRepository revenueRepository;
  GetListOfRevenueData({required this.revenueRepository});

  @override
  Future<Either<Failure, List<VendorPayment>>> call(
      GetListOfRevenueDataParams params) async {
    return await revenueRepository.getListOfRevenueData(
        vendorID: params.vendorID);
  }
}

class GetListOfRevenueDataParams {
  final String vendorID;
  GetListOfRevenueDataParams({required this.vendorID});
}
