import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

const String netWorkImagePathPerson =
    "https://www.seekpng.com/png/full/202-2024994_profile-icon-profile-logo-no-background.png";

String stringTimeToDateConvert(String date) {
  //String dateandtime convert to "dd-mm-yyyy" this format
  try {
    final DateTime dateFormat = DateTime.parse(date);
    return "${dateFormat.day}-${dateFormat.month}-${dateFormat.year}";
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }
  return '';
}

String? checkFieldEmpty(String? fieldContent) {
  //<-- add String? as a return type
  if (fieldContent == null || fieldContent.isEmpty) {
    return "Field is mandatory";
  }
  return null;
}

String? checkFieldEmailIsValid(String? fieldContent) {
  if (fieldContent == null) {
    return 'null';
  }
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = RegExp(pattern);
  final result = (regex.hasMatch(fieldContent)) ? true : false;
  if (result) {
    return null;
  } else {
    return "Email is not valid";
  }
}

String? checkFieldPhoneNumberIsValid(String? fieldContent) {
  if (fieldContent == null) {
    return 'null';
  }
  if (fieldContent.length >= 10) {
    return null;
  } else {
    return 'Please enter 10 digit number';
  }
}

String? checkFieldPasswordIsValid(String? fieldContent) {
  if (fieldContent == null) {
    return 'null';
  }
  if (fieldContent.length >= 6) {
    return null;
  } else {
    return 'Minimum 6 Charaters is required';
  }
}

class TeacherLoginIDSaver {
  static String id = '';
}

class UserEmailandPasswordSaver {
  static String userEmail = '';
  static String userPassword = '';
}

const uuid = Uuid();

class MessageCounter {
  static int studentMessageCounter = 0;
  static int teacherMessageCounter = 0;
  static int parentMessageCounter = 0;

  static String userPassword = '';
}

class ParentPasswordSaver {
  static String parentPassword = '';
  static String parentemailID = '';
}
