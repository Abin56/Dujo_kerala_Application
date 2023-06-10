import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:dujo_kerala_application/helper/shared_pref_helper.dart';
import 'package:dujo_kerala_application/model/teacher_model/teacher_model.dart';
import 'package:dujo_kerala_application/view/home/teachers_home/teacher_main_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/utils.dart';

class TeacherLoginController extends GetxController {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  RxBool isLoading = RxBool(false);
  TextEditingController emailIdController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String name = "TeacherLoginController";
  //sign in with email and password firebase authentification
  void signIn(BuildContext context) async {
    if (emailIdController.text.isEmpty || passwordController.text.isEmpty) {
      showToast(msg: "Fields are empty");
      return;
    }
    try {
      isLoading.value = true;
      await firebaseAuth
          .signInWithEmailAndPassword(
        email: emailIdController.text.trim(),
        password: passwordController.text.trim(),
      )
          .then((value) async {
        final DocumentSnapshot<Map<String, dynamic>> result =
            await firebaseFirestore
                .collection('SchoolListCollection')
                .doc(UserCredentialsController.schoolId)
                .collection('Teachers')
                .doc(value.user?.uid)
                .get();

        if (result.data() != null) {
          final TeacherModel teacherModel =
              TeacherModel.fromMap(result.data()!);

          if (teacherModel.userRole == "teacher" ||
              teacherModel.userRole == "classTeacher") {
            UserCredentialsController.teacherModel = teacherModel;
            //assigining shared preference user role for app close

            await SharedPreferencesHelper.setString(
                SharedPreferencesHelper.userRoleKey, 'teacher');

            if (context.mounted) {
              Get.offAll(const TeacherMainHomeScreen());
            }
          } else {
            await firebaseAuth.signOut();
            showToast(msg: "You are not a Teacher");
          }
        }
      }).catchError((error) {
        if (error is FirebaseAuthException) {
          isLoading.value = false;
          handleFirebaseError(error);
        }
      });

      isLoading.value = false;
    } catch (e) {
      showToast(msg: 'Login Failed');
      log(name: name, e.toString());
      isLoading.value = false;
    }
  }
}
