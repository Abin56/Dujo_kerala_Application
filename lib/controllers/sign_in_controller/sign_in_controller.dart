import 'dart:developer';

import 'package:dujo_kerala_application/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
        } else if (index == 2) {
        } else if (index == 3) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) {
                return const Scaffold(
                  body: Center(
                    child: Text('Parent Home Screen'),
                  ),
                );
              },
            ),
          );
        }
      });
    } catch (e) {
      showToast(msg: "Login Failed");
    }
  }
}
