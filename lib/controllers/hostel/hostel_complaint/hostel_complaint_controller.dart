import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/utils/utils.dart';

import '../../../model/hostel/hostel_model_complaint.dart';
import '../../../model/student_model/student_model.dart';
import '../../userCredentials/user_credentials.dart';

class HostelComplaintController {
  static const String className = "HostelComplaintController";
  final CollectionReference<Map<String, dynamic>> _firestore = FirebaseFirestore
      .instance
      .collection("SchoolListCollection")
      .doc(UserCredentialsController.schoolId)
      .collection("Hostel")
      .doc("Hostel")
      .collection("Complaints");
  Future<List<HostelModelComplaint>> fetchAllComplaintPending() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> complaints =
          await _firestore.get();

      final List<HostelModelComplaint> filteredData = complaints.docs
          .map((e) => HostelModelComplaint.fromMap(e.data()))
          .toList()
          .where((element) => !element.isCompleted)
          .toList();
      filteredData.sort((a, b) => a.date.compareTo(b.date));
      return filteredData;
    } catch (e) {
      showToast(msg: "Something went wrong");
      log(e.toString(), name: className);
      return [];
    }
  }

  Future<List<HostelModelComplaint>> fetchAllComplaintCompleted() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> complaints =
          await _firestore.get();

      final List<HostelModelComplaint> filteredData = complaints.docs
          .map((e) => HostelModelComplaint.fromMap(e.data()))
          .toList()
          .where((element) => element.isCompleted)
          .toList();
      filteredData.sort((a, b) => a.date.compareTo(b.date));
      return filteredData;
    } catch (e) {
      showToast(msg: "Something went wrong");
      log(e.toString(), name: className);
      return [];
    }
  }

  Future<StudentModel?> getStudentData({required String studentId}) async {
    try {
      final studentData = await FirebaseFirestore.instance
          .collection("SchoolListCollection")
          .doc(UserCredentialsController.schoolId)
          .collection(UserCredentialsController.batchId ?? "")
          .doc(UserCredentialsController.batchId ?? "")
          .collection("classes")
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
