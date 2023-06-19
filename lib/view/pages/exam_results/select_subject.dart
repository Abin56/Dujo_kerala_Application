import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/pages/exam_results/edit_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectExamSubjectScreen extends StatelessWidget {
  String examId;
  String classID;
  String examLevel;

  SelectExamSubjectScreen({super.key, required this.classID,required this.examLevel, required this.examId});

  @override
  Widget build(BuildContext context) {
    int columnCount = 3;
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Subject'.tr),
        backgroundColor: adminePrimayColor,
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('SchoolListCollection')
              .doc(UserCredentialsController.schoolId)
              .collection(UserCredentialsController.batchId!)
              .doc(UserCredentialsController.batchId!)
              .collection('classes')
              .doc(classID)
              .collection('Exam Results')
              .doc(examId)
              .collection('Subjects')
              .snapshots(),
          builder: (context, snapshots) {
            if (snapshots.hasData) {
              return AnimationLimiter(
                child: GridView.count(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  padding: EdgeInsets.all(w / 60),
                  crossAxisCount: columnCount,
                  children: List.generate(
                    snapshots.data!.docs.length,
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
                              onTap: () async {
                                Get.to(()=>EditExamResultScreen(
                                  examlevel: examLevel,
                                  subjectID:snapshots.data!.docs[index]['subjectid'] ,
                                    classID: classID,
                                    examId: examId));
                              },
                              child: Container(
                                height: h / 100,
                                width: double.infinity,
                                margin: EdgeInsets.only(
                                    bottom: w / 10,
                                    left: w / 50,
                                    right: w / 50),
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(212, 67, 30, 203)
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
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      '${snapshots.data!.docs[index]['subject']}',
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
                        ),
                      );
                    },
                  ),
                ),
              );
            } else {
              return const Text('');
            }
          }),
    );
  }
}
