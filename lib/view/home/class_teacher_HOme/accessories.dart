// ignore_for_file: non_constant_identifier_names, no_leading_underscores_for_local_identifiers

import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:dujo_kerala_application/view/home/class_teacher_HOme/leave_letters/leave_lettersList.dart';
import 'package:dujo_kerala_application/view/home/events/event_list.dart';
import 'package:dujo_kerala_application/view/home/sample/under_maintance.dart';
import 'package:dujo_kerala_application/view/pages/progress_Report/create_examName_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../pages/Attentence/take_attentence/attendence_book_status.dart';
import '../../pages/Attentence/take_attentence_subject_listView.dart';
import '../../pages/Homework/homework.dart';

class ClassTeacherAccessories extends StatelessWidget {
  const ClassTeacherAccessories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenNavigation = [
      TakeAttentenceSubjectWise(
          batchId: UserCredentialsController.batchId!,
          classID: UserCredentialsController.classId!,
          schoolId: UserCredentialsController.schoolId!), //Take Attendance
      AttendenceBookScreen(
          schoolId: UserCredentialsController.schoolId!,
          batchId: UserCredentialsController.batchId!,
          classID: UserCredentialsController.classId!), //Attendance Book
      LeaveLettersListviewScreen(
          schooilID: UserCredentialsController.schoolId!,
          batchID: UserCredentialsController.batchId!,
          classID: UserCredentialsController.classId!), //Leave letters
      const UnderMaintanceScreen(text: ''), //Exam
      const UnderMaintanceScreen(text: ''), //TimeTable
      HomeWorkUpload(
        batchId: UserCredentialsController.batchId!,
        classId: UserCredentialsController.classId!,
        schoolID:  UserCredentialsController.schoolId!,
        teacherID:  UserCredentialsController.teacherModel!.docid!,
      ), //Home Work
      const UnderMaintanceScreen(text: ''), //Notice
      const EventList(),   //Events
      CreateExamNameScreen(
          schooilID: UserCredentialsController.schoolId!,
          classID: UserCredentialsController.classId!,
          teacherId: UserCredentialsController.teacherModel!.docid!,
          batchId: UserCredentialsController.batchId!), //Progress Report
      const UnderMaintanceScreen(text: ''), //Subject
      const UnderMaintanceScreen(text: ''), //Teachers
      const UnderMaintanceScreen(text: ''), //Meetings

      // StudentSubjectHome(),
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
          _acc_text.length,
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
                              const BorderRadius.all(Radius.circular(30)),
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
                            bottom: _w / 10, left: _w / 50, right: _w / 50),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: 75,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(_acc_images[index]),
                                ),
                              ),
                            ),
                            Text(
                              _acc_text[index],
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
    ),
    );
  }
}

List<String> _acc_text = [
  'Take Attendance',
  'Attendance Book',
  'Leave Letters',
  'Exams',
  'TimeTable',
  'HomeWorks',
  'Notices',
  'Events',
  'Progress Report',
  'Subjects',
  'Teachers',
  'Meetings'
];
var _acc_images = [
  'assets/images/attendance.png',
  'assets/images/classroom.png',
  'assets/images/message.png',
  'assets/images/exam.png',
  'assets/images/library.png',
  'assets/images/homework.png',
  'assets/images/school_building.png',
  'assets/images/activity.png',
  'assets/images/splash.png',
  'assets/images/subjects.png',
  'assets/images/teachers.png',
  'assets/images/teachers.png',
];
