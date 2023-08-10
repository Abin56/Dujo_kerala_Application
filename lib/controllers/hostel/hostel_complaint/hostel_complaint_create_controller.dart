import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:dujo_kerala_application/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/hostel/hostel_model_complaint.dart';

class HostelComplaintCreateController {
  static String className =
      "HostelComplaintCreateController"; //for debugging log

  RxBool isLoading = RxBool(false);
  TextEditingController complaintController = TextEditingController();
  TextEditingController complaintTitleController = TextEditingController();

  final _firestore = FirebaseFirestore.instance
      .collection("SchoolListCollection")
      .doc(UserCredentialsController.schoolId)
      .collection("Hostel")
      .doc("Hostel")
      .collection("Complaints");

  Future<void> createHostelComplaint(
      {required HostelModelComplaint hostel}) async {
    try {
      isLoading.value = true;
      await _firestore.add(hostel.toMap()).then(
            (value) async => await _firestore.doc(value.id).update(
              {"docId": value.id},
            ),
          );
      showToast(msg: "Successfully Created");
      clearControllers();
      isLoading.value = false;
    } catch (e) {
      showToast(msg: "Something went wrong");
      isLoading.value = false;
      log(e.toString(), name: className);
    }
  }

  bool isValid() {
    if (complaintController.text.isEmpty &&
        complaintTitleController.text.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  void clearControllers() {
    complaintController.clear();
    complaintTitleController.clear();
  }
}
