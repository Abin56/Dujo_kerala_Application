import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:dujo_kerala_application/utils/utils.dart';

class TestNotificationController {
  final _firebase = FirebaseFirestore.instance
      .collection("SchoolListCollection")
      .doc(UserCredentialsController.schoolId)
      .collection(UserCredentialsController.batchId ?? "")
      .doc(UserCredentialsController.batchId ?? "")
      .collection("classes");

  Set<String> tokenId = {};

  Future<void> sendTestNotification({
    required String classId,
    required String body,
    required String title,
  }) async {
    try {
      Future.wait([
        fetchParentId(classId: classId),
        fetchStudentId(classId: classId),
        fetchGuardianId(classId: classId)
      ]).then((value) => showToast(msg: "Succesfully send Notification"));
    } catch (e) {
      showToast(msg: "Something went wrong");
      log(e.toString());
    }
    for (var element in tokenId) {
      log(element);
      await sendPushMessage(element, body, title);
    }
  }

  Future<void> fetchParentId({required String classId}) async {
    final data =
        await _firebase.doc(classId).collection("ParentCollection").get();
    for (var element in data.docs) {
      tokenId.add(element.data()["deviceToken"]);
    }
  }

  Future<void> fetchStudentId({required String classId}) async {
    final data = await _firebase.doc(classId).collection("Students").get();
    for (var element in data.docs) {
      tokenId.add(element.data()["deviceToken"]);
    }
  }

  Future<void> fetchGuardianId({required String classId}) async {
    final data =
        await _firebase.doc(classId).collection("GuardianCollection").get();
    for (var element in data.docs) {
      tokenId.add(element.data()["deviceToken"]);
    }
  }
}
