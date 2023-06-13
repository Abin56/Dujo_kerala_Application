// ignore_for_file: non_constant_identifier_names, no_leading_underscores_for_local_identifiers

import 'dart:developer';

import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:dujo_kerala_application/utils/utils.dart';
import 'package:dujo_kerala_application/view/home/events/event_list.dart';
import 'package:dujo_kerala_application/view/home/parent_home/progress_report/progress_report.dart';
import 'package:dujo_kerala_application/view/home/student_home/time_table/ss.dart';
import 'package:dujo_kerala_application/view/home/student_home/time_table/time_table_display.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../utils/utils.dart';
import '../../../pages/Attentence/take_attentence/attendence_book_status.dart';
import '../../../pages/Attentence/take_attentence/attendence_book_status_month.dart';
import '../../../pages/Homework/view_home_work.dart';
import '../../../pages/Meetings/Tabs/school_level_meetings_tab.dart';
import '../../../pages/Notice/notice_list.dart';
import '../../../pages/Subject/subject_display.dart';
import '../../../pages/teacher_list/teacher_list.dart';
import '../../exam_Notification/users_exam_list_view/user_exam_acc.dart';

class StudentAccessories extends StatefulWidget {
  const StudentAccessories({
    super.key,
  });

  @override
  State<StudentAccessories> createState() => _StudentAccessoriesState();
}

class _StudentAccessoriesState extends State<StudentAccessories> {



  @override
  Widget build(BuildContext context) {
    log(
      UserCredentialsController.studentModel!.docid,
    );
    final screenNavigation = [
      AttendenceBookScreenSelectMonth(
          schoolId: UserCredentialsController.schoolId!,
          batchId: UserCredentialsController.batchId!,
          classID: UserCredentialsController.classId!), //Attendence
          // const StudentShowTimeTable(), //Time Table
          SS(),
            const ViewHomeWorks(), // Home Works
            StudentSubjectHome(), //Subjects
      TeacherSubjectWiseList(), //Teachers
      const UserExmNotifications(), //Exam
      NoticePage(), //Notice
      const EventList(), //Events
      ProgressReportListViewScreen(
          schoolId: UserCredentialsController.schoolId!,
          classID: UserCredentialsController.classId!,
          studentId: FirebaseAuth.instance.currentUser!.uid,
          batchId: UserCredentialsController.batchId!), //Progress Report
      SchoolLevelMeetingPage(), //Meetings
    ];
    int columnCount = 2;
    double _w = MediaQuery.of(context).size.width;
    double _h = MediaQuery.of(context).size.height;
    return Expanded(
        child: AnimationLimiter(
      child: GridView.count(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        padding: EdgeInsets.all(_w / 60),
        crossAxisCount: columnCount,
        children: List.generate(
          _acc_images.length,
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
                        Get.to(screenNavigation[index]);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
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
                        height: _h / 100,
                        width: double.infinity,
                        margin: EdgeInsets.only(
                            top: _w / 30, left: _w / 30, right: _w / 30),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Container(
                                height: 75,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(_acc_images[index]),
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              translateString(_acc_text[index]),
                              style: GoogleFonts.montserrat(
                                  color: Colors.black.withOpacity(0.5),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600),
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
    ));
  }
}

List<String> _acc_text = [
  'Attendance',
  'TimeTable',
  'HomeWorks',
  'Subjects/Materials',
  'Teachers',
  'Exams',
  'Notices',
  'Events',
  'Progress Report',
  'Meetings'
];
var _acc_images = [
  'assets/images/attendance.png',
   'assets/images/library.png',
   'assets/images/homework.png',
   'assets/images/subjects.png',
   'assets/images/teachers.png',
  'assets/images/exam.png',
  'assets/images/notices.png',
  'assets/images/activity.png',
  'assets/images/progressreport.png',
  'assets/images/meetings.png',
];
