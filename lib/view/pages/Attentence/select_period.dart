import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/controllers/attendence_controller/attendence_controller.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'take_attentence_subject_listView.dart';

class SelectPeriodWiseScreen extends StatelessWidget {
  AttendanceController attendanceController = Get.put(AttendanceController());
  String schoolId;
  String batchId;
  String classID;

  SelectPeriodWiseScreen(
      {required this.batchId,
      required this.classID,
      required this.schoolId,
      super.key});

  @override
  Widget build(BuildContext context) {
    final date = DateTime.now();
    DateTime parseDate = DateTime.parse(date.toString());
    final month = DateFormat('MMMM-yyyy');
    String monthwise = month.format(parseDate);
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    String formatted = formatter.format(parseDate);
    log(batchId);
    log(classID);
    log(schoolId);
    log(UserCredentialsController.teacherModel!.docid!);
    int columnCount = 3;
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Select Period'.tr),
          backgroundColor: adminePrimayColor,
          actions: [
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('SchoolListCollection')
                    .doc(UserCredentialsController.schoolId)
                    .collection(UserCredentialsController.batchId!)
                    .doc(UserCredentialsController.batchId)
                    .collection('classes')
                    .doc(classID)
                    .collection('Attendence')
                    .doc(monthwise)
                    .collection(monthwise)
                    .doc(formatted)
                    .collection("PeriodCollection")
                    .snapshots(),
                builder: (context, snapshots) {
                  if (snapshots.hasData) {
                    if (snapshots.data!.docs.isEmpty) {
                      return GestureDetector(
                          onTap: () {
                            attendanceController
                                .dailyAttendanceController(classID);
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                                right: 25.w, top: 10.h, bottom: 10.h),
                            child: Container(
                              width: 100,
                                decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Turn ',
                                        style: TextStyle(
                                            fontSize: 16.w,
                                            fontWeight: FontWeight.w700,
                                            ),
                                      ),
                                           Text(
                                        'ON',
                                        
                                        style: TextStyle(
                                          color: const Color.fromARGB(255, 43, 223, 49),
                                            fontSize: 16.w,
                                            fontWeight: FontWeight.w700,
                                            ),
                                      ),
                                    ],
                                  ),
                                )),
                          )
                          );
                    } else {
                      return const Text('');
                    }
                  } else {
                    return const Text('');
                  }
                })
          ],
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('SchoolListCollection')
                .doc(UserCredentialsController.schoolId)
                .collection(UserCredentialsController.batchId!)
                .doc(UserCredentialsController.batchId)
                .collection('classes')
                .doc(classID)
                .collection('Attendence')
                .doc(monthwise)
                .collection(monthwise)
                .doc(formatted)
                .collection("PeriodCollection")
                .snapshots(),
            builder: (context, turnOnSnaps) {
              if (turnOnSnaps.hasData) {
                if (turnOnSnaps.data!.docs.isEmpty) {
                  return const SafeArea(
                      child: Center(
                    child: Text('Please Click TurnON button to take attendance '),
                  ));
                } else {
                  return SafeArea(
                      child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("SchoolListCollection")
                        .doc(schoolId)
                        .collection(batchId)
                        .doc(batchId)
                        .collection('classes')
                        .doc(classID)
                        .collection('Attendence')
                        .doc(monthwise)
                        .collection(monthwise)
                        .doc(formatted)
                        .collection("PeriodCollection")
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return AnimationLimiter(
                          child: GridView.count(
                            physics: const BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics()),
                            padding: EdgeInsets.all(w / 60),
                            crossAxisCount: columnCount,
                            children: List.generate(
                              snapshot.data!.docs.length,
                              (int index) {
                                return AnimationConfiguration.staggeredGrid(
                                  position: index,
                                  duration: const Duration(milliseconds: 200),
                                  columnCount: columnCount,
                                  child: ScaleAnimation(
                                    duration: const Duration(milliseconds: 900),
                                    curve: Curves.fastLinearToSlowEaseIn,
                                    child: FadeInAnimation(
                                      child: GestureDetector(
                                        onTap: () {
                                          Get.to(() =>
                                              TakeAttentenceSubjectWise(
                                                  periodNumber: snapshot.data
                                                      ?.docs[index]['period'],
                                                  periodTokenID: snapshot.data
                                                      ?.docs[index]['docid'],
                                                  batchId: batchId,
                                                  classID: classID,
                                                  schoolId: schoolId));
                                        },
                                        child: Container(
                                          height: h / 100,
                                          width: double.infinity,
                                          margin: EdgeInsets.only(
                                              bottom: w / 10,
                                              left: w / 50,
                                              right: w / 50),
                                          decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                    212, 67, 30, 203)
                                                .withOpacity(0.1),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10)),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.1),
                                                blurRadius: 40,
                                                spreadRadius: 10,
                                              ),
                                            ],
                                          ),
                                          child: Center(
                                            child: Text(
                                              'Period ${snapshot.data!.docs[index]['period']}',
                                              style: GoogleFonts.poppins(
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator.adaptive(),
                        );
                      }
                    },
                  ));
                }
              } else {
                return const Text('');
              }
            }),
      ),
    );
  }
}
