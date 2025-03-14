import 'package:tech_haven/core/common/data/model/help_request_model.dart';
import 'package:tech_haven/core/entities/help_request.dart';

abstract class HelpCenterDataSource {
  Future<void> sendHelpRequest({
    required String userID,
    required String userName,
    required HelpRequest helpRequest,
  });

  Future<List<HelpRequestModel>> getAllUserRequests(
       {required String userID});
}
