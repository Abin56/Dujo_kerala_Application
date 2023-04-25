import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../model/student_model/student_model.dart';
import '../userCredentials/user_credentials.dart';

class StudentSignUpController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController houseNameController = TextEditingController();
  TextEditingController houseNumberController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController altPhoneNoController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController bloodGroupController = TextEditingController();
  User? userCredential;
  RxBool isLoading = RxBool(false);
  List<StudentModel> classWiseStudentList = [];

  String? bloodGroup;
  String? gender;
  String? dateOfBirth;
  CollectionReference<Map<String, dynamic>> firebaseData = FirebaseFirestore
      .instance
      .collection("SchoolListCollection")
      .doc(UserCredentialsController.schoolId)
      .collection(UserCredentialsController.batchId ?? "")
      .doc(UserCredentialsController.batchId ?? "")
      .collection("Classes")
      .doc(UserCredentialsController.classId)
      .collection("Students");

  void signIn(String email, String password) async {
    try {
      isLoading.value = true;
      final result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      if (result.user != null) {
        userCredential = result.user;
      }
      isLoading.value = false;
    } catch (e) {
      showToast(msg: 'Login Failed');
      isLoading.value = false;
    }
  }

  Future<void> addStudentProfileData() async {
    try {} catch (e) {
      showToast(msg: 'Updation Failed');
    }
  }

  Future<void> getStudentData() async {
    try {
      isLoading.value = true;
      final result = await firebaseData.get();
      if (result.docs.isNotEmpty) {
        for (var element in result.docs) {
          classWiseStudentList.add(
            StudentModel.fromJson(
              element.data(),
            ),
          );
        }
      }
      isLoading.value = false;
    } catch (e) {
      showToast(msg: "Student fetching failed");
      isLoading.value = false;
    }
  }

  Future<void> updateStudentData(String imageId, String imageUrl) async {
    firebaseData.doc(UserCredentialsController.studentModel?.uid).update({
      "alPhoneNumber": altPhoneNoController.text,
      "bloodgroup": bloodGroup,
      "dateofBirth": dateOfBirth,
      "district": districtController.text,
      "gender": gender,
      "houseName": houseNameController.text,
      "place": placeController.text,
      "profileImageId": imageId,
      "profileImageUrl": imageUrl,
      "studentemail": emailController.text,
    });
  }

  @override
  void onInit() async {
    await getStudentData();
    super.onInit();
  }
}
