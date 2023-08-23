import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:dujo_kerala_application/model/parent_model/parent_model.dart';
import 'package:dujo_kerala_application/model/student_model/student_model.dart';
import 'package:dujo_kerala_application/model/teacher_model/teacher_model.dart';
import 'package:dujo_kerala_application/utils/utils.dart';
import 'package:dujo_kerala_application/view/home/class_teacher_HOme/class_teacher_mainhome.dart';
import 'package:dujo_kerala_application/view/home/parent_home/parent_main_home_screen.dart';
import 'package:dujo_kerala_application/view/home/student_home/students_main_home.dart';
import 'package:dujo_kerala_application/view/home/teachers_home/teacher_main_home.dart';
import 'package:dujo_kerala_application/view/pages/login/dujo_login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

import '../../../helper/shared_pref_helper.dart';
import '../../../model/guardian_model/guardian_model.dart';
import '../../home/guardian_home/guardian_main_home.dart';
import '../../widgets/fonts/google_monstre.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    nextpage();
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
           Center(
            child: AnimationConfiguration.staggeredGrid(
               position: 1,
                            duration: const Duration(milliseconds: 4000),
                            columnCount: 3,
              child: ScaleAnimation(
                  duration: const Duration(milliseconds: 900),
                                curve: Curves.fastLinearToSlowEaseIn,
                child: FadeInAnimation(
                  child: Container(
                
                    height: 220.h,
                    width: 220.w,
                    decoration: const BoxDecoration(
                      
                        image: DecorationImage(
                            image: AssetImage('assets/images/leptonlogo.png',), )),
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: AnimationConfiguration.staggeredGrid(
               position: 2,
                            duration: const Duration(milliseconds: 4000),
                            columnCount: 3,
              child: ScaleAnimation(
                  duration: const Duration(milliseconds: 900),
                                curve: Curves.fastLinearToSlowEaseIn,
                child: FadeInAnimation(
                  child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GoogleMonstserratWidgets(
                  text: 'COSTECH',
                  fontsize: 25,
                  color: const Color.fromARGB(255, 230, 18, 3),
                  fontWeight: FontWeight.bold,
                ),
                GoogleMonstserratWidgets(
                  text: ' DuJo',
                  fontsize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
                ),
              ),
            ),
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     GoogleMonstserratWidgets(
          //       text: 'COSTECH',
          //       fontsize: 27.sp,
          //       color: const Color.fromARGB(255, 201, 14, 1),
          //       fontWeight: FontWeight.bold,
          //     ),
          //     Text(
          //       " DuJo",
                
          //       style: DGoogleFonts.headTextStyleMont,
          //     ),
          //   ],
          // ), const SizedBox(height: 10,),
          
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

  await Future.delayed(const Duration(seconds: 6));
  log("schoolId:${UserCredentialsController.schoolId}");
  log("batchId:${UserCredentialsController.batchId}");
  log("classId:${UserCredentialsController.classId}");
  log("userRole:${UserCredentialsController.userRole}");
  log('Firebase Auth ${FirebaseAuth.instance.currentUser?.uid}');

  if (auth.currentUser == null) {
   
   Get.offAll(() => const DujoLoginScren());
  } else {
    final DocumentReference<Map<String, dynamic>> firebaseFirestore =
        FirebaseFirestore.instance
            .collection('SchoolListCollection')
            .doc(UserCredentialsController.schoolId);
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
      await checkParent(firebaseFirestore, auth);

      //checking user is guardian
    } else if (UserCredentialsController.userRole == 'guardian') {
      await checkGuardian(firebaseFirestore, auth);
    } else {
      Get.to(() => const DujoLoginScren());
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
      .collection('Students')
      .doc(auth.currentUser?.uid)
      .get();

  if (studentData.data() != null) {
    UserCredentialsController.studentModel =
        StudentModel.fromJson(studentData.data()!);
    Get.to(() => const StudentsMainHomeScreen());
  } else {
    showToast(msg: "Please login again");
    Get.to(() => const DujoLoginScren());
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
    Get.to(() => const TeacherMainHomeScreen());
  } else {
    showToast(msg: "Please login again");
    Get.to(() => const DujoLoginScren());
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
    Get.to(() => const ClassTeacherMainHomeScreen());
  } else {
    showToast(msg: "Please login again");
    Get.to(() => const DujoLoginScren());
  }
}

Future<void> checkParent(
    DocumentReference<Map<String, dynamic>> firebaseFirestore,
    FirebaseAuth auth) async {
  final DocumentSnapshot<Map<String, dynamic>> parentData =
      await firebaseFirestore
          .collection(UserCredentialsController.batchId ?? "")
          .doc(UserCredentialsController.batchId)
          .collection('classes')
          .doc(UserCredentialsController.classId)
          .collection('ParentCollection')
          .doc(auth.currentUser?.uid)
          .get();

  if (parentData.data() != null) {
    UserCredentialsController.parentModel =
        ParentModel.fromMap(parentData.data()!);
    Get.to(() => const ParentMainHomeScreen());
  } else {
    showToast(msg: "Please login again");
    Get.to(() => const DujoLoginScren());
  }
}

Future<void> checkGuardian(
    DocumentReference<Map<String, dynamic>> firebaseFirestore,
    FirebaseAuth auth) async {
  final DocumentSnapshot<Map<String, dynamic>> guardianData =
      await firebaseFirestore
          .collection(UserCredentialsController.batchId ?? "")
          .doc(UserCredentialsController.batchId)
          .collection('classes')
          .doc(UserCredentialsController.classId)
          .collection('GuardianCollection')
          .doc(auth.currentUser?.uid)
          .get();

  if (guardianData.data() != null) {
    UserCredentialsController.guardianModel =
        GuardianModel.fromMap(guardianData.data()!);
    Get.to(() => const GuardianMainHomeScreen());
  } else {
    showToast(msg: "Please login again");
    Get.to(() => const DujoLoginScren());
  }
}

Future<bool> onbackbuttonpressed(BuildContext context) async {
  bool exitApp = await showDialog(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Alert'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text('Do you want to exit from Lepton Dujo ?')
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('No'),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
          TextButton(
            child: const Text('Yes'),
            onPressed: () {
              SystemNavigator.pop();
            },
          ),
        ],
      );
    },
  );
  return exitApp;
}
