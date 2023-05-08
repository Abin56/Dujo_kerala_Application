import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../model/teacher_model/attentence/attendance_model.dart';
import 'teacher_subject_list_view.dart';

class AttendenceBookScreen extends StatelessWidget {
  String schoolId;
  String classID;
  String batchId;
  AttendenceBookScreen(
      {required this.schoolId,
      required this.batchId,
      required this.classID,
      super.key});

  @override
  Widget build(BuildContext context) {
    int columnCount = 3;
    double _w = MediaQuery.of(context).size.width;
    double _h = MediaQuery.of(context).size.height;
    log(classID);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendence Book'),
      ),
      body: SafeArea(
          child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("SchoolListCollection")
            .doc(schoolId)
            .collection(batchId)
            .doc(batchId)
            .collection("classes")
            .doc(classID)
            .collection("Attendence")
            .orderBy('docid', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return AnimationLimiter(
              child: GridView.count(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                padding: EdgeInsets.all(_w / 60),
                crossAxisCount: columnCount,
                children: List.generate(
                  snapshot.data!.docs.length,
                  (int index) {
                    final data = GetAttendenceModel.fromJson(
                        snapshot.data!.docs[index].data());

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
                              Get.to(AttendenceSubjectListScreen(
                                  batchId: batchId,
                                  schoolId: schoolId,
                                  classID: classID,
                                  date: snapshot.data!.docs[index]['docid']));
                            },
                            child: Container(
                              height: _h / 100,
                              width: double.infinity,
                              margin: EdgeInsets.only(
                                  bottom: _w / 10,
                                  left: _w / 50,
                                  right: _w / 50),
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
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    snapshot.data!.docs[index]['dDate'],
                                    style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    snapshot.data!.docs[index]['day'],
                                    style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
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
      )),
    );
  }
}
