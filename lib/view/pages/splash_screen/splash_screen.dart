// ignore_for_file: must_be_immutable

import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:dujo_kerala_application/main.dart';
import 'package:dujo_kerala_application/model/student_model/student_model.dart';
import 'package:dujo_kerala_application/view/home/sample/under_maintance.dart';
import 'package:dujo_kerala_application/view/pages/login/dujo_login_screen.dart';
import 'package:dujo_kerala_application/view/pages/login/users_login_screen/student%20login/student_login.dart';
import 'package:dujo_kerala_application/view/pages/splash_screen/user_check_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../fonts/fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashScreen extends StatelessWidget {
   SplashScreen({super.key}); 




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

  await Future.delayed(const Duration(seconds: 3)); 
  SharedPreferences p = await SharedPreferences.getInstance(); 
  String? schoolIDVal = p.getString('schoolID'); 
  String? batchIDVal = p.getString('batchID');
  String? classIDVal = p.getString('classID');
  log('schoolID $schoolIDVal'); 
  log('batchID: $batchIDVal'); 
  log('classID: $classIDVal'); 

   User? currentUser = auth.currentUser;
      if (currentUser == null) {
    
 Get.to(const DujoLoginScren());
    } else {
      log('UID: ${currentUser.uid}'); 
      
      
      final QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
      .instance
      .collection("SchoolListCollection")
      .doc(schoolIDVal?? '')
      .collection(batchIDVal!)
      .doc(batchIDVal)
      .collection("Classes")
      .doc(classIDVal?? '')
      .collection("Students").where('uid', isEqualTo: currentUser.uid).get();
      print(querySnapshot.docs.length );
      if (querySnapshot.docs.length == 1) {
        UserCredentialsController.studentModel = StudentModel.fromJson(querySnapshot.docs[0].data());
 log('student!!');
  Get.to(StudentLoginScreen());
} else {
  log('not a student!!');
  
  Get.to(const UnderMaintanceScreen(text: "",)); 
}}



 
  


  }
  
 

