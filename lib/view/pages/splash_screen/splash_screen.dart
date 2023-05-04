import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:dujo_kerala_application/model/student_model/student_model.dart';
import 'package:dujo_kerala_application/model/teacher_model/teacher_model.dart';
import 'package:dujo_kerala_application/ui%20team/abin/homepages/guardian%20home/gurdian_homepage.dart';
import 'package:dujo_kerala_application/utils/utils.dart';
import 'package:dujo_kerala_application/view/home/class_teacher_HOme/class_teacher_mainhome.dart';
import 'package:dujo_kerala_application/view/home/parent_home/parent_home_screen.dart';
import 'package:dujo_kerala_application/view/home/student_home/student_home.dart';
import 'package:dujo_kerala_application/view/home/teachers_home/teacher_home.dart';
import 'package:dujo_kerala_application/view/pages/login/dujo_login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../helper/shared_pref_helper.dart';
import '../../fonts/fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    nextpage();
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              height: 200.h,
              width: 200.w,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/leptonlogo.png'))),
            ),
          ),
          Text(
            "Lepton DuJo",
            style: DGoogleFonts.headTextStyleMont,
          )
        ],
      )),
    );
  }
}

nextpage() async {
  //creating firebase auth instance
  FirebaseAuth auth = FirebaseAuth.instance;

  //assigning shared preference value to to UserCredentialController
  UserCredentialsController.schoolId =
      SharedPreferencesHelper.getString(SharedPreferencesHelper.schoolIdKey);
  UserCredentialsController.batchId =
      SharedPreferencesHelper.getString(SharedPreferencesHelper.batchIdKey);
  UserCredentialsController.classId =
      SharedPreferencesHelper.getString(SharedPreferencesHelper.classIdKey);
  UserCredentialsController.userRole =
      SharedPreferencesHelper.getString(SharedPreferencesHelper.userRoleKey);

  final DocumentReference<Map<String, dynamic>> firebaseFirestore =
      FirebaseFirestore.instance
          .collection('SchoolListCollection')
          .doc(UserCredentialsController.schoolId);

  await Future.delayed(const Duration(seconds: 3));
  log("schoolId:${UserCredentialsController.schoolId}");
  log("batchId:${UserCredentialsController.batchId}");
  log("classId:${UserCredentialsController.classId}");
  log("userRole:${UserCredentialsController.userRole}");

  if (auth.currentUser == null) {
    Get.to(const DujoLoginScren());
  } else {
    if (UserCredentialsController.userRole == 'student') {
      //getting studentData
      await checkStudent(firebaseFirestore, auth);
    } else if (UserCredentialsController.userRole == 'teacher') {
      //checking user is classTeacher
      await checkTeacher(firebaseFirestore, auth);
    } else if (UserCredentialsController.userRole == 'classTeacher') {
      //checking user is parent
      await checkClassTeacher(firebaseFirestore, auth);
    } else if (UserCredentialsController.userRole == 'parent') {
      Get.to(ParentHomeScreen());

      //checking user is guardian
    } else if (UserCredentialsController.userRole == 'guardian') {
      Get.to(GuardianHomePage());
    } else {
      Get.to(const DujoLoginScren());
    }
  }
}

Future<void> checkStudent(
    DocumentReference<Map<String, dynamic>> firebaseFirestore,
    FirebaseAuth auth) async {
  final studentData = await firebaseFirestore
      .collection(UserCredentialsController.batchId ?? "")
      .doc(UserCredentialsController.batchId)
      .collection('classes')
      .doc(UserCredentialsController.classId)
      .collection('students')
      .doc(auth.currentUser?.uid)
      .get();

  if (studentData.data() != null) {
    UserCredentialsController.studentModel =
        StudentModel.fromJson(studentData.data()!);
    Get.to(StudentHomeScreen());
  } else {
    showToast(msg: "Please login again");
    Get.to(const DujoLoginScren());
  }
}

Future<void> checkTeacher(
    DocumentReference<Map<String, dynamic>> firebaseFirestore,
    FirebaseAuth auth) async {
  final teacherData = await firebaseFirestore
      .collection('Teachers')
      .doc(auth.currentUser?.uid)
      .get();

  if (teacherData.data() != null) {
    UserCredentialsController.teacherModel =
        TeacherModel.fromMap(teacherData.data()!);
    Get.to(TeacherHomeScreen());
  } else {
    showToast(msg: "Please login again");
    Get.to(const DujoLoginScren());
  }
}

Future<void> checkClassTeacher(
    DocumentReference<Map<String, dynamic>> firebaseFirestore,
    FirebaseAuth auth) async {
  final classTeacherData = await firebaseFirestore
      .collection('Teachers')
      .doc(auth.currentUser?.uid)
      .get();

  if (classTeacherData.data() != null) {
    UserCredentialsController.teacherModel =
        TeacherModel.fromMap(classTeacherData.data()!);
    Get.to(ClassTeacherMainHomeScreen());
  } else {
    showToast(msg: "Please login again");
    Get.to(const DujoLoginScren());
  }
}
