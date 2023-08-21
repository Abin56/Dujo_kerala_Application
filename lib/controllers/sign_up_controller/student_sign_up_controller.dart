import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../model/Signup_Image_Selction/image_selection.dart';
import '../../model/student_model/student_model.dart';
import '../userCredentials/user_credentials.dart';

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
  RxBool isLoading = RxBool(false);
  List<StudentModel> classWiseStudentList = [];

  String? bloodGroup;
  String? gender;

  //for photo id creation
  Uuid uuid = const Uuid();
  CollectionReference<Map<String, dynamic>> firebaseData = FirebaseFirestore
      .instance
      .collection("SchoolListCollection")
      .doc(UserCredentialsController.schoolId)
      .collection(UserCredentialsController.batchId ?? "")
      .doc(UserCredentialsController.batchId ?? "")
      .collection("classes")
      .doc(UserCredentialsController.classId)
      .collection("Students");
  CollectionReference<Map<String, dynamic>> firebaseDataTemp = FirebaseFirestore
      .instance
      .collection("SchoolListCollection")
      .doc(UserCredentialsController.schoolId)
      .collection(UserCredentialsController.batchId ?? "")
      .doc(UserCredentialsController.batchId ?? "")
      .collection("classes")
      .doc(UserCredentialsController.classId)
      .collection("TempStudents");

//fetching all students data from firebase
  Future<void> getStudentData() async {
    try {
      isLoading.value = true;
      final result = await firebaseDataTemp.get();
      log(result.docs.toString());

      if (result.docs.isNotEmpty) {
        classWiseStudentList =
            result.docs.map((e) => StudentModel.fromJson(e.data())).toList();
      }

      isLoading.value = false;
    } catch (e) {
      showToast(msg: "Student fetching failed");
      isLoading.value = false;
    }
  }

  //updating students data

  Future<void> updateStudentData() async {
    String imageId = "";
    String imageUrl = "";
    try {
      // if (Get.find<GetImage>().pickedImage.isNotEmpty) {
        isLoading.value = true;
        imageId = uuid.v1();
        // final result = await FirebaseStorage.instance
        //     .ref(
        //         "files/studentsProfilePhotos/${UserCredentialsController.schoolId}/${UserCredentialsController.batchId}/${UserCredentialsController.studentModel?.studentName}$imageId")
        //     .putFile(File(Get.find<GetImage>().pickedImage.value));
        // imageUrl = await result.ref.getDownloadURL();
        //getting firebase uid and updated it to collection
        String userUid = FirebaseAuth.instance.currentUser?.uid ?? "";

        final studentModel = StudentModel(
            admissionNumber:
                UserCredentialsController.studentModel?.admissionNumber ?? "",
            alPhoneNumber: altPhoneNoController.text,
            bloodgroup: bloodGroup ?? "",
            classId: UserCredentialsController.studentModel?.classId ?? "",
            createDate:
                UserCredentialsController.studentModel?.createDate ?? "",
            dateofBirth: dateOfBirthController.text,
            district: districtController.text,
            docid: userUid,
            gender: gender ?? "",
            guardianId:
                UserCredentialsController.studentModel?.guardianId ?? "",
            houseName: houseNameController.text.trim(),
            parentId: UserCredentialsController.studentModel?.parentId ?? "",
            parentPhoneNumber:
                UserCredentialsController.studentModel?.parentPhoneNumber ?? "",
            place: placeController.text.trim(),
            profileImageId: imageId,
            profileImageUrl: imageUrl,
            studentName:
                UserCredentialsController.studentModel?.studentName ?? "",
            studentemail: emailController.text.trim(),
            userRole: "student");

        await firebaseData
            .doc(userUid)
            .set(studentModel.toJson())
            .then((value) {
          firebaseDataTemp
              .doc(UserCredentialsController.studentModel?.docid ?? "")
              .delete()
              .then((value) {
            UserCredentialsController.studentModel = studentModel;
            //updating data to all students field

            FirebaseFirestore.instance
                .collection("SchoolListCollection")
                .doc(UserCredentialsController.schoolId)
                .collection('AllStudents')
                .doc(UserCredentialsController.studentModel?.docid)
                .set(studentModel.toJson());
          });
        });
classWiseStudentList.clear();
        await getStudentData();

        clearFields();
        Get.find<GetImage>().pickedImage.value = "";
        isLoading.value = false;
      // } else {
      //   showToast(msg: "Please Upload Profile Picture");
      // }
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
    bloodGroup = null;
  }

  bool checkAllFieldIsEmpty() {
    if (houseNameController.text.isEmpty ||
        houseNumberController.text.isEmpty ||
        placeController.text.isEmpty ||
        districtController.text.isEmpty ||
        altPhoneNoController.text.isEmpty ||
        dateOfBirthController.text.isEmpty ||
        bloodGroup == null) {
      return true;
    } else {
      return false;
    }
  }
}
