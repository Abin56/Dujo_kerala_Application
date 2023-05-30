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
        title: Text('Logout'.tr),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[Text('Are you sure to Logout ?'.tr)],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Cancel'.tr),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Ok'.tr),
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

Future<void> changeEmail(String newEmail, BuildContext context) async {
  try {
    await FirebaseAuth.instance.currentUser?.verifyBeforeUpdateEmail(newEmail);
    await FirebaseAuth.instance.signOut().then((value) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return const DujoLoginScren();
      }));
    });
  } on FirebaseAuthException catch (e) {
    String errorMessage = '';

    switch (e.code) {
      case 'requires-recent-login':
        errorMessage =
            'This action requires recent authentication. Please log in again.';
        break;
      case 'email-already-in-use':
        errorMessage =
            'The email address is already in use by another account.';
        break;
      case 'invalid-email':
        errorMessage = 'The email address is invalid.';
        break;
      case 'too-many-requests':
        errorMessage = 'Too many requests. Please try again later.';
        break;
      case 'user-disabled':
        errorMessage = 'The user account has been disabled.';
        break;
      case 'user-not-found':
        errorMessage = 'The user account was not found.';
        break;
      case 'weak-password':
        errorMessage = 'The password is too weak.';
        break;
      default:
        errorMessage = 'An error occurred. Please try again.';
    }

    showToast(msg: errorMessage);
  }
}
