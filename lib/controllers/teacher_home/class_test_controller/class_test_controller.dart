import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:dujo_kerala_application/model/teacher_model/subjects_model.dart';
import 'package:dujo_kerala_application/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../../model/student_model/student_model.dart';
import '../../../model/teacher_home/test_class_model/test_class_model.dart';

class ClassTestController {
  final Uuid uid = const Uuid();
  SubjectModel? subjectModel;
  String classId =
      ""; //this value assign teacher select class inside the view>home>teacher_home>clickonclass.dart navigatiion function

  String time = "";
  int date = 0;
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController testNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final CollectionReference<Map<String, dynamic>> documentCollection =
      FirebaseFirestore.instance
          .collection("SchoolListCollection")
          .doc(UserCredentialsController.schoolId)
          .collection(UserCredentialsController.batchId ?? "")
          .doc(UserCredentialsController.batchId ?? "")
          .collection("classes");

  Future<void> createNewClassTest() async {
    if (classId.isEmpty) {
      log("Empty Class Id");
      return;
    }
    try {
      final String uniqueId = uid.v1();
      final List<StudentModel> studentList =
          await fetchAllStudentsFromClass(classId: classId);

      final ClassTestModel data = ClassTestModel(
        docId: uniqueId,
        testName: testNameController.text,
        subjectName: subjectModel?.subjectName ?? "",
        description: descriptionController.text,
        date: date,
        time: time,
        createdTime: Timestamp.now().millisecondsSinceEpoch,
        teacherId: UserCredentialsController.teacherModel?.docid ?? "",
        classId: UserCredentialsController.classId ?? "",
        subjectId: subjectModel?.docid ?? "",
        totalMark: -1,
        studentDetails: studentList
            .map(
              (e) => StudentClassMarkModel(
                mark: -1,
                studentId: e.docid,
              ),
            )
            .toList(),
      );
      await documentCollection
          .doc(classId)
          .collection("ClassTest")
          .doc(uniqueId)
          .set(data.toMap());
      clearAllFields();
      showToast(msg: "Created Successfully");
    } catch (e) {
      showToast(msg: "Something Went Wrong");
      log(e.toString());
    }
  }

  Future<List<StudentModel>> fetchAllStudentsFromClass(
      {required String classId}) async {
    try {
      final studentData =
          await documentCollection.doc(classId).collection("Students").get();

      return studentData.docs
          .map((e) => StudentModel.fromJson(e.data()))
          .toList();
    } catch (e) {
      showToast(msg: "Something went wrong");
      log(e.toString());
      return [];
    }
  }

  Future<List<SubjectModel>> fetchAllSubjectsFromClass() async {
    try {
      final subjectData =
          await documentCollection.doc(classId).collection("subjects").get();

      return subjectData.docs
          .map((e) => SubjectModel.fromMap(e.data()))
          .toList();
    } catch (e) {
      showToast(msg: "Something went wrong");
      log(e.toString());
      return [];
    }
  }

  bool isFieldEmpty() {
    if (classId.isEmpty ||
        date == -1 ||
        time.isEmpty ||
        descriptionController.text.isEmpty ||
        testNameController.text.isEmpty ||
        subjectModel == null) {
      showToast(msg: "All fields are mandatory");
      return true;
    } else {
      return false;
    }
  }

  void clearAllFields() {
    dateController.clear();
    timeController.clear();
    testNameController.clear();
    descriptionController.clear();
  }
}
