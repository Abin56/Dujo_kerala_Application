import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:dujo_kerala_application/main.dart';
import 'package:dujo_kerala_application/view/home/sample/under_maintance.dart';
import 'package:dujo_kerala_application/view/pages/login/dujo_login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserCheckController extends GetxController {
  CollectionReference<Map<String, dynamic>> studentData = FirebaseFirestore
      .instance
      .collection("SchoolListCollection")
      .doc(UserCredentialsController.schoolId)
      .collection(UserCredentialsController.batchId ?? "")
      .doc(UserCredentialsController.batchId ?? "")
      .collection("Classes")
      .doc(UserCredentialsController.classId)
      .collection("Students");

  Future<void> checkUserUid() async {
    User? currentUser = auth.currentUser;
    if (currentUser == null) {
      Get.to(const DujoLoginScren());
    } else {
      log('UID: ${currentUser.uid}');

      final QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await studentData.where('uid', isEqualTo: currentUser.uid).get();
      if (querySnapshot.docs.length == 1) {
        log('student!!');
      } else {
        log('not a student!!');
      }
      Get.to(const UnderMaintanceScreen(
        text: "Homeeee",
      ));
    }
  }
}
