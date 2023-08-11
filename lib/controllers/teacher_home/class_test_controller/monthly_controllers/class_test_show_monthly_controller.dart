import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../model/student_model/student_model.dart';
import '../../../../model/teacher_home/test_class_model/test_class_model.dart';
import '../../../userCredentials/user_credentials.dart';
import 'class_test_list_monthly_controllers.dart';
import 'class_test_monthly_controller.dart';

class ShowTestMonthlyController {
  RxBool isLoading = RxBool(false);
  final CollectionReference<Map<String, dynamic>> documentCollection =
      FirebaseFirestore.instance
          .collection("SchoolListCollection")
          .doc(UserCredentialsController.schoolId)
          .collection(UserCredentialsController.batchId ?? "")
          .doc(UserCredentialsController.batchId ?? "")
          .collection("classes");
  ClassTestModel? selectedClassTestModel;
  TextEditingController totalMarkController = TextEditingController();
  Map<String, TextEditingController> textEditingcontrollerMap = {};

  void assigningValuesToControllers() {
    textEditingcontrollerMap.clear();
    String? totalValue = selectedClassTestModel!.totalMark == -1
        ? null
        : selectedClassTestModel!.totalMark.toString();
    totalMarkController.text = totalValue ?? "";
    for (var element in selectedClassTestModel!.studentDetails) {
      textEditingcontrollerMap.putIfAbsent(
        element.studentId,
        () => TextEditingController(),
      );
      String? value = element.mark == -1 ? null : element.mark.toString();
      textEditingcontrollerMap[element.studentId]?.text = value ?? "";
    }
  }

  Future<StudentModel?> getStudentData({required String studentId}) async {
    try {
      final studentData = await documentCollection
          .doc(Get.find<ClassTestMonthlyController>().classId)
          .collection("Students")
          .doc(studentId)
          .get();

      return StudentModel.fromJson(studentData.data() ?? {});
    } catch (e) {
      return null;
    }
  }

  Future<void> updateStudentsMark({required BuildContext context}) async {
    try {
      isLoading.value = true;
      List<Map<String, dynamic>> listData = [];
      textEditingcontrollerMap.forEach((key, value) {
        listData.add({"studentId": key, "mark": int.parse(value.text)});
      });
      await documentCollection
          .doc(Get.find<ClassTestMonthlyController>().classId)
          .collection("ClassTestMonthly")
          .doc(selectedClassTestModel?.docId ?? "")
          .update({
        "studentDetails": listData,
        "totalMark": int.parse(totalMarkController.text)
      });
      await Get.find<ClassListMonthlyShowController>().fetchAllClassTest();

      isLoading.value = false;
      showToast(msg: "Successfully updated");
    } catch (e) {
      isLoading.value = false;
      log(e.toString());
      showToast(msg: "Something went wrong");
    }
  }

  Future<void> updateStudentsData(
      {required String key, required dynamic value}) async {
    try {
      isLoading.value = true;
      await documentCollection
          .doc(Get.find<ClassTestMonthlyController>().classId)
          .collection("ClassTestMonthly")
          .doc(selectedClassTestModel?.docId ?? "")
          .update({
        key: value,
      });
      await assignValueToselectedClassTestModel(key, value);
      isLoading.value = false;
      await Get.find<ClassListMonthlyShowController>().fetchAllClassTest();

      showToast(msg: "Successfully updated");
    } catch (e) {
      log(e.toString());
      showToast(msg: "Something went wrong");
      isLoading.value = false;
    }
  }

  Future<void> assignValueToselectedClassTestModel(
      String key, dynamic value) async {
    switch (key) {
      case "testName":
        selectedClassTestModel?.testName = value;
        break;
      case "description":
        selectedClassTestModel?.description = value;
        break;
      case "subjectName":
        selectedClassTestModel?.subjectName = value;
        break;
      case "date":
        selectedClassTestModel?.date = value;
        break;
      case "time":
        selectedClassTestModel?.time = value;
        break;
      default:
    }
  }
}
