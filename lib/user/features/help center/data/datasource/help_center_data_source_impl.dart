import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tech_haven/core/common/data/model/help_center_request_model.dart';
import 'package:tech_haven/core/common/data/model/help_request_model.dart';
import 'package:tech_haven/core/entities/help_request.dart';
import 'package:tech_haven/core/error/exceptions.dart';
import 'package:tech_haven/user/features/help%20center/data/datasource/help_center_data_source.dart';
import 'package:uuid/uuid.dart';

class HelpCenterDataSourceImpl implements HelpCenterDataSource {
  final FirebaseFirestore firestore;

  HelpCenterDataSourceImpl(this.firestore);

  @override
  Future<void> sendHelpRequest({
    required String userID,
    required String userName,
    required HelpRequest helpRequest,
  }) async {
    try {
      // print('asdfghjqwertyui');
      final DateTime dateTime = DateTime.now();
      final requestID = const Uuid().v4();
      final userDoc = firestore.collection('helpCenter').doc(userID);
      await userDoc.set(HelpCenterRequestModel(
              userID: userID, dateTime: dateTime, userName: userName)
          .toJson());

      final requestDoc = userDoc.collection('requests').doc(requestID);
      final HelpRequestModel helpRequestModel = HelpRequestModel(
        userID: userID,
          email: helpRequest.email,
          dateTime: helpRequest.dateTime,
          requestID: requestID,
          name: helpRequest.name,
          subject: helpRequest.subject,
          body: helpRequest.body);
      await requestDoc.set(helpRequestModel.toJson());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<HelpRequestModel>> getAllUserRequests(
      {required String userID}) async {
    try {
      List<HelpRequestModel> listOfHelpRequestModel = [];
      QuerySnapshot<Map<String, dynamic>> snapshots = await firestore
          .collection('helpCenter')
          .doc(userID)
          .collection('requests')
          .get();
      for (var snapshot in snapshots.docs) {
        if (snapshot.exists) {
          listOfHelpRequestModel
              .add(HelpRequestModel.fromJson(snapshot.data()));
        }
      }
      return listOfHelpRequestModel;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
