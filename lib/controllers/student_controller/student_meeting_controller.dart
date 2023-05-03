import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../model/meeting_model/meeting_model.dart';
import '../userCredentials/user_credentials.dart';

class StudentMeetingController extends GetxController {
  List<MeetingModel> meetingLists = [];
  Future<void> getNotices() async {
    QuerySnapshot<Map<String, dynamic>> noticeCollection =
        await FirebaseFirestore.instance
            .collection('SchoolListCollection')
            .doc(UserCredentialsController.schoolId)
            .collection(UserCredentialsController.batchId ?? "")
            .doc(UserCredentialsController.batchId ?? "")
            .collection('AdminMeeting')
            .get();

    meetingLists = noticeCollection.docs
        .map(
          (e) => MeetingModel.fromJson(
            e.data(),
          ),
        )
        .toList();
  }

  @override
  void onInit() async {
    await getNotices();
    super.onInit();
  }
}
