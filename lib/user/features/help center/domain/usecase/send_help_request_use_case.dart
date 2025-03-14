import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/common/data/model/help_request_model.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/core/usecase/usecase.dart';
import 'package:tech_haven/user/features/help%20center/domain/repository/help_center_repsitory.dart';

class SendHelpRequestUseCase implements UseCase<void, SendHelpRequestParams> {
  final HelpCenterRepository helpCenterRepository;

  SendHelpRequestUseCase({required this.helpCenterRepository});

  @override
  Future<Either<Failure, void>> call(SendHelpRequestParams params) async {
    return await helpCenterRepository.sendHelpRequest(
        userID: params.userID,
        userName: params.userName,
        helpRequest: params.helpRequest);
  }
}

class SendHelpRequestParams {
  final String userID;
  final String userName;
  final HelpRequestModel helpRequest;

  SendHelpRequestParams({
    required this.userID,
    required this.userName,
    required this.helpRequest,
  });
}
