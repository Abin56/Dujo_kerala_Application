import 'dart:developer';

import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:dujo_kerala_application/model/teacher_model/teacher_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../view/home/class_teacher_HOme/class_teacher_home.dart';

class ClassTeacherLoginController extends GetxController {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  RxBool isLoading = RxBool(false);
  TextEditingController emailIdController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String name = "ClassTeacherLoginController";
  //sign in with email and password firebase authentification
  void signIn(BuildContext context) async {
    if (emailIdController.text.isEmpty || passwordController.text.isEmpty) {
      showToast(msg: "Fields are empty");
      return;
    }
    try {
      isLoading.value = true;
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: emailIdController.text,
        password: passwordController.text,
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

          if (teacherModel.userRole == "classTeacher") {
            UserCredentialsController.teacherModel = teacherModel;
            if (context.mounted) {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => ClassTeacherHomeScreen()));
            }
          } else {
            showToast(msg: "You are not a class Teacher");
          }
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
