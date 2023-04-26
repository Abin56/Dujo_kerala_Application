import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../model/Signup_Image_Selction/image_selection.dart';
import '../../model/student_model/student_model.dart';
import '../userCredentials/user_credentials.dart';
import 'package:uuid/uuid.dart';

class StudentSignUpController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
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
  Uuid uuid = const Uuid();

  String? bloodGroup;
  String? gender;
  CollectionReference<Map<String, dynamic>> firebaseData = FirebaseFirestore
      .instance
      .collection("SchoolListCollection")
      .doc(UserCredentialsController.schoolId)
      .collection(UserCredentialsController.batchId ?? "")
      .doc(UserCredentialsController.batchId ?? "")
      .collection("Classes")
      .doc(UserCredentialsController.classId)
      .collection("Students");

//sign in with email and password firebase authentification
  void signIn(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      showToast(msg: "Fields are empty");
      return;
    }
    try {
      isLoading.value = true;
      final result = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (result.user != null) {
        userCredential = result.user;
      }
      isLoading.value = false;
    } catch (e) {
      showToast(msg: 'Login Failed');
      isLoading.value = false;
    }
  }

//fetching all students data from firebase
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

  //updating students data

  Future<void> updateStudentData() async {
    if (confirmPasswordController.text.isEmpty ||
        houseNameController.text.isEmpty ||
        houseNumberController.text.isEmpty ||
        placeController.text.isEmpty ||
        districtController.text.isEmpty ||
        altPhoneNoController.text.isEmpty ||
        dateOfBirthController.text.isEmpty ||
        bloodGroupController.text.isEmpty) {
      showToast(msg: "All Fields are mandatory");
      return;
    }
    String imageId = "";
    String imageUrl = "";
    try {
      isLoading.value = true;
      if (Get.find<GetImage>().pickedImage.isNotEmpty) {
        imageId = uuid.v1();
        final result = await FirebaseStorage.instance
            .ref("files/studentsProfilePhotos/$imageId")
            .putFile(File(Get.find<GetImage>().pickedImage.value));
        imageUrl = await result.ref.getDownloadURL();
      }

      firebaseData.doc(UserCredentialsController.studentModel?.uid).update({
        "alPhoneNumber": altPhoneNoController.text,
        "bloodgroup": bloodGroup,
        "dateofBirth": dateOfBirthController.text,
        "district": districtController.text,
        "gender": gender,
        "houseName": houseNameController.text,
        "place": placeController.text,
        "profileImageId": imageId,
        "profileImageUrl": imageUrl,
        "studentemail": emailController.text,
      });
      Get.find<GetImage>().pickedImage.value = "";
      isLoading.value = false;
    } catch (e) {
      showToast(msg: "Updation Failed");
      isLoading.value = false;
    }
  }

  @override
  void onInit() async {
    await getStudentData();
    super.onInit();
  }

  void clearFields() {
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    houseNameController.clear();
    houseNumberController.clear();
    placeController.clear();
    districtController.clear();
    altPhoneNoController.clear();
    dateOfBirthController.clear();
    bloodGroupController.clear();
  }
}
