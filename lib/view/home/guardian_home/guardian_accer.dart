// ignore_for_file: non_constant_identifier_names, no_leading_underscores_for_local_identifiers

import 'package:dujo_kerala_application/view/home/bus_route_page/all_bus_list.dart';
import 'package:dujo_kerala_application/view/home/events/event_list.dart';
import 'package:dujo_kerala_application/view/home/parent_home/leave_application/apply_leave_application.dart';
import 'package:dujo_kerala_application/view/pages/Meetings/Tabs/school_level_meetings_tab.dart';
import 'package:dujo_kerala_application/view/pages/teacher_list/teacher_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../controllers/userCredentials/user_credentials.dart';
import '../../../utils/utils.dart';
import '../../pages/Attentence/take_attentence/attendence_book_status_month.dart';
import '../../pages/Homework/view_home_work.dart';
import '../../pages/Notice/notice_list.dart';
import '../../pages/Subject/subject_display.dart';
import '../../pages/exam_results/for_users/select_examlevel_uses.dart';
import '../all_class_test_monthly_show/all_class_list_monthly_show.dart';
import '../all_class_test_show/all_class_list_show.dart';
import '../exam_Notification/users_exam_list_view/user_exam_acc.dart';
import '../student_home/time_table/ss.dart';

class GuardianAccessories extends StatelessWidget {
  String studentName;
  GuardianAccessories({
    required this.studentName,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenNavigation = [
      AttendenceBookScreenSelectMonth(
          schoolId: UserCredentialsController.schoolId!,
          batchId: UserCredentialsController.batchId!,
          classID: UserCredentialsController.classId!), //Attendence

      LeaveApplicationScreen(
          studentName: studentName,
          guardianName: UserCredentialsController.guardianModel!.guardianName,
          classID: UserCredentialsController.classId!,
          schoolId: UserCredentialsController.schoolId!,
          studentID: UserCredentialsController.guardianModel!.studentID,
          batchId: UserCredentialsController.batchId!), //Leave Letter

      NoticePage(), //Notice

      const ViewHomeWorks(), // Home Works

      const SS(), // Time Table

      SchoolLevelMeetingPage(), //Meetings

      const UserExmNotifications(),
      // Exams
      UsersSelectExamLevelScreen(
          classId: UserCredentialsController.classId!,
          studentID: UserCredentialsController
              .guardianModel!.studentID!), ////// exam result

      const EventList(), //Events

      // ProgressReportListViewScreen(
      //     schoolId: UserCredentialsController.schoolId!,
      //     classID: UserCredentialsController.classId!,
      //     studentId: UserCredentialsController.guardianModel!.studentID!,
      //     batchId: UserCredentialsController.batchId!), //Progress Report

      StudentSubjectHome(), //Subjects

      TeacherSubjectWiseList(navValue: ''), //Teachers

      BusRouteListPage(), /////// all bus
      AllClassTestPage(
        pageNameFrom: "guardian",
      ), //class test page
      AllClassTestMonthlyPage(
        pageNameFrom: "guardian",
      ),
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
                        Get.to(() => screenNavigation[index]);
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
                            top: _w / 30, left: _w / 30, right: _w / 30),
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
                              translateString(_acc_text[index]),
                              style: GoogleFonts.montserrat(
                                  color: Colors.black.withOpacity(0.5),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600),
                              textAlign: TextAlign.center,
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
  'Attendance'.tr,
  'Leave Letters'.tr,
  'Notices'.tr,
  'HomeWorks'.tr,
  'Time Table'.tr,
  'Meetings'.tr,
  'Exams'.tr,
  'Exam Results'.tr,
  'Events'.tr,
  // 'Progress Report'.tr,
  'Subjects'.tr,
  'Teachers'.tr,
  'Bus Route'.tr,
  'Class Test'.tr,
  'Monthly Class Test'.tr,
];
var _acc_images = [
  'assets/images/attendance.png',
  'assets/images/leaveapplica.png',
  'assets/images/notices.png',
  'assets/images/homework.png',
  'assets/images/library.png',
  'assets/images/meetings.png',
  'assets/images/exam.png',
  'assets/images/exmresult1.png',
  'assets/images/activity.png',
  // 'assets/images/progressreport.png',
  'assets/images/subjects.png',
  'assets/images/teachers.png',
  'assets/images/bus.png',
  'assets/images/examtest.png',
  'assets/images/test.png',
];
