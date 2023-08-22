import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
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
    backgroundColor: Colors.black,
    textColor: Colors.white,
    fontSize: 16.0.sp,
  );
}

const circularProgressIndicatotWidget = Center(
  child: CircularProgressIndicator(),
);

Future<String> dateTimePicker(BuildContext context) async {
  DateTime? dateTime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1700),
      lastDate: DateTime(2500));
  if (dateTime != null) {
    return DateFormat("dd-M-yyyy").format(dateTime);
  } else {
    return '';
  }
}

Future<int> dateTimePickerTimeStamp(BuildContext context) async {
  DateTime? dateTime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1700),
      lastDate: DateTime(2500));
  if (dateTime != null) {
    return dateTime.millisecondsSinceEpoch;
  } else {
    return -1;
  }
}

String timeStampToDateFormat(int timeStamp) {
  if (timeStamp == -1) {
    return "";
  }
  try {
    DateTime dt = DateTime.fromMillisecondsSinceEpoch(timeStamp);
    String d12 = DateFormat('dd-MM-yyyy').format(dt);

    return d12;
  } catch (e) {
    log("Format error");
    return "";
  }
}

Future<String> timePicker(BuildContext context) async {
  final TimeOfDay? time =
      await showTimePicker(context: context, initialTime: TimeOfDay.now());
  if (time != null) {
    // Get the current time of day using Dart's DateTime class

// Convert the TimeOfDay object to a custom 12-hour format with AM/PM
    String formattedTime =
        '${_getFormattedHour(time)}:${time.minute.toString().padLeft(2, '0')} ${_getAmPm(time)}';

    return formattedTime;
  } else {
    return "";
  }
}

// Helper function to get AM or PM based on the TimeOfDay
String _getAmPm(TimeOfDay timeOfDay) {
  return timeOfDay.period == DayPeriod.am ? 'AM' : 'PM';
}

// Helper function to format the hour in 12-hour format
String _getFormattedHour(TimeOfDay timeOfDay) {
  String hour =
      (timeOfDay.hourOfPeriod == 0 ? 12 : timeOfDay.hourOfPeriod).toString();
  return hour;
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

void landScapeBlockFunction() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

String translateString(String key) {
  return key.tr;
}

Future<void> sendPushMessage(String token, String body, String title) async {
  try {
    final reponse = await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization':
            'key=AAAAd0ScEck:APA91bELuwPRaLXrNxKTwj-z6EK-mCSPOon5WuZZAwkdklLhWvbi_NxXGtwHICE92vUzGJyE9xdOMU_-4ZPbWy8s2MuS_s-4nfcN_rZ1uBTOCMCcJ5aNS7rQHeUTXgYux54-n4eoYclp'
      },
      body: jsonEncode(
        <String, dynamic>{
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'status': 'done',
            'body': body,
            'title': title,
          },
          "notification": <String, dynamic>{
            'title': title,
            'body': body,
            'android_channel_id': 'high_importance_channel'
          },
          'to': token,
        },
      ),
    );
    log(reponse.body.toString());
  } catch (e) {
    if (kDebugMode) {
      log("error push Notification");
    }
  }
}
