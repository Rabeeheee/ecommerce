import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/entities/help_request.dart';
import 'package:tech_haven/core/error/failures.dart';

abstract class HelpCenterRepository {
  Future<Either<Failure, void>> sendHelpRequest({
    required String userID,
    required String userName,
    required HelpRequest helpRequest,
  });
  Future<Either<Failure, List<HelpRequest>>> getAllUserRequests(
      {required String userID});
}
