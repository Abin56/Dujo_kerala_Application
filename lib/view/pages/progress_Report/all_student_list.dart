import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/view/pages/progress_Report/progress_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../controllers/get_parent&guardian/getx.dart';

class AllStudentsListScreen extends StatelessWidget {
  String schooilID;
  String classID;
  String examName;
  String batchId;
  String teacherId;
  AllStudentsListScreen(
      {required this.schooilID,
      required this.classID,
      required this.examName,
      required this.batchId,
      required this.teacherId,
      super.key});

  @override
  Widget build(BuildContext context) {
    int columnCount = 3;
    double _w = MediaQuery.of(context).size.width;
    double _h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Student List"),
      ),
      body: SafeArea(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("SchoolListCollection")
                  .doc(schooilID)
                  .collection(batchId)
                  .doc(batchId)
                  .collection("Classes")
                  .doc(classID)
                  .collection("Students")
                  .orderBy('studentName', descending: false)
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
                                    Get.to(StudentProgressReportScreen(
                                      batchId: batchId,
                                      teacherid: teacherId,
                                      studentId: snapshot.data!.docs[index]
                                          .data()['docid'],
                                      dob: '',
                                      examName: examName,
                                      rollNo:' ${index+1}',
                                      studentImage: snapshot.data!.docs[index]
                                          .data()['profileImageUrl'],
                                      studentName: snapshot.data!.docs[index]
                                          .data()['studentName'],
                                      classID: classID,
                                      schooilID: schooilID,
                                    ));
                                  },
                                  child: Container(
                                    height: _h / 100,
                                    width: double.infinity,
                                    margin: EdgeInsets.only(
                                        bottom: _w / 10,
                                        left: _w / 50,
                                        right: _w / 50),
                                    decoration: BoxDecoration(
                                      color:
                                          const Color.fromARGB(212, 67, 30, 203)
                                              .withOpacity(0.1),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          blurRadius: 40,
                                          spreadRadius: 10,
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          CircleAvatar(),
                                          Text(
                                            snapshot.data!.docs[index]
                                                .data()['studentName'],
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
              })),
    );
  }
}
