import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/view/home/student_home/students_main_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helper/shared_pref_helper.dart';
import '../../model/student_model/student_model.dart';
import '../../utils/utils.dart';
import '../userCredentials/user_credentials.dart';

class StudentSignInController extends GetxController {
  RxBool isLoading = RxBool(false);
  TextEditingController emailIdController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void>  signIn(BuildContext context) async {
    try {
      isLoading.value = true;
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: emailIdController.text.trim(),
        password: passwordController.text.trim(),
      )
          .then((value) async {
        final user = await FirebaseFirestore.instance
            .collection('SchoolListCollection')
            .doc(UserCredentialsController.schoolId)
            .collection(UserCredentialsController.batchId ?? "")
            .doc(UserCredentialsController.batchId)
            .collection('classes')
            .doc(UserCredentialsController.classId)
            .collection('Students')
            .doc(value.user?.uid)
            .get();

        if (user.data() != null) {
          UserCredentialsController.studentModel =
              StudentModel.fromJson(user.data()!);
        }

        if (UserCredentialsController.studentModel?.userRole == "student") {
          await SharedPreferencesHelper.setString(
              SharedPreferencesHelper.userRoleKey, 'student');
          if (context.mounted) {
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (context) {
              return const StudentsMainHomeScreen();
            }), (route) => false);
          }
          isLoading.value = false;
        } else {
          showToast(msg: "You are not a student");
          isLoading.value = false;
        }
      }).catchError((error) {
        if (error is FirebaseAuthException) {
          isLoading.value = false;
          handleFirebaseError(error);
        }
      });
    } catch (e) {
      isLoading.value = false;
      // showToast(msg: e.toString());
      showToast(msg: "Sign in failed");
    }
  }
}
