import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helper/shared_pref_helper.dart';
import '../../view/pages/login/dujo_login_screen.dart';
import '../userCredentials/user_credentials.dart';

class UserLogOutController extends GetxController {
  RxBool logout = false.obs;
  Future<void> logOut(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title:  Text('Logout'.tr),
          content: SingleChildScrollView(
            child: ListBody(
              children:  <Widget>[Text('Are you sure to Logout ?'.tr)],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child:  Text('Cancel'.tr),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child:  Text('Ok'.tr),
              onPressed: () async {

                await FirebaseAuth.instance.signOut().then((value) async {
                  await SharedPreferencesHelper.clearSharedPreferenceData();
                  UserCredentialsController.clearUserCredentials();
                  Get.offAll(() => const DujoLoginScren());
                });
              },
            ),
          ],
        );
      },
    );
  }
}
