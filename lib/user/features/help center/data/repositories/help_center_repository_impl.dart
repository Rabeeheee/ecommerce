
import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/common/data/model/help_request_model.dart';
import 'package:tech_haven/core/entities/help_request.dart';
import 'package:tech_haven/core/error/exceptions.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/user/features/help%20center/data/datasource/help_center_data_source.dart';
import 'package:tech_haven/user/features/help%20center/domain/repository/help_center_repsitory.dart';

class HelpCenterRepositoryImpl implements HelpCenterRepository {
  final HelpCenterDataSource dataSource;

  HelpCenterRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, void>> sendHelpRequest({
    required String userID,
    required String userName,
    required HelpRequest helpRequest,
  }) async {
    try {
      await dataSource.sendHelpRequest(userID: userID, userName: userName, helpRequest: helpRequest);
      return right(null);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<HelpRequestModel>>> getAllUserRequests( {required String userID}) async{
       try {
  final result =    await dataSource.getAllUserRequests(userID: userID);
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}