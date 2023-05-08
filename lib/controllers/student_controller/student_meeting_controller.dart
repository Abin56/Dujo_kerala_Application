import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/utils/utils.dart';
import 'package:get/get.dart';

import '../../model/meeting_model/meeting_model.dart';
import '../userCredentials/user_credentials.dart';

class StudentMeetingController extends GetxController {
  RxBool isLoading = RxBool(false);
  List<MeetingModel> meetingLists = [];
  Future<void> getMeetings() async {
    String visiblePerson = "";

    ///this condition added for this notice widget used 3 places student,parent,guardian
    ///so there is only one change in filtering
    if (UserCredentialsController.userRole == "student") {
      visiblePerson = "visibleStudent";
    } else if (UserCredentialsController.userRole == "parent" ||
        UserCredentialsController.userRole == "guardian") {
      visiblePerson = "visibleGuardian";
    } else {
      visiblePerson = "visibleTeacher";
    }
    try {
      isLoading.value = true;
      QuerySnapshot<Map<String, dynamic>> noticeCollection =
          await FirebaseFirestore.instance
              .collection('SchoolListCollection')
              .doc(UserCredentialsController.schoolId)
              .collection(UserCredentialsController.batchId ?? "")
              .doc(UserCredentialsController.batchId ?? "")
              .collection('AdminMeeting')
              .where(visiblePerson, isEqualTo: true)
              .get();

      meetingLists = noticeCollection.docs
          .map(
            (e) => MeetingModel.fromJson(
              e.data(),
            ),
          )
          .toList();
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      showToast(msg: 'Something Error');
    }
  }

  @override
  void onInit() async {
    await getMeetings();
    super.onInit();
  }
}
