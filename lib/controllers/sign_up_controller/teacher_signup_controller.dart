import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/model/teacher_model/teacher_model.dart';
import 'package:dujo_kerala_application/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../model/Signup_Image_Selction/image_selection.dart';
import '../../model/student_model/student_model.dart';
import '../userCredentials/user_credentials.dart';
import 'package:uuid/uuid.dart';

class TeacherSignUpController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController comfirmPasswordController = TextEditingController();
  TextEditingController houseNameController = TextEditingController();
  TextEditingController houseNumberController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController altPhoneNoController = TextEditingController();
 // TextEditingController genderController = TextEditingController();

  User? userCredential;
  RxBool isLoading = RxBool(false);
  List<TeacherModel> teachersList = [];
  Uuid uuid = const Uuid();

  //String? bloodGroup;
  String? gender;
  CollectionReference<Map<String, dynamic>> firebaseData = FirebaseFirestore
      .instance
      .collection("SchoolListCollection")
      .doc(UserCredentialsController.schoolId)
      .collection('Teachers');
      // .collection(UserCredentialsController.batchId ?? "")
      // .doc(UserCredentialsController.batchId ?? "")
      // .collection("Classes")
      // .doc(UserCredentialsController.classId)
      // .collection("Students");

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

//fetching all teachers data from firebase
  Future<void> getTeacherData() async {
    try {
      isLoading.value = true;
      final result = await firebaseData.get();
      if (result.docs.isNotEmpty) {
        for (var element in result.docs) {
          log(element.data()["teacherPhNo"].toString());
          teachersList.add(
            TeacherModel.fromJson(
              element.data(),
            ),
          );

          
        }
      
      }

      isLoading.value = false;
    } catch (e) {

      showToast(msg: e.toString());
      isLoading.value = false;
    }
  }

  //updating students data

  Future<void> updateTeacherData() async {
    String imageId = "";
    String imageUrl = "";
    try {
      isLoading.value = true;
      if (Get.find<GetImage>().pickedImage.isNotEmpty) {
        imageId = uuid.v1();
        final result = await FirebaseStorage.instance
            .ref("files/teacherPhotos/$imageId")
            .putFile(File(Get.find<GetImage>().pickedImage.value));
        imageUrl = await result.ref.getDownloadURL();
      }

      firebaseData.doc(UserCredentialsController.teacherModel?.teacherEmail).update({
        "teacherName": nameController.text,
        "teacherEmail": emailController.text,
        "district": districtController.text,
        "gender": gender,
        "houseName": houseNameController.text,
        "houseNumber": houseNumberController.text,
        "place": placeController.text,
        "altPhoneNo": altPhoneNoController.text,
        "docID": emailController.text
      });
      Get.find<GetImage>().pickedImage.value = "";
      isLoading.value = false;
    } catch (e) {
      showToast(msg: e.toString());
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
    if (
      nameController.text.isEmpty || emailController.text.isEmpty||
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
