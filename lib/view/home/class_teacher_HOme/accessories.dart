// ignore_for_file: non_constant_identifier_names, no_leading_underscores_for_local_identifiers

import 'package:dujo_kerala_application/view/home/class_teacher_HOme/leave_letters/leave_lettersList.dart';
import 'package:dujo_kerala_application/view/pages/progress_Report/create_examName_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../pages/Attentence/take_attentence.dart';
import '../../pages/Attentence/take_attentence/attendence_book_status.dart';
import '../../pages/Homework/homework.dart';
import '../../pages/Subject/subject_display.dart';

class ClassTeacherAccessories extends StatelessWidget {
  const ClassTeacherAccessories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenNavigation = [
      TakeAttenenceScreen(
        batchId: '2023-June-2024-February',
        classID: 'class1A@mthss',
        schoolID: 'MarthCheng13283',
        subjectName: 'English',
        subjectID: 't25LpMFzuAUHsH0PJhzF',
        teacheremailID: 'abinjohn8089@gmail.com',
      ),
      AttendenceBookScreen(
          schoolId: 'MarthCheng13283',
          batchId: '2023-June-2024-February',
          classID: 'class1A@mthss'),
      CreateExamNameScreen(
          schooilID: 'MarthCheng13283',
          classID: 'class1A@mthss',
          teacherId: 'abinjohn8089@gmail.com',
          batchId: '2023-June-2024-February'),
      HomeWorkUpload(
        batchId: '2023-June-2024-February',
        classId: 'class1A@mthss',
        schoolID: 'MarthCheng13283',
        teacherID: 'abinjohn8089@gmail.com',
      ),
      StudentSubjectHome(
        batchId: '2023-June-2024-February',
        classId: 'class1A@mthss',
        schoolID: 'MarthCheng13283',
        teacherID: 'abinjohn8089@gmail.com',
      ),
      LeaveLettersListviewScreen(
          schooilID: 'MarthCheng13283',
          batchID: '2023-June-2024-February',
          classID: 'class1A@mthss')
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
    ));
  }
}

List<String> _acc_text = [
  'Take Attendance',
  'Attendance Book',
  'Exams',
  'TimeTable',
  'HomeWorks',
  'Notices',
  'Events',
  'Progress Report',
  'Sujects',
  'Teachers',
  'Meetings'
];
var _acc_images = [
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
  'assets/images/teachers.png',
];
