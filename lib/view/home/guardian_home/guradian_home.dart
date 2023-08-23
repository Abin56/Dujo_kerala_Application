// ignore_for_file: use_key_in_widget_constructors, must_call_super, annotate_overrides, non_constant_identifier_names
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/home/guardian_home/guardian_accer.dart';
import 'package:dujo_kerala_application/view/widgets/fonts/google_monstre.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constant/sizes/constant.dart';
import '../student_home/Student Edit Profile/guardian_edit_profile.dart';

class GuardianHomeScreen extends StatefulWidget {
  @override
  State<GuardianHomeScreen> createState() => _GuardianHomeScreenState();
}

class _GuardianHomeScreenState extends State<GuardianHomeScreen> {
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
        .collection('GuardianCollection')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({'deviceToken': deviceToken}, SetOptions(merge: true)).then(
            (value) => log('Device Token Saved To FIREBASE')).then(
            (value) => log('Device Token Saved To FIREBASE')).then((value) =>
             FirebaseFirestore.instance.collection('PushNotificationToAll').doc(FirebaseAuth.instance.currentUser!.uid).set({
              'deviceToken' : deviceToken, 
              'schoolID': UserCredentialsController.schoolId, 
              'batchID': UserCredentialsController.batchId, 
              'classID': UserCredentialsController.classId, 
              'personID' :FirebaseAuth.instance.currentUser!.uid, 
              'role': 'Guardian'
            })).then((value) => 
            FirebaseFirestore.instance.collection('SchoolListCollection').doc(UserCredentialsController.schoolId).collection('PushNotificationList')
            .doc(FirebaseAuth.instance.currentUser!.uid).set({
              'deviceToken' : deviceToken, 
              'batchID': UserCredentialsController.batchId, 
              'classID': UserCredentialsController.classId, 
              'personID' :FirebaseAuth.instance.currentUser!.uid, 
              'role': 'Guardian'
            }));


    //AAAAd0ScEck:APA91bELuwPRaLXrNxKTwj-z6EK-mCSPOon5WuZZAwkdklLhWvbi_NxXGtwHICE92vUzGJyE9xdOMU_-4ZPbWy8s2MuS_s-4nfcN_rZ1uBTOCMCcJ5aNS7rQHeUTXgYux54-n4eoYclp  apikey
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDeviceToken();

    //   sendPushMessage( deviceToken, 'Hello Everyone', 'DUJO APP');
  }

  Widget build(BuildContext context) {
    String studentName = '';
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
                                .guardianModel!.guardianName!,
                            fontsize: 23.sp,
                            fontWeight: FontWeight.bold,
                            color: cWhite,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => const GuardianEditProfileScreen());
                          },
                          child: Container(
                            child: Stack(
                              children: [
                                CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      UserCredentialsController
                                              .guardianModel!.profileImageURL ??
                                          netWorkImagePathPerson),
                                  radius: 50.r,
                                ),
                                //
                                Positioned(
                                  right: 6.r,
                                  bottom: 1.r,
                                  child: CircleAvatar(
                                    // backgroundColor: cWhite,
                                    radius: 12.r,
                                    child:
                                        const Center(child: Icon(Icons.info)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  FutureBuilder(
                      future: FirebaseFirestore.instance
                          .collection("SchoolListCollection")
                          .doc(UserCredentialsController.schoolId)
                          .collection("AllStudents")
                          .doc(UserCredentialsController
                                  .guardianModel?.studentID ??
                              '')
                          .get(),
                      builder: (context, snap) {
                        if (snap.hasData) {
                          return GoogleMonstserratWidgets(
                            text:
                                'Student : ${snap.data?.data()?['studentName']} ',
                            fontsize: 14.5.sp,
                            fontWeight: FontWeight.w500,
                            color: cWhite.withOpacity(0.8),
                          );
                        } else {
                          return const Text('');
                        }
                      }),
                  FutureBuilder(
                      future: FirebaseFirestore.instance
                          .collection('SchoolListCollection')
                          .doc(UserCredentialsController.schoolId)
                          .collection(UserCredentialsController.batchId!)
                          .doc(UserCredentialsController.batchId)
                          .collection('classes')
                          .doc(UserCredentialsController.classId)
                          .get(),
                      builder: (context, snaps) {
                        if (snaps.hasData) {
                          return GoogleMonstserratWidgets(
                            text: 'Class : ${snaps.data!.data()!['className']}',
                            fontsize: 13.sp,
                            fontWeight: FontWeight.w500,
                            color: cWhite.withOpacity(0.8),
                          );
                        } else {
                          return const Text('');
                        }
                      }),
                  GoogleMonstserratWidgets(
                    text:
                        'email : ${UserCredentialsController.guardianModel?.guardianEmail ?? ""}',
                    fontsize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: cWhite.withOpacity(0.7),
                  ),
                ],
              ),
            ),
            GuardianAccessories(studentName: UserCredentialsController.guardianModel!.studentID!)
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
