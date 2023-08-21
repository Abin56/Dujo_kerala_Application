import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../model/Signup_Image_Selction/image_selection.dart';
import '../../model/guardian_model/guardian_model.dart';
import '../../utils/utils.dart';
import '../../view/pages/login/users_login_screen/guardian_login/guardian_login.dart';
import '../userCredentials/user_credentials.dart';

class GuardianSignUpController extends GetxController {
  TextEditingController userNameController = TextEditingController();
  TextEditingController houseNameController = TextEditingController();
  TextEditingController houseNumberController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController altPhoneNoController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  List<GuardianModel> guardianModelList = [];
  //

  FirebaseAuth auth = FirebaseAuth.instance;

  CollectionReference<Map<String, dynamic>> firebaseDataTemp = FirebaseFirestore
      .instance
      .collection("SchoolListCollection")
      .doc(UserCredentialsController.schoolId)
      .collection(UserCredentialsController.batchId ?? "")
      .doc(UserCredentialsController.batchId)
      .collection('classes')
      .doc(UserCredentialsController.classId)
      .collection('Temp_GuardianCollection');

  CollectionReference<Map<String, dynamic>> firebaseData = FirebaseFirestore
      .instance
      .collection("SchoolListCollection")
      .doc(UserCredentialsController.schoolId)
      .collection(UserCredentialsController.batchId ?? "")
      .doc(UserCredentialsController.batchId)
      .collection('classes')
      .doc(UserCredentialsController.classId)
      .collection('GuardianCollection');

  RxBool isLoading = RxBool(false);
//for image uploading unique uid
  Uuid uuid = const Uuid();

  String? gender;

  Future<void> getAllGuardian() async {
    try {
      isLoading.value = true;
      guardianModelList.clear();
      final QuerySnapshot<Map<String, dynamic>> parentData =
          await firebaseDataTemp.get();

      guardianModelList =
          parentData.docs.map((e) => GuardianModel.fromMap(e.data())).toList();
      isLoading.value = false;
    } catch (e) {
      showToast(msg: 'Something Error');
      isLoading.value = false;
    }
  }

  //updating parent signup data

  Future<void> updateGuardianData() async {
    String imageId = "";
    String imageUrl = "";
    try {
      isLoading.value = true;
      if (Get.find<GetImage>().pickedImage.value.isNotEmpty) {
        auth
            .signInWithEmailAndPassword(
                email: emailController.text.trim(),
                password: passwordController.text.trim())
            .then((value) async {
          imageId = uuid.v1();
          final result = await FirebaseStorage.instance
              .ref(
                  "files/guardianProfilePhotos/${UserCredentialsController.schoolId}/${UserCredentialsController.batchId}/${UserCredentialsController.guardianModel?.guardianName ?? ""}/$imageId")
              .putFile(File(Get.find<GetImage>().pickedImage.value));
          imageUrl = await result.ref.getDownloadURL();
          final GuardianModel guardianModel = GuardianModel(
              createdate:
                  UserCredentialsController.guardianModel?.createdate ?? "",
              district: districtController.text,
              docid: value.user?.uid,
              gender: gender,
              houseName: houseNameController.text,
              guardianEmail: emailController.text,
              guardianName:
                  UserCredentialsController.guardianModel?.guardianName ?? "",
              guardianPhoneNumber: UserCredentialsController
                      .guardianModel?.guardianPhoneNumber ??
                  "",
              pincode: pinCodeController.text,
              place: placeController.text,
              profileImageID: imageId,
              profileImageURL: imageUrl,
              state: stateController.text,
              studentID:
                  UserCredentialsController.guardianModel?.studentID ?? "",
              userRole:
                  "guardian");

          //add data to firebase
          await firebaseData
              .doc(value.user?.uid)
              .set(guardianModel.toMap())
              .then((value) async {
            await firebaseDataTemp
                .doc(UserCredentialsController.guardianModel?.docid)
                .delete()
                .then((value) {
              UserCredentialsController.guardianModel = guardianModel;
            });
          }).then((value) {
            Get.find<GetImage>().pickedImage.value = "";
            isLoading.value = false;
            showToast(msg: "Successfully Created");
            Get.offAll(
              GuardianLoginScreen(),
            );
          });
        });
      } else {
        isLoading.value = false;
        showToast(msg: 'Please Upload Image');
      }

      //getting firebase uid and updated it to collection
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
  //

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
