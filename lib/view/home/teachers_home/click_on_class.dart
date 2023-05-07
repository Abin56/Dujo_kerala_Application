import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:dujo_kerala_application/view/home/sample/under_maintance.dart';
import 'package:dujo_kerala_application/view/pages/exam_notification/view_exams.dart';
import 'package:dujo_kerala_application/view/pages/progress_Report/all_student_list.dart';
import 'package:dujo_kerala_application/view/pages/progress_Report/create_examName_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../pages/Attentence/take_attentence/attendence_book_status.dart';
import '../../pages/attentence/take_attentence_subject_listView.dart';
import '../../pages/progress_Report/view_report/view_exam_list.dart';

class ClickOnClasss extends StatelessWidget {
  String classID;
  String className;
  ClickOnClasss({required this.classID, required this.className, super.key});

  @override
  Widget build(BuildContext context) {
    final noDataNavigation = [
      AttendenceBookScreen(
          schoolId: UserCredentialsController.schoolId!,
          batchId: UserCredentialsController.batchId!,
          classID: UserCredentialsController.classId!), //Attendance Book
      const ViewExamsScreen(), //Exam
      const UnderMaintanceScreen(text: ''), //Home Works
      const UnderMaintanceScreen(text: ''), // Notice
      const UnderMaintanceScreen(text: ''), // Events
      const UnderMaintanceScreen(text: ''), // Meetings
    ];
    final hasDataNavigation = [
      TakeAttentenceSubjectWise(
          batchId: UserCredentialsController.batchId!,
          classID: UserCredentialsController.classId!,
          schoolId: UserCredentialsController.schoolId!), //Take Attendance
      AttendenceBookScreen(
          schoolId: UserCredentialsController.schoolId!,
          batchId: UserCredentialsController.batchId!,
          classID: UserCredentialsController.classId!), //Attendance Book
                const UnderMaintanceScreen(text: ''), //TimeTable
      const ViewExamsScreen(), //Exam
      const UnderMaintanceScreen(text: ''), //Home Works
      const UnderMaintanceScreen(text: ''), // Notice
      const UnderMaintanceScreen(text: ''), // Events
      ViewExamsForProgressreport(
          batchId: UserCredentialsController.batchId!,
          classID: classID,
          schooilID:
              UserCredentialsController.schoolId!), //Progress Report view
      const UnderMaintanceScreen(text: ''), // Subjects
      const UnderMaintanceScreen(text: ''), // Meetings
    ];
    int columnCount = 2;
    double _w = MediaQuery.of(context).size.width;
    double _h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(className),
      ),
      body: SafeArea(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("SchoolListCollection")
                  .doc(UserCredentialsController.schoolId!)
                  .collection(UserCredentialsController.batchId!)
                  .doc(UserCredentialsController.batchId!)
                  .collection("classes")
                  .doc(classID)
                  .collection("teachers")
                  .doc(UserCredentialsController.teacherModel!.docid)
                  .collection("teacherSubject")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.docs.isEmpty) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 200.h,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'You have no access in this class',
                                style: GoogleFonts.montserrat(
                                    color: Colors.black.withOpacity(0.8),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: AnimationLimiter(
                            child: GridView.count(
                              physics: const BouncingScrollPhysics(
                                  parent: AlwaysScrollableScrollPhysics()),
                              padding: EdgeInsets.all(_w / 60),
                              crossAxisCount: columnCount,
                              children: List.generate(
                                _acc_text.length,
                                (int index) {
                                  return AnimationConfiguration.staggeredGrid(
                                    position: index,
                                    duration: const Duration(milliseconds: 300),
                                    columnCount: columnCount,
                                    child: ScaleAnimation(
                                      duration:
                                          const Duration(milliseconds: 900),
                                      curve: Curves.fastLinearToSlowEaseIn,
                                      child: FadeInAnimation(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              Get.to(noDataNavigation[index]);
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white
                                                    .withOpacity(0.5),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(30)),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.1),
                                                    blurRadius: 40,
                                                    spreadRadius: 10,
                                                  ),
                                                ],
                                              ),
                                              height: _h / 100,
                                              width: double.infinity,
                                              margin: EdgeInsets.only(
                                                  bottom: _w / 10,
                                                  left: _w / 50,
                                                  right: _w / 50),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Container(
                                                    height: 75,
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        image: AssetImage(
                                                            _acc_images[index]),
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    _acc_text[index],
                                                    style:
                                                        GoogleFonts.montserrat(
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.5),
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                  )
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
                          ),
                        )
                      ],
                    );
                  } else {
                    return AnimationLimiter(
                      child: GridView.count(
                        physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        padding: EdgeInsets.all(_w / 60),
                        crossAxisCount: columnCount,
                        children: List.generate(
                          hasDataText.length,
                          (int index) {
                            return AnimationConfiguration.staggeredGrid(
                              position: index,
                              duration: const Duration(milliseconds: 300),
                              columnCount: columnCount,
                              child: ScaleAnimation(
                                duration: const Duration(milliseconds: 900),
                                curve: Curves.fastLinearToSlowEaseIn,
                                child: FadeInAnimation(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.to(hasDataNavigation[index]);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color:
                                              Colors.white.withOpacity(0.5),
                                          borderRadius:
                                              const BorderRadius.all(
                                                  Radius.circular(30)),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black
                                                  .withOpacity(0.1),
                                              blurRadius: 40,
                                              spreadRadius: 10,
                                            ),
                                          ],
                                        ),
                                        height: _h / 100,
                                        width: double.infinity,
                                        margin: EdgeInsets.only(
                                            bottom: _w / 10,
                                            left: _w / 50,
                                            right: _w / 50),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              height: 75,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      hasDataImages[index]),
                                                ),
                                              ),
                                            ),
                                            Text(
                                              hasDataText[index],
                                              style: GoogleFonts.montserrat(
                                                  color: Colors.black
                                                      .withOpacity(0.5),
                                                  fontSize: 13,
                                                  fontWeight:
                                                      FontWeight.w600),
                                            )
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
                  }
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              })),
    );
  }
}

List<String> _acc_text = [
  'Attendance Book',
  'Exams',
  'TimeTable',
  'Notices',
  'Events',
  'Meetings',
];
var _acc_images = [
  'assets/images/classroom.png',
  'assets/images/exam.png',
  'assets/images/library.png',
  'assets/images/school_building.png',
  'assets/images/activity.png',
  'assets/images/teachers.png',
];
var hasDataImages = [
  'assets/images/attendance.png',
  'assets/images/classroom.png',
  'assets/images/exam.png',
  'assets/images/library.png',
  'assets/images/homework.png',
  'assets/images/school_building.png',
  'assets/images/activity.png',
  'assets/images/splash.png',
  'assets/images/subjects.png',
  'assets/images/teachers.png',
];
List<String> hasDataText = [
  'Take Attendance',
  'Attendance Book',
  'Exams',
  'TimeTable',
  'HomeWorks',
  'Notices',
  'Events',
  'Progress Report',
  'Subjects',
  'Meetings',
];
