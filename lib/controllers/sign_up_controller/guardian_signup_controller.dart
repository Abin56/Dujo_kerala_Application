import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/model/student_model/student_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../model/Signup_Image_Selction/image_selection.dart';
import '../../utils/utils.dart';
import '../userCredentials/user_credentials.dart';

class GuardianController extends GetxController {
  TextEditingController userNameController = TextEditingController();
  TextEditingController houseNameController = TextEditingController();
  TextEditingController houseNumberController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController altPhoneNoController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  TextEditingController stateController = TextEditingController(); 

  

  CollectionReference<Map<String, dynamic>> firebaseData = FirebaseFirestore
      .instance
      .collection("SchoolListCollection")
      .doc(UserCredentialsController.schoolId)
      .collection('Student_Guardian');

  RxBool isLoading = RxBool(false);
//for image uploading unique uid
  Uuid uuid = const Uuid();

  String? gender; 
  List<StudentModel> classWiseStudentList = []; 

  CollectionReference<Map<String, dynamic>> finalFirebaseData = FirebaseFirestore
      .instance
      .collection("SchoolListCollection")
      .doc(UserCredentialsController.schoolId)
      .collection(UserCredentialsController.batchId ?? "")
      .doc(UserCredentialsController.batchId ?? "")
      .collection("classes")
      .doc(UserCredentialsController.classId)
      .collection("Students"); 

        @override
  void onInit() async {
    await getStudentData();
    super.onInit();
  }



  //updating parent signup data 

