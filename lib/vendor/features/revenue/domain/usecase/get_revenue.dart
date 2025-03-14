
import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/entities/revenue.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/core/usecase/usecase.dart';
import 'package:tech_haven/vendor/features/revenue/domain/repository/revenue_repository.dart';

class GetRevenue implements UseCase<Revenue, GetRevenueParams> {
  final RevenueRepository revenueRepository;
  GetRevenue({required this.revenueRepository});
  @override
  Future<Either<Failure, Revenue>> call(GetRevenueParams params) async {
    return await revenueRepository.getRevenue(vendorID: params.vendorID);
  }
}

class GetRevenueParams {
  final String vendorID;
  GetRevenueParams({required this.vendorID});
}
