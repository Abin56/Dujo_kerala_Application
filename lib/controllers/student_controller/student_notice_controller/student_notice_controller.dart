import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:get/get.dart';

import '../../../model/notice_model/class_level_notice_model.dart';
import '../../../model/notice_model/school_level_notice_model.dart';

class StudentNoticeController extends GetxController {
  List<SchoolLevelNoticeModel> schoolLevelNoticeLists = [];
  List<ClassLevelNoticeModel> classLevelNoticeLists = [];
  Future<void> getSchoolLevelNotices() async {
    QuerySnapshot<Map<String, dynamic>> noticeCollection =
        await FirebaseFirestore.instance
            .collection('SchoolListCollection')
            .doc(UserCredentialsController.schoolId)
            .collection(UserCredentialsController.batchId ?? "")
            .doc(UserCredentialsController.batchId ?? "")
            .collection('adminNotice')
            .get();

    schoolLevelNoticeLists = noticeCollection.docs
        .map((e) => SchoolLevelNoticeModel.fromMap(e.data()))
        .toList();
  }

  Future<void> getClassLevelNotices() async {
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
  }

  @override
  void onInit() async {
    await getSchoolLevelNotices();
    await getClassLevelNotices();
    super.onInit();
  }
}
