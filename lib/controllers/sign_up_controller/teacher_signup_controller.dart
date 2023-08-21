import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/model/teacher_model/teacher_model.dart';
import 'package:dujo_kerala_application/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../model/Signup_Image_Selction/image_selection.dart';
import '../userCredentials/user_credentials.dart';

class TeacherSignUpController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController houseNameController = TextEditingController();
  TextEditingController houseNumberController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController altPhoneNoController = TextEditingController();

  String name = "TeacherSignupController";

  RxBool isLoading = RxBool(false);
  List<TeacherModel> teachersList = [];
  Uuid uuid = const Uuid();
  String? gender;
  DocumentReference<Map<String, dynamic>> firebaseData = FirebaseFirestore
      .instance
      .collection("SchoolListCollection")
      .doc(UserCredentialsController.schoolId);

//fetching all teachers data from firebase
  Future<void> getTeacherData() async {
    try {
      isLoading.value = true;
      final result = await firebaseData.collection("TempTeacherList").get();
      if (result.docs.isNotEmpty) {
        teachersList =
            result.docs.map((e) => TeacherModel.fromMap(e.data())).toList();
      }

      isLoading.value = false;
    } catch (e) {
      showToast(msg: 'Some error occured');
      log(name: name, e.toString());
      isLoading.value = false;
    }
  }

  //updating students data

  Future<void> updateTeacherData() async {
    String imageId = "";
    String imageUrl = "";
    try {
      if (Get.find<GetImage>().pickedImage.isNotEmpty) {
        isLoading.value = true;
        imageId = uuid.v1();
        final result = await FirebaseStorage.instance
            .ref(
                "files/teacherPhotos/${UserCredentialsController.schoolId}/${UserCredentialsController.batchId}/${UserCredentialsController.teacherModel?.teacherName}$imageId")
            .putFile(File(Get.find<GetImage>().pickedImage.value));
        imageUrl = await result.ref.getDownloadURL();
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        )
            .then((value) {
          final teacherNewModel = TeacherModel(
            teacherName:
                UserCredentialsController.teacherModel?.teacherName ?? "",
            teacherEmail: emailController.text.trim(),
            houseName: houseNameController.text,
            houseNumber: houseNumberController.text,
            place: placeController.text,
            gender: gender ?? "",
            district: districtController.text,
            altPhoneNo: altPhoneNoController.text,
            employeeID:
                UserCredentialsController.teacherModel?.employeeID ?? "",
            createdAt: UserCredentialsController.teacherModel?.createdAt ?? "",
            teacherPhNo:
                UserCredentialsController.teacherModel?.teacherPhNo ?? "",
            docid: value.user?.uid ?? "",
            userRole: "teacher",
            imageId: imageId,
            imageUrl: imageUrl,
          );
          firebaseData
              .collection("Teachers")
              .doc(value.user?.uid)
              .set(teacherNewModel.toMap())
              .then((value) {
            firebaseData
                .collection('TempTeacherList')
                .doc(UserCredentialsController.teacherModel?.docid)
                .delete();
          });
        });

        Get.find<GetImage>().pickedImage.value = "";
        isLoading.value = false;
      } else {
        showToast(msg: "Please upload profile image");
      }
    } catch (e) {
      showToast(msg: "Failed to update teachers data");
      log(name: name, e.toString());
      isLoading.value = false;
    }
  }

  @override
  void onInit() async {
    await getTeacherData();
    super.onInit();
  }

  void clearFields() {
    emailController.clear();
    nameController.clear();
    houseNameController.clear();
    houseNumberController.clear();
    placeController.clear();
    districtController.clear();
    altPhoneNoController.clear();
  }

  bool checkAllFieldIsEmpty() {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        houseNameController.text.isEmpty ||
        houseNumberController.text.isEmpty ||
        placeController.text.isEmpty ||
        districtController.text.isEmpty ||
        altPhoneNoController.text.isEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
