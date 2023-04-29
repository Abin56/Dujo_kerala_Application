import 'dart:developer';

import 'package:dujo_kerala_application/utils/utils.dart';
import 'package:dujo_kerala_application/view/home/parent_home/parent_main_home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../view/home/class_teacher_HOme/class_teacher_Mainhome.dart';

class SignInController extends GetxController {
  Future<void> signInWithEmailAndPassword(
      String email, String password, int index, BuildContext context) async {
    log(index.toString());
    try {
      FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        if (index == 0) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) {
                return const Scaffold(
                  body: Center(
                    child: Text('Student Home Screen'),
                  ),
                );
              },
            ),
          );
        } else if (index == 1) {
              Navigator.of(context).pushAndRemoveUntil(
             MaterialPageRoute(
              builder: (context) {
                return ParentMainHomeScreen();
              },
            ),
             (route) => false);

        } else if (index == 2) {
        } else if (index == 3) {
          Navigator.of(context).pushAndRemoveUntil(
             MaterialPageRoute(
              builder: (context) {
                return ClassTeacherMainHomeScreen();
              },
            ),
             (route) => false);
        }
      });
    } catch (e) {
      showToast(msg: "Login Failed");
    }
  }
}
