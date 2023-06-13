import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:dujo_kerala_application/model/teacher_model/teacher_model.dart';
import 'package:dujo_kerala_application/utils/utils.dart';
import 'package:get/get.dart';

import '../../model/class_wise_subject_teacher_model/class_wise_subject_teacher_model.dart';

class TeacherListController {
  List<ClassWiseSubjectTeacherList> subjectList = [];
  RxBool isLoading = RxBool(false);
  CollectionReference<Map<String, dynamic>> firebaseFirestore =
      FirebaseFirestore.instance
          .collection('SchoolListCollection')
          .doc(UserCredentialsController.schoolId)
          .collection(UserCredentialsController.batchId ?? "")
          .doc(UserCredentialsController.batchId)
          .collection("classes")
          .doc(UserCredentialsController.classId)
          .collection("subjects");

  Future<List<ClassWiseSubjectTeacherList>> getAllSubjects() async {
    try {
      isLoading.value = true;
      final result = await firebaseFirestore.get();
      subjectList = result.docs
          .map((e) => ClassWiseSubjectTeacherList.fromMap(e.data()))
          .toList();
      isLoading.value = false;
      return subjectList;
    } catch (e) {
      isLoading.value = false;
      showToast(msg: "Something went wrong");
      log(e.toString());
      return [];
    }
  }

  Future<TeacherModel?> getTeacherData(String teacherId) async {
    if (teacherId.isEmpty) {
      return null;
    }
    try {
      final result = await FirebaseFirestore.instance
          .collection('SchoolListCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('Teachers')
          .doc(teacherId)
          .get();
      if (result.data() != null) {
        return TeacherModel.fromMap(result.data()!);
      } else {
        return null;
      }
    } catch (e) {
      showToast(msg: "Something went wrong");
      //log(e.toString());
    }
    return null;
  }
}
