import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/model/parent_model/parent_model.dart';
import 'package:dujo_kerala_application/view/home/sample/under_maintance.dart';
import 'package:dujo_kerala_application/view/pages/login/users_login_screen/parent_login/parent_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/utils.dart';
import '../userCredentials/user_credentials.dart';

class ParentLoginController extends GetxController {
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
            .collection('Students_Parents')
            .where("uid", isEqualTo: value.user?.uid)
            .get();

        if (user.docs.isNotEmpty) {
          UserCredentialsController.parentModel = ParentModel.fromJson(
            user.docs[0].data(),
          );
        }
        if (UserCredentialsController.parentModel?.userRole == "parent") {
          if (context.mounted) {
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (context) {
              return const UnderMaintanceScreen(
                text: "Parent Page",
              );
            }), (route) => false);
          }
          isLoading.value = false;
        } else {
          showToast(
            msg: "Access denied since you are not a parent",
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
