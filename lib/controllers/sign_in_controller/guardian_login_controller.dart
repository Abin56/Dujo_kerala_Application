import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/ui%20team/abin/homepages/guardian%20home/gurdian_homepage.dart';
import 'package:dujo_kerala_application/view/home/sample/under_maintance.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../helper/shared_pref_helper.dart';
import '../../model/guardian_model/guardian_model.dart';
import '../../utils/utils.dart';
import '../userCredentials/user_credentials.dart';

class GuardianLoginController extends GetxController {
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
        final DocumentSnapshot<Map<String, dynamic>> guardianData =
            await FirebaseFirestore.instance
                .collection('SchoolListCollection')
                .doc(UserCredentialsController.schoolId)
                .collection('classes')
                .doc(UserCredentialsController.classId)
                .collection('GuardianCollection')
                .doc(value.user?.uid)
                .get();

        if (guardianData.data() != null) {
          UserCredentialsController.guardianModel = GuardianModel.fromMap(
            guardianData.data()!,
          );
        }
        if (UserCredentialsController.guardianModel?.userRole == "guardian") {
          //assigining shared preference user role for app close

          await SharedPreferencesHelper.setString(
              SharedPreferencesHelper.userRoleKey, 'guardian');
          if (context.mounted) {
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (context) {
              return UnderMaintanceScreen(text: 'Guardian',);
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
