import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../model/student_model/student_model.dart';
import '../../model/teacher_home/test_class_model/test_class_model.dart';
import '../userCredentials/user_credentials.dart';

class AllClassListMonthlyShowController {
  RxBool isLoading = RxBool(false);
  ClassTestModel? classTestModel;
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
              .doc(UserCredentialsController.classId)
              .collection("ClassTestMonthly")
              .get();
      isLoading.value = false;
      allClassTestList.value = allClassTest.docs.map((e) {
        return ClassTestModel.fromMap(e.data());
      }).toList();

      allClassTestList.refresh();
    } catch (e) {
      isLoading.value = false;
      log(e.toString());
    }
  }

  Future<StudentModel?> getStudentData({required String studentId}) async {
    try {
      final studentData = await documentCollection
          .doc(UserCredentialsController.classId)
          .collection("Students")
          .doc(studentId)
          .get();

      return StudentModel.fromJson(studentData.data() ?? {});
    } catch (e) {
      return null;
    }
  }
}
