import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/entities/help_request.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/core/usecase/usecase.dart';
import 'package:tech_haven/user/features/help%20center/domain/repository/help_center_repsitory.dart';

class GetAllUserRequestsUseCase implements UseCase<List<HelpRequest>, GetAllUserRequestsParams> {
  final HelpCenterRepository helpCenterRepository;

  GetAllUserRequestsUseCase({required this.helpCenterRepository});

  @override
  Future<Either<Failure, List<HelpRequest>>> call(GetAllUserRequestsParams params) async {
    return await helpCenterRepository.getAllUserRequests(userID: params.userID);
  }
}

class GetAllUserRequestsParams {
  final String userID;
  GetAllUserRequestsParams({
    required this.userID,
  });
}
