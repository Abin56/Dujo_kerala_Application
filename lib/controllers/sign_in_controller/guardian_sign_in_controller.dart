import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/view/home/sample/under_maintance.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../model/guardian_model/guardian_model.dart';
import '../../utils/utils.dart';
import '../userCredentials/user_credentials.dart';

class GuardianSignin extends GetxController {
  RxBool isLoading = RxBool(false);
  TextEditingController emailIdController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> signIn(BuildContext context) async {
    try {
      isLoading.value = true;
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: emailIdController.text,
        password: passwordController.text,
      )
          .then((value) async {
        //fetching parent data from firebase
        QuerySnapshot<Map<String, dynamic>> user = await FirebaseFirestore
            .instance
            .collection('SchoolListCollection')
            .doc(UserCredentialsController.schoolId)
            .collection('Student_Guardian')
            .where("uid", isEqualTo: value.user?.uid)
            .get();

        if (user.docs.isNotEmpty) {
          UserCredentialsController.guardianModel = GuardianModel.fromJson(
            user.docs[0].data(),
          );
        }
        if (UserCredentialsController.parentModel?.userRole == "guardian") {
          if (context.mounted) {
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (context) {
              return const UnderMaintanceScreen(
                text: "Guardian Login",
              );
            }), (route) => false);
          }
          isLoading.value = false;
        } else {
          showToast(
            msg: "Access denied since you are not a guardian",
          );
          isLoading.value = false;
        }
      });
    } catch (e) {
      isLoading.value = false;
      showToast(msg: "Sign in failed");
    }
  }
}
