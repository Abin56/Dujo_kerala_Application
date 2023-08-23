// ignore_for_file: use_key_in_widget_constructors, must_call_super, annotate_overrides, non_constant_identifier_names
import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:dujo_kerala_application/local_database/parent_login_database.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/constant/sizes/constant.dart';
import 'package:dujo_kerala_application/view/home/parent_home/parent_accessories/parent_access.dart';
import 'package:dujo_kerala_application/view/home/parent_home/parent_profile_edit/parent_edit_profile.dart';
import 'package:dujo_kerala_application/view/widgets/fonts/google_monstre.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../controllers/multipile_students/multipile_students_controller.dart';

class ParentHomeScreen extends StatefulWidget {
  @override
  State<ParentHomeScreen> createState() => _ParentHomeScreenState();
}

class _ParentHomeScreenState extends State<ParentHomeScreen> {
  MultipileStudentsController multipileStudentsController =
      Get.put(MultipileStudentsController());

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
        .collection('ParentCollection')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({'deviceToken': deviceToken}, SetOptions(merge: true)).then(
            (value) => log('Device Token Saved To FIREBASE')).then((value) => FirebaseFirestore.instance.collection('PushNotificationToAll').doc(FirebaseAuth.instance.currentUser!.uid).set({
              'deviceToken' : deviceToken, 
              'schoolID': UserCredentialsController.schoolId, 
              'batchID': UserCredentialsController.batchId, 
              'classID': UserCredentialsController.classId, 
              'personID' :FirebaseAuth.instance.currentUser!.uid, 
              'role': 'Parent'
            })).then((value) => 
            FirebaseFirestore.instance.collection('SchoolListCollection').doc(UserCredentialsController.schoolId).collection('PushNotificationList')
            .doc(FirebaseAuth.instance.currentUser!.uid).set({
              'deviceToken' : deviceToken, 
              'batchID': UserCredentialsController.batchId, 
              'classID': UserCredentialsController.classId, 
              'personID' :FirebaseAuth.instance.currentUser!.uid, 
              'role': 'Parent'
            }));
  }

