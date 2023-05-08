import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/model/parent_model/parent_model.dart';
import 'package:dujo_kerala_application/view/home/sample/under_maintance.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helper/shared_pref_helper.dart';
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
        final DocumentSnapshot<Map<String, dynamic>> parentData =
            await FirebaseFirestore.instance
                .collection('SchoolListCollection')
                .doc(UserCredentialsController.schoolId)
                .collection('classes')
                .doc(UserCredentialsController.classId)
                .collection('ParentCollection')
                .doc(value.user?.uid)
                .get();

        if (parentData.data() != null) {
          UserCredentialsController.parentModel = ParentModel.fromMap(
            parentData.data()!,
          );
        }
        if (UserCredentialsController.parentModel?.userRole == "parent") {
          //assigining shared preference user role for app close

          await SharedPreferencesHelper.setString(
              SharedPreferencesHelper.userRoleKey, 'parent');
          if (context.mounted) {
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (context) {
              return const UnderMaintanceScreen(
                text: 'Parent',
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