   Future<void> getStudentData() async {
    try {
      log('hai hello');
        log('schoolid: ${UserCredentialsController.schoolId}');
      log('batchIID: ${UserCredentialsController.batchId}');
      log('classId: ${UserCredentialsController.classId}');

      isLoading.value = true; 
      
   
      final result = await finalFirebaseData.get(); 
      
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

  Future<void> updateGuardianData() async { 
    String imageId = "";
    String imageUrl = "";
    try {
      isLoading.value = true; 
      
      if (Get.find<GetImage>().pickedImage.isNotEmpty) {
        imageId = uuid.v1();
        final result = await FirebaseStorage.instance
            .ref("files/guardianProfilePhotos/$imageId")
            .putFile(File(Get.find<GetImage>().pickedImage.value));
        imageUrl = await result.ref.getDownloadURL();
      } 



  //      Future<void> getStudentData() async {
  //   try {
  //     log('hai hello');
  //       log('schoolid: ${UserCredentialsController.schoolId}');
  //     log('batchIID: ${UserCredentialsController.batchId}');
  //     log('classId: ${UserCredentialsController.classId}');

  //     isLoading.value = true; 
      
   
  //     final result = await FirebaseFirestore.instance.collection('SchoolListCollection').doc(UserCredentialsController.schoolId).collection(UserCredentialsController.batchId!)
  //     .doc(UserCredentialsController.batchId).collection('collectionPath')
      
  //     if (result.docs.isNotEmpty) {
  //       classWiseStudentList =
  //           result.docs.map((e) => StudentModel.fromJson(e.data())).toList();
  //     }
  //     isLoading.value = false;
  //   } catch (e) {
  //     showToast(msg: "Student fetching failed");
  //     isLoading.value = false;
  //   }
  // }

      //getting firebase uid and updated it to collection
      String userUid = FirebaseAuth.instance.currentUser?.uid ?? "";
      String userEmail = FirebaseAuth.instance.currentUser?.email ?? ""; 

      Map<String, dynamic> updateParentData = <String, dynamic>{
        "gender": gender ?? "",
        "docid" : userUid,
        "guardianName"
        "houseName": houseNameController.text,
        "guardianEmail": userEmail,
        "pincode": pinCodeController.text,
        "place": placeController.text,
        "profileImageID": imageId,
        "profileImageURL": imageUrl,
        "state": stateController.text,
        "uid": userUid, 
      };

      firebaseData
          .doc(
            userUid
          )
          .update(updateParentData)
          .then((value) => clearControllers());  

      //FirebaseFirestore.instance.collection('SchoolListCollection').doc(UserCredentialsController.schoolId).collection('TempGuardiansCollection').doc().delete();
      Get.find<GetImage>().pickedImage.value = "";
      isLoading.value = false;
    } catch (e) {
      showToast(msg: "Updation Failed");
      isLoading.value = false;
    }
  }

  Future<void> addGuardianData() async { 
    String imageId = "";
    String imageUrl = "";
    try {
      isLoading.value = true; 
      
      if (Get.find<GetImage>().pickedImage.isNotEmpty) {
        imageId = uuid.v1();
        final result = await FirebaseStorage.instance
            .ref("files/guardianProfilePhotos/$imageId")
            .putFile(File(Get.find<GetImage>().pickedImage.value));
        imageUrl = await result.ref.getDownloadURL();
      } 



  //      Future<void> getStudentData() async {
  //   try {
  //     log('hai hello');
  //       log('schoolid: ${UserCredentialsController.schoolId}');
  //     log('batchIID: ${UserCredentialsController.batchId}');
  //     log('classId: ${UserCredentialsController.classId}');

  //     isLoading.value = true; 
      
   
  //     final result = await FirebaseFirestore.instance.collection('SchoolListCollection').doc(UserCredentialsController.schoolId).collection(UserCredentialsController.batchId!)
  //     .doc(UserCredentialsController.batchId).collection('collectionPath')
      
  //     if (result.docs.isNotEmpty) {
  //       classWiseStudentList =
  //           result.docs.map((e) => StudentModel.fromJson(e.data())).toList();
  //     }
  //     isLoading.value = false;
  //   } catch (e) {
  //     showToast(msg: "Student fetching failed");
  //     isLoading.value = false;
  //   }
  // }

      //getting firebase uid and updated it to collection
      String userUid = FirebaseAuth.instance.currentUser?.uid ?? "";
      String userEmail = FirebaseAuth.instance.currentUser?.email ?? "";

      Map<String, dynamic> addGuardianData = <String, dynamic>{
        "createdate":DateTime.now(), 
        "guardianName":userNameController.text,
        "gender": gender ?? "",
        "houseName": houseNameController.text,
        "guardianEmail": userEmail,
        "pincode": pinCodeController.text,
        "place": placeController.text,
        "profileImageID": imageId,
        "profileImageURL": imageUrl,
        "state": stateController.text,
        "uid": userUid,
        "guardianPhoneNumber": UserCredentialsController.studentModel!.parentPhoneNumber,
        "docid" : userUid
      };

      firebaseData
          .doc(
            userUid
          )
          .set(addGuardianData)
          .then((value) => clearControllers());  

      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      final CollectionReference collectionRef = firestore.collection('SchoolListCollection').doc(UserCredentialsController.schoolId).collection('TempGuardiansCollection');
     
      QuerySnapshot querySnapshot = await collectionRef.where('guardianPhoneNumber', isEqualTo: UserCredentialsController.studentModel!.parentPhoneNumber).get();
     
      querySnapshot.docs.forEach((document) {
    document.reference.delete();
  });
      Get.find<GetImage>().pickedImage.value = "";
      isLoading.value = false;
    } catch (e) {
      showToast(msg: "Updation Failed");
      isLoading.value = false;
    }
  }
  

  bool checkAllFieldIsEmpty() {
    if (userNameController.text.isEmpty ||
        houseNameController.text.isEmpty ||
        houseNumberController.text.isEmpty ||
        placeController.text.isEmpty ||
        districtController.text.isEmpty ||
        altPhoneNoController.text.isEmpty ||
        pinCodeController.text.isEmpty ||
        stateController.text.isEmpty ||
        gender == null) {
      return true;
    } else {
      return false;
    }
  }

  void clearControllers() {
    userNameController.clear();
    houseNameController.clear();
    houseNumberController.clear();
    placeController.clear();
    districtController.clear();
    altPhoneNoController.clear();
    pinCodeController.clear();
    stateController.clear();
  }
}
