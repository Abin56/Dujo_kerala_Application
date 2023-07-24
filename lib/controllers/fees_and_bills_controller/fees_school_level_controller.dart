import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/model/student_model/data_base_model.dart';
import 'package:dujo_kerala_application/utils/utils.dart';

import '../../model/fees_bills_model/fees_model.dart';
import '../userCredentials/user_credentials.dart';

class SchoolFeesController {
  static String className = "ClassFeesController";
  final CollectionReference<Map<String, dynamic>> _fireStore = FirebaseFirestore
      .instance
      .collection("SchoolListCollection")
      .doc(UserCredentialsController.schoolId)
      .collection(UserCredentialsController.batchId ?? "")
      .doc(UserCredentialsController.batchId)
      .collection("Fees");

  Future<List<FeesModel>> fetchAllFees({required String selectedClass}) async {
    try {
      if (selectedClass.isEmpty) {
        return [];
      }
      final QuerySnapshot<Map<String, dynamic>> data = await _fireStore
          .doc("Fees")
          .collection("SchoolFees")
          .doc(selectedClass)
          .collection("AllFees")
          .get();
      return data.docs.map((e) => FeesModel.fromMap(e.data())).toList();
    } catch (e) {
      log(e.toString(), name: "$className+fetchAllFees");
      showToast(msg: "Something went wrong");
      return [];
    }
  }

  Future<AddStudentModel?> fetchStudentData({required String studentId}) async {
    try {
      final DocumentReference<Map<String, dynamic>> data = FirebaseFirestore
          .instance
          .collection("SchoolListCollection")
          .doc(UserCredentialsController.schoolId)
          .collection(UserCredentialsController.batchId ?? "")
          .doc(UserCredentialsController.batchId)
          .collection("classes")
          .doc(UserCredentialsController.classId)
          .collection("Students")
          .doc(studentId);
      final result = await data.get();
      if (result.data() != null) {
        return AddStudentModel.fromMap(result.data()!);
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString(), name: "$className-fetchStudentData");
      showToast(msg: "Something Went Wrong");
    }
    return null;
  }
}
