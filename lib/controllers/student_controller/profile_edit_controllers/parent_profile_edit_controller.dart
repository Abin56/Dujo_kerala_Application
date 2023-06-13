import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/view/home/parent_home/parent_main_home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../helper/shared_pref_helper.dart';
import '../../../model/Signup_Image_Selction/image_selection.dart';
import '../../../model/parent_model/parent_model.dart';
import '../../../utils/utils.dart';
import '../../../view/pages/login/dujo_login_screen.dart';
import '../../userCredentials/user_credentials.dart';

class ParentProfileEditController {
  RxBool isLoading = RxBool(false);
  Future<void> changeParentEmail(
      String newEmail, BuildContext context, String password) async {
    final auth = FirebaseAuth.instance;
    String email = auth.currentUser?.email ?? "";
    try {
      isLoading.value = true;
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        await FirebaseAuth.instance.currentUser
            ?.updateEmail(newEmail)
            .then((value) async {
          await FirebaseFirestore.instance
              .collection('SchoolListCollection')
              .doc(UserCredentialsController.schoolId)
              .collection(UserCredentialsController.batchId ?? "")
              .doc(UserCredentialsController.batchId)
              .collection('classes')
              .doc(UserCredentialsController.classId)
              .collection('ParentCollection')
              .doc(UserCredentialsController.parentModel?.docid)
              .update({'parentEmail': newEmail});

          showToast(msg: 'Successfully Updated');

          await FirebaseAuth.instance.signOut().then((value) async {
            await SharedPreferencesHelper.clearSharedPreferenceData();
            UserCredentialsController.clearUserCredentials();
            Get.offAll(() => const DujoLoginScren());
          });
        });
      });

      isLoading.value = false;
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      String errorMessage = '';

      switch (e.code) {
        case 'requires-recent-login':
          errorMessage =
              'This action requires recent authentication. Please log in again.';
          break;
        case 'email-already-in-use':
          errorMessage =
              'The email address is already in use by another account.';
          break;
        case 'invalid-email':
          errorMessage = 'The email address is invalid.';
          break;
        case 'too-many-requests':
          errorMessage = 'Too many requests. Please try again later.';
          break;
        case 'user-disabled':
          errorMessage = 'The user account has been disabled.';
          break;
        case 'user-not-found':
          errorMessage = 'The user account was not found.';
          break;
        case 'weak-password':
          errorMessage = 'The password is too weak.';
          break;
        default:
          errorMessage = 'An error occurred. Please try again.';
      }

      showToast(msg: errorMessage);
    }
  }

  Future<void> updateParentProfilePicture() async {
    try {
      if (Get.find<GetImage>().pickedImage.value.isNotEmpty) {
        isLoading.value = true;
        final result = await FirebaseStorage.instance
            .ref(
                "files/parentProfilePhotos/${UserCredentialsController.schoolId}/${UserCredentialsController.batchId}/${UserCredentialsController.guardianModel?.profileImageID}")
            .putFile(File(Get.find<GetImage>().pickedImage.value));
        final imageUrl = await result.ref.getDownloadURL();
        await FirebaseFirestore.instance
            .collection("SchoolListCollection")
            .doc(UserCredentialsController.schoolId)
            .collection(UserCredentialsController.batchId ?? "")
            .doc(UserCredentialsController.batchId)
            .collection("classes")
            .doc(UserCredentialsController.classId)
            .collection("ParentCollection")
            .doc(UserCredentialsController.parentModel?.docid)
            .update({"profileImageURL": imageUrl});

        isLoading.value = false;

        Get.find<GetImage>().pickedImage.value = "";
        final DocumentSnapshot<Map<String, dynamic>> parentData =
            await FirebaseFirestore.instance
                .collection("SchoolListCollection")
                .doc(UserCredentialsController.schoolId)
                .collection(UserCredentialsController.batchId ?? "")
                .doc(UserCredentialsController.batchId)
                .collection('classes')
                .doc(UserCredentialsController.classId)
                .collection('ParentCollection')
                .doc(UserCredentialsController.parentModel?.docid)
                .get();

        if (parentData.data() != null) {
          UserCredentialsController.parentModel =
              ParentModel.fromMap(parentData.data()!);
          Get.offAll(const ParentMainHomeScreen());
        }
      }
    } catch (e) {
      isLoading.value = false;
      showToast(msg: "Something Went Wrong");
    }
  }
}
