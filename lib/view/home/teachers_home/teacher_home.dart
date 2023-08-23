// ignore_for_file: use_key_in_widget_constructors, must_call_super, annotate_overrides, non_constant_identifier_names
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/home/teachers_home/teacher_classes_list.dart';
import 'package:dujo_kerala_application/view/widgets/fonts/google_monstre.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../student_home/Student Edit Profile/teacher_edit_profile.dart';

class TeacherHomeScreen extends StatefulWidget {


  static String routeName = '';

  @override
  State<TeacherHomeScreen> createState() => _TeacherHomeScreenState();
}

class _TeacherHomeScreenState extends State<TeacherHomeScreen> {

  String deviceToken = '';

  void getDeviceToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      setState(() {
        deviceToken = token ?? 'Not get the token ';
        log("User Device Token :: $token");
      });
      saveDeviceTokenToFireBase(deviceToken);
    });
  }

  void saveDeviceTokenToFireBase(String deviceToken) async {
    await FirebaseFirestore.instance
        .collection("SchoolListCollection")
        .doc(UserCredentialsController.schoolId)
        .collection(UserCredentialsController.batchId!)
        .doc(UserCredentialsController.batchId)
        .collection('classes')
        .doc(UserCredentialsController.classId)
        .collection('teachers')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({'deviceToken': deviceToken}, SetOptions(merge: true)).then(
            (value) => log('Device Token Saved To FIREBASE')).then((value) =>
             FirebaseFirestore.instance.collection('PushNotificationToAll').doc(FirebaseAuth.instance.currentUser!.uid).set({
              'deviceToken' : deviceToken, 
              'schoolID': UserCredentialsController.schoolId, 
              'batchID': UserCredentialsController.batchId, 
              'classID': UserCredentialsController.classId, 
              'personID' :FirebaseAuth.instance.currentUser!.uid, 
              'role': 'Teacher'
            })).then((value) => 
            FirebaseFirestore.instance.collection('SchoolListCollection').doc(UserCredentialsController.schoolId).collection('PushNotificationList')
            .doc(FirebaseAuth.instance.currentUser!.uid).set({
              'deviceToken' : deviceToken, 
              'batchID': UserCredentialsController.batchId, 
              'classID': UserCredentialsController.classId, 
              'personID' :FirebaseAuth.instance.currentUser!.uid, 
              'role': 'Teacher'
            }));
  }

  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDeviceToken();

    //   sendPushMessage( deviceToken, 'Hello Everyone', 'DUJO APP');
  }


  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: cgraident,
              width: double.infinity,
              height: screenSize.width * 0.5,
              padding: EdgeInsets.all(15.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: screenSize.width / 2,
                          child: GoogleMonstserratWidgets(
                            overflow: TextOverflow.ellipsis,
                            text: UserCredentialsController
                                    .teacherModel?.teacherName ??
                                "",
                            fontsize: 23.sp,
                            fontWeight: FontWeight.bold,
                            color: cWhite,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => const TeacherEditProfileScreen());
                          },
                          child: Container(
                            child: Stack(
                              children: [
                                CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    
                                      UserCredentialsController
                                              .teacherModel?.imageUrl ??
                                          ""),
                                  radius: 50.r,
                                ),
                                Positioned(
                                  right: 6.r,
                                  bottom: 1.r,
                                  child: const Center(child: Icon(Icons.info)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GoogleMonstserratWidgets(
                    text:
                        'Employee ID : ${UserCredentialsController.teacherModel?.employeeID ?? ""}',
                    fontsize: 14.5.sp,
                    fontWeight: FontWeight.w500,
                    color: cWhite.withOpacity(0.8),
                  ),
                  GoogleMonstserratWidgets(
                    text:
                        'email : ${UserCredentialsController.teacherModel?.teacherEmail ?? ""}',
                    fontsize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: cWhite.withOpacity(0.7),
                  ),
                ],
              ),
            ),
            TeacherClassListView(
         
            ),
          ],
        ),
      ),
    );
  }
}

Widget MenuItem(int id, String image, String title, bool selected, onTap) {
  return Material(
    color: Colors.white,
    child: InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 30,
                width: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage(image))),
              ),
            ),
            Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                ))
          ],
        ),
      ),
    ),
  );
}
