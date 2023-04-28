import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/view/home/sample/under_maintance.dart';
import 'package:dujo_kerala_application/view/home/student_home/student_home.dart';
import 'package:dujo_kerala_application/view/pages/login/users_login_screen/student%20login/student_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/student_model/student_model.dart';
import '../../utils/utils.dart';
import '../userCredentials/user_credentials.dart';

class StudentSignInController extends GetxController {
  RxBool isLoading = RxBool(false);
  TextEditingController emailIdController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  Future<void> signIn(BuildContext context) async {
    try {
      if (formKey.currentState!.validate()) {
        isLoading.value = true;
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(
          email: emailIdController.text,
          password: passwordController.text,
        )
            .then((value) async {
          final user = await FirebaseFirestore.instance
              .collection('SchoolListCollection')
              .doc(UserCredentialsController.schoolId)
              .collection(UserCredentialsController.batchId ?? "")
              .doc(UserCredentialsController.batchId)
              .collection('Classes')
              .doc(UserCredentialsController.classId)
              .collection('Students')
              .where("uid", isEqualTo: value.user?.uid)
              .get();

          if (user.docs.isNotEmpty) {
            UserCredentialsController.studentModel =
                StudentModel.fromJson(user.docs[0].data());
          }

          if (UserCredentialsController.studentModel?.userRole == "student") {
            if (context.mounted) {
              Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (context) {
                return StudentHomeScreen();
              }), (route) => false);
            }
            isLoading.value = false;
          } else {
            showToast(msg: "You are not a student");
            isLoading.value = false;
          }
        });
      }
    } catch (e) {
      isLoading.value = false;
      showToast(msg: "Sign in failed");
    }
  }
}
