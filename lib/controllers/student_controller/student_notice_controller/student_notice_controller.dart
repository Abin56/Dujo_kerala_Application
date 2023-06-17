import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:dujo_kerala_application/utils/utils.dart';
import 'package:get/get.dart';

import '../../../model/notice_model/class_level_notice_model.dart';
import '../../../model/notice_model/school_level_notice_model.dart';

class StudentNoticeController extends GetxController {
  List<SchoolLevelNoticeModel> schoolLevelNoticeLists = [];
  List<ClassLevelNoticeModel> classLevelNoticeLists = [];
  RxBool isLoading = RxBool(false);
  Future<void> getSchoolLevelNotices() async {
    try {
      isLoading.value = true;
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

      QuerySnapshot<Map<String, dynamic>> noticeCollection =
          await FirebaseFirestore.instance
              .collection('SchoolListCollection')
              .doc(UserCredentialsController.schoolId)
              .collection(UserCredentialsController.batchId ?? "")
              .doc(UserCredentialsController.batchId ?? "")
              .collection('adminNotice')
              .where(visiblePerson, isEqualTo: true)
              .get();

      schoolLevelNoticeLists = noticeCollection.docs
          .map((e) => SchoolLevelNoticeModel.fromMap(e.data()))
          .toList();

      schoolLevelNoticeLists.sort(
        (a, b) {
          return b.publishedDate.compareTo(a.publishedDate);
        },
      );

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      showToast(msg: "Something Error");
    }
  }

  Future<void> getClassLevelNotices() async {
    try {
      isLoading.value = true;
      QuerySnapshot<Map<String, dynamic>> noticeCollection =
          await FirebaseFirestore.instance
              .collection('SchoolListCollection')
              .doc(UserCredentialsController.schoolId)
              .collection(UserCredentialsController.batchId ?? "")
              .doc(UserCredentialsController.batchId ?? "")
              .collection('classes')
              .doc(UserCredentialsController.classId ?? "")
              .collection('ClassNotice')
              .get();

      classLevelNoticeLists = noticeCollection.docs
          .map((e) => ClassLevelNoticeModel.fromMap(e.data()))
          .toList();

      classLevelNoticeLists.sort(
        (a, b) {
          return b.date.compareTo(a.date);
        },
      );
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      showToast(msg: "Something went wrong");
    }
  }

  @override
  void onInit() async {
    await getSchoolLevelNotices();
    await getClassLevelNotices();
    super.onInit();
  }
}
