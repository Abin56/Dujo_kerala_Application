import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../../model/teacher_home/test_class_model/test_class_model.dart';
import '../../../userCredentials/user_credentials.dart';
import '../class_test_controller.dart';

class ClassListMonthlyShowController {
  RxBool isLoading = RxBool(false);
  final CollectionReference<Map<String, dynamic>> documentCollection =
      FirebaseFirestore.instance
          .collection("SchoolListCollection")
          .doc(UserCredentialsController.schoolId)
          .collection(UserCredentialsController.batchId ?? "")
          .doc(UserCredentialsController.batchId ?? "")
          .collection("classes");
  RxList<ClassTestModel> allClassTestList = RxList();
  Future<void> fetchAllClassTest() async {
    try {
      isLoading.value = true;
      final QuerySnapshot<Map<String, dynamic>> allClassTest =
          await documentCollection
              .doc(Get.find<ClassTestController>().classId)
              .collection("ClassTestMonthly")
              .where("teacherId",
                  isEqualTo: UserCredentialsController.teacherModel?.docid)
              .get();
      isLoading.value = false;
      allClassTestList.value = allClassTest.docs
          .map((e) => ClassTestModel.fromMap(e.data()))
          .toList();
      allClassTestList.refresh();
    } catch (e) {
      isLoading.value = false;
      log(e.toString());
    }
  }
}
