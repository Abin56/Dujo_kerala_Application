import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../model/Signup_Image_Selction/image_selection.dart';
import '../../utils/utils.dart';
import '../userCredentials/user_credentials.dart';

class ParentSignUpController extends GetxController {
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
      .collection('Students_Parents');

  RxBool isLoading = RxBool(false);
//for image uploading unique uid
  Uuid uuid = const Uuid();

  String? gender;

  //updating parent signup data

  Future<void> updateParentData() async {
    String imageId = "";
    String imageUrl = "";
    try {
      isLoading.value = true;
      if (Get.find<GetImage>().pickedImage.isNotEmpty) {
        imageId = uuid.v1();
        final result = await FirebaseStorage.instance
            .ref("files/parentProfilePhotos/$imageId")
            .putFile(File(Get.find<GetImage>().pickedImage.value));
        imageUrl = await result.ref.getDownloadURL();
      }

      //getting firebase uid and updated it to collection
      String userUid = FirebaseAuth.instance.currentUser?.uid ?? "";
      String userEmail = FirebaseAuth.instance.currentUser?.email ?? "";

      Map<String, dynamic> updateParentData = <String, dynamic>{
        "gender": gender ?? "",
        "houseName": houseNameController.text,
        "parentEmail": userEmail,
        "pincode": pinCodeController.text,
        "place": placeController.text,
        "profileImageID": imageId,
        "profileImageURL": imageUrl,
        "state": stateController.text,
        "uid": userUid,
      };

      firebaseData
          .doc(
            UserCredentialsController.studentModel?.parentId,
          )
          .update(updateParentData)
          .then((value) => clearControllers());
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
