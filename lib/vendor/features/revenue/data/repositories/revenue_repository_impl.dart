
import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/entities/revenue.dart';
import 'package:tech_haven/core/entities/vendor_payment.dart';
import 'package:tech_haven/core/error/exceptions.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/vendor/features/revenue/data/datasource/revenue_data_source.dart';
import 'package:tech_haven/vendor/features/revenue/domain/repository/revenue_repository.dart';

class RevenueRepositoryImpl implements RevenueRepository{
  final RevenueDataSource revenueDataSource;
  RevenueRepositoryImpl({required this.revenueDataSource});
  @override
  Future<Either<Failure, Revenue>> getRevenue({required String vendorID}) async{
    try{
    final result = await revenueDataSource.getRevenue(vendorID: vendorID
       
      );
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<VendorPayment>>> getListOfRevenueData({required String vendorID}) async{
  try{
    final result = await revenueDataSource.getListOfVendorPayment(vendorID: vendorID
       
      );
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

}