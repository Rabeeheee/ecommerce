import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/entities/revenue.dart';
import 'package:tech_haven/core/entities/vendor_payment.dart';
import 'package:tech_haven/core/error/failures.dart';

abstract interface class RevenueRepository{
  Future<Either<Failure,Revenue>> getRevenue({required String vendorID});
  Future<Either<Failure,List<
  VendorPayment> >>getListOfRevenueData({required String vendorID});
}