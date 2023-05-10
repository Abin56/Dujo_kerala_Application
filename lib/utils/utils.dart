import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/userCredentials/user_credentials.dart';
import '../helper/shared_pref_helper.dart';
import '../view/pages/login/dujo_login_screen.dart';

void showToast({required String msg}) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

const circularProgressIndicatotWidget = Center(
  child: CircularProgressIndicator(),
);

Future<String> dateTimePicker(BuildContext context) async {
  DateTime? dateTime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2500));
  if (dateTime != null) {
    return DateFormat("dd-M-yyyy").format(dateTime);
  } else {
    return '';
  }
}

Future<void> userLogOut(BuildContext context) async {
  return showDialog(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Logout'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[Text('Are you sure to Logout ?')],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('ok'),
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

void handleFirebaseError(FirebaseAuthException error) {
  switch (error.code) {
    case 'invalid-email':
      showToast(msg: 'invalid-email');
      break;
    case 'user-disabled':
      showToast(msg: 'user-disabled');
      break;
    case 'user-not-found':
      showToast(msg: 'user-not-found');
      break;
    case 'wrong-password':
      showToast(msg: 'wrong-password');
      break;
    default:
      showToast(msg: 'Something went wrong');
      break;
  }
}
