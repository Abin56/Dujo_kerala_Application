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
  RxBool isLoading = RxBool(false);
  List<StudentModel> classWiseStudentList = [];

  String? bloodGroup;
  String? gender;

  //for photo id creation
  Uuid uuid = const Uuid();
   CollectionReference<Map<String, dynamic>> finalFirebaseData = FirebaseFirestore
      .instance
      .collection("SchoolListCollection")
      .doc(UserCredentialsController.schoolId)
      .collection(UserCredentialsController.batchId ?? "")
      .doc(UserCredentialsController.batchId ?? "")
      .collection("classes")
      .doc(UserCredentialsController.classId)
      .collection("Students"); 

  CollectionReference<Map<String, dynamic>> firebaseData = FirebaseFirestore
      .instance
      .collection("SchoolListCollection")
      .doc(UserCredentialsController.schoolId)
      .collection(UserCredentialsController.batchId ?? "")
      .doc(UserCredentialsController.batchId ?? "")
      .collection("classes")
      .doc(UserCredentialsController.classId)
      .collection("TempStudentCollection"); 


//fetching all students data from firebase
  Future<void> getStudentData() async {
    try {
      log('hai hello');
        log('schoolid: ${UserCredentialsController.schoolId}');
      log('batchIID: ${UserCredentialsController.batchId}');
      log('classId: ${UserCredentialsController.classId}');

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

      //getting firebase uid and updated it to collection
      String userUid = FirebaseAuth.instance.currentUser?.uid ?? "";

      Map<String, dynamic> updatinStudenData = <String, dynamic>{
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
        "uid": userUid
      }; 

      await finalFirebaseData
          .doc(userUid).set(updatinStudenData);
         

      await firebaseData
          .doc(UserCredentialsController.studentModel?.docid).delete();

      //updating data to all students field

      await FirebaseFirestore.instance
          .collection("SchoolListCollection")
          .doc(UserCredentialsController.schoolId)
          .collection('AllStudents')
          .doc(userUid)
          .set(updatinStudenData);

      clearFields();
      Get.find<GetImage>().pickedImage.value = "";
      isLoading.value = false;
    } catch (e) {
      showToast(msg: e.toString()); 
      log('errors is ${e.toString()}');
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
