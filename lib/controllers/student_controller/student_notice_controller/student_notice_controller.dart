import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:dujo_kerala_application/model/notice_model/notice_model.dart';
import 'package:get/get.dart';

class StudentNoticeController extends GetxController {
  List<NoticeModel> noticeLists = [];
  Future<void> getNotices() async {
    QuerySnapshot<Map<String, dynamic>> noticeCollection =
        await FirebaseFirestore.instance
            .collection('SchoolListCollection')
            .doc(UserCredentialsController.schoolId)
            .collection(UserCredentialsController.batchId ?? "")
            .doc(UserCredentialsController.batchId ?? "")
            .collection('adminNotice')
            .get();
    for (var element in noticeCollection.docs) {
      noticeLists.add(
        NoticeModel.fromJson(
          element.data(),
        ),
      );
    }

    log(noticeLists[0].heading.toString());
  }

  @override
  void onInit() async {
    await getNotices();
    super.onInit();
  }
}
