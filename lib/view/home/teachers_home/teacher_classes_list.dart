import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../controllers/teacher_home/class_test_controller/class_test_controller.dart';
import '../../../controllers/teacher_home/class_test_controller/monthly_controllers/class_test_monthly_controller.dart';
import 'click_on_class.dart';

class TeacherClassListView extends StatelessWidget {
  TeacherClassListView({
    super.key,
  });
  final ClassTestController classTestController =
      Get.put(ClassTestController());
  final ClassTestMonthlyController classTestMonthlyController =
      Get.put(ClassTestMonthlyController());

  @override
  Widget build(BuildContext context) {
    int columnCount = 3;
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Expanded(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("SchoolListCollection")
            .doc(UserCredentialsController.schoolId)
            .collection(UserCredentialsController.batchId!)
            .doc(UserCredentialsController.batchId!)
            .collection("classes")
            .orderBy('className', descending: true)
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
                              UserCredentialsController.classId =
                                  snapshot.data?.docs[index]['docid'] ?? '';
                              //this data add to classId for class test creation
                              classTestController.classId =
                                  snapshot.data?.docs[index]['docid'] ?? "";
                              classTestMonthlyController.classId =
                                  snapshot.data?.docs[index]['docid'] ?? "";
                              Get.to(() => ClickOnClasss(
                                    className: snapshot.data?.docs[index]
                                            ['className'] ??
                                        "",
                                    classID: snapshot.data?.docs[index]
                                            ['docid'] ??
                                        '',
                                  ));

                              log('Pressed  Class teacher ID :::::   ${UserCredentialsController.classId}');
                            },
                            child: Container(
                              height: h / 100,
                              width: double.infinity,
                              margin: EdgeInsets.only(
                                  bottom: w / 10, left: w / 50, right: w / 50),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(212, 67, 30, 203)
                                    .withOpacity(0.1),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 40,
                                    spreadRadius: 10,
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  snapshot.data?.docs[index]['className'] ?? "",
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
      ),
    );
  }
}

Future backtoSwitchClass() async {
  String classDocID = '';
  final firebase = await FirebaseFirestore.instance
      .collection("SchoolListCollection")
      .doc(UserCredentialsController.schoolId)
      .collection("Teachers")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .get();
  classDocID = firebase.data()?['classID'];
  log('Back To Class teacher ID :::::   $classDocID');
  return classDocID;
}