// }

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDeviceToken();

    //   sendPushMessage( deviceToken, 'Hello Everyone', 'DUJO APP');
  }

  Widget build(BuildContext context) {
    log("Parent DOCID :::::::::::::::::::  ${UserCredentialsController.parentModel?.docid}");
    log("Firebase Auth DOCID :::::::::::::::::::  ${FirebaseAuth.instance.currentUser?.uid}");
    final parentAuth = DBParentLogin(
        parentPassword: ParentPasswordSaver.parentPassword,
        parentEmail: ParentPasswordSaver.parentemailID,
        schoolID: UserCredentialsController.schoolId!,
        batchID: UserCredentialsController.batchId!,
        classID: UserCredentialsController.classId!,
        studentID: UserCredentialsController.parentModel!.studentID!,
        parentID: FirebaseAuth.instance.currentUser!.uid,
        emailID: FirebaseAuth.instance.currentUser!.email ?? "",
        parentDocID: FirebaseAuth.instance.currentUser!.uid);
    multipileStudentsController.checkalreadyexist(
        FirebaseAuth.instance.currentUser!.uid, parentAuth);

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
                        GestureDetector(
                          onTap: () {
                            log(UserCredentialsController
                                .parentModel!.studentID!);
                          },
                          child: SizedBox(
                            width: screenSize.width / 2,
                            child: GoogleMonstserratWidgets(
                              overflow: TextOverflow.ellipsis,
                              text: UserCredentialsController
                                  .parentModel!.parentName!,
                              fontsize: 23.sp,
                              fontWeight: FontWeight.bold,
                              color: cWhite,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => ParentEditProfileScreen());
                          },
                          child: Stack(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                    UserCredentialsController
                                            .parentModel!.profileImageURL ??
                                        ''),
                                radius: 50.r,
                              ),
                              Positioned(
                                right: 6.r,
                                bottom: 1.r,
                                child: CircleAvatar(
                                  //  backgroundColor: cWhite,
                                  radius: 12.r,
                                  child: const Center(child: Icon(Icons.info)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('SchoolListCollection')
                          .doc(UserCredentialsController.schoolId)
                          .collection(UserCredentialsController.batchId!)
                          .doc(UserCredentialsController.batchId)
                          .collection('classes')
                          .doc(UserCredentialsController.classId)
                          .collection('ParentCollection')
                          .doc(UserCredentialsController.parentModel!.docid)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const SizedBox();
                        }
                        return (snapshot.data?.data()?['multipleChildren'] ==
                                null)
                            ? const SizedBox()
                            : const Text(
                                'Switch to next',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              );
                      }),
                  //     StreamBuilder(
                  //       stream: FirebaseFirestore.instance.collection('SchoolListCollection')
                  //       .doc(UserCredentialsController.schoolId)
                  //       .collection(UserCredentialsController.batchId!)
                  //       .doc(UserCredentialsController.batchId)
                  //       .collection('classes')
                  //       .doc(UserCredentialsController.classId)
                  //       .collection('ParentCollection')
                  //       .doc(UserCredentialsController.parentModel!.docid).snapshots(),
                  //       builder: ((context, snapshot) {
                  //         if(snapshot.hasData){
                  //            return StreamBuilder(
                  //         stream: FirebaseFirestore.instance
                  //             .collection("SchoolListCollection")
                  //             .doc(UserCredentialsController.schoolId)
                  //             .collection("AllStudents")
                  //             .doc(snapshot.data?.data()?['childrenIDList'][1])
                  //             .snapshots(),
                  //         builder: (context, snap) {
                  //           if (snap.hasData) {
                  //             return GestureDetector(
                  //               onTap: ()async{
                  //       //           DocumentSnapshot sur= await FirebaseFirestore.instance.collection('SchoolListCollection')
                  //       // .doc(UserCredentialsController.schoolId)
                  //       // .collection(UserCredentialsController.batchId!)
                  //       // .doc(UserCredentialsController.batchId)
                  //       // .collection('classes')
                  //       // .doc(UserCredentialsController.classId)
                  //       // .collection('ParentCollection').doc(UserCredentialsController.parentModel!.docid).get();

                  //       //  DocumentSnapshot kur = await FirebaseFirestore.instance
                  //       //       .collection("SchoolListCollection")
                  //       //       .doc(UserCredentialsController.schoolId)
                  //       //       .collection("AllStudents")
                  //       //       .doc(snapshot.data?.data()?['childrenIDList'][0])
                  //       //       .get();

                  //       // DocumentReference surRef = sur.reference;

                  //       // List<String> listToUpdate = [];
                  //       // listToUpdate.add(sur['childrenIDList'][1]);
                  //       // listToUpdate.add(sur['childrenIDList'][0]);
                  //       // surRef.update({
                  //       //   'childrenIDList' : listToUpdate,
                  //       //   'studentID' : listToUpdate[0]
                  //       // });

                  //       // UserCredentialsController.parentModel!.studentID = await sur['childrenIDList'][0];
                  //       // UserCredentialsController.classId = await kur['classID'];
                  //       // UserCredentialsController.parentModel!.studentID = await kur['docid'];

                  //       // Timer(const Duration(seconds: 5), () {
                  //       //   log('STUDENT ID :${UserCredentialsController.parentModel!.studentID!}');
                  //       // log( 'CLASS ID :${UserCredentialsController.classId!}');
                  //       // });

                  //   //     await FirebaseAuth.instance.signOut().then((value) async {
                  //   // await SharedPreferencesHelper.clearSharedPreferenceData();
                  //   // UserCredentialsController.clearUserCredentials();
                  //   // Get.offAll(() => ParentLoginScreen());

                  // /////  });

                  //               },
                  //               child: GoogleMonstserratWidgets(
                  //                 text:
                  //                     'Switch to ${snap.data?.data()?['studentName']} ',
                  //                 fontsize: 15.sp,
                  //                 fontWeight: FontWeight.bold,
                  //                 color: cWhite,
                  //               ),
                  //             );
                  //           } else {
                  //             return const Text('');
                  //           }
                  //         });
                  // return (snapshot.data?.data()?['multipleChildren']==true)? GoogleMonstserratWidgets(text: 'Switch to ${snapshot.data?.data()?['childrenIDList'][1]}',  fontsize: 15.sp, overflow: TextOverflow.ellipsis,
                  //     fontWeight: FontWeight.bold,
                  //     color: cWhite,):
                  //    ;
                  //  }

                  //   return const CircularProgressIndicator();
                  // })),

                  const SizedBox(
                    height: 5,
                  ),
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('SchoolListCollection')
                          .doc(UserCredentialsController.schoolId)
                          .collection(UserCredentialsController.batchId!)
                          .doc(UserCredentialsController.batchId)
                          .collection('classes')
                          .doc(UserCredentialsController.classId)
                          .collection('ParentCollection')
                          .doc(UserCredentialsController.parentModel!.docid)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const SizedBox();
                        }
                        return const SizedBox();
                        //Text(snapshot.data!.data()!['parentName']);
                      }),
                  FutureBuilder(
                      future: FirebaseFirestore.instance
                          .collection("SchoolListCollection")
                          .doc(UserCredentialsController.schoolId)
                          .collection("AllStudents")
                          .doc(UserCredentialsController
                                  .parentModel?.studentID ??
                              '')
                          .get(),
                      builder: (context, snap) {
                        if (snap.hasData) {
                          return GoogleMonstserratWidgets(
                            text:
                                'Student : ${snap.data?.data()?['studentName']}',
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
                            text: 'Class : ${snaps.data?.data()?['className']}',
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
                        'email : ${UserCredentialsController.parentModel?.parentEmail ?? ""}',
                    fontsize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: cWhite.withOpacity(0.7),
                  ),
                ],
              ),
            ),
            ParentAccessories(
              studentName: UserCredentialsController.parentModel!.studentID!,
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
