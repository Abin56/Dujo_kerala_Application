import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:dujo_kerala_application/view/home/student_home/time_table/time_table_display.dart';
import 'package:dujo_kerala_application/view/pages/Meetings/Tabs/school_level_meetings_tab.dart';
import 'package:dujo_kerala_application/view/pages/Notice/Tabs/school_level_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../colors/colors.dart';
import '../../pages/Attentence/take_attentence/attendence_book_status.dart';
import '../../pages/Attentence/take_attentence_subject_listView.dart';
import '../../pages/Homework/view_home_work.dart';
import '../../pages/Subject/teacher_display_subjects.dart';
import '../../pages/progress_Report/view_report/view_exam_list.dart';
import '../events/Tabs/school_level_tab.dart';
import '../exam_Notification/users_exam_list_view/user_exam_acc.dart';

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
            const UserExmNotifications(),  //Exam
      const StudentShowTimeTable(), //Time Table
      Scaffold(
        appBar: AppBar(
          backgroundColor: adminePrimayColor,
          title:  Text("Notices".tr),
        ),
        body: SchoolLevelNoticePage(),
      ),
      // Notice
      TeacherSubjectHome(),
      Scaffold(
        appBar: AppBar(
          backgroundColor: adminePrimayColor,
          title:  Text("Events".tr),
        ),
        body: const SchoolLevelPage(),
      ),
      // Events
      SchoolLevelMeetingPage(), // Meetings
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

      const UserExmNotifications(), //Exam
      const StudentShowTimeTable(), //TimeTable
      const ViewHomeWorks(), //Home Works

      Scaffold(
        appBar: AppBar(
          backgroundColor: adminePrimayColor,
          title: const Text("Notices"),
        ),
        body: SchoolLevelNoticePage(),
      ),
      // Notice

      Scaffold(
        appBar: AppBar(
          backgroundColor: adminePrimayColor,
          title: const Text("Events"),
        ),
        body: const SchoolLevelPage(),
      ),
      // Events
      ViewExamsForProgressreport(
          batchId: UserCredentialsController.batchId!,
          classID: classID,
          schooilID:
              UserCredentialsController.schoolId!), //Progress Report view
       TeacherSubjectHome(), // Subjects
      SchoolLevelMeetingPage(),
      // Meetings
    ];
    int columnCount = 2;
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
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
                                'You have no access in this class'.tr,
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
                              padding: EdgeInsets.all(w / 60),
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
                                              height: h / 100,
                                              width: double.infinity,
                                              margin: EdgeInsets.only(
                                                  bottom: w / 10,
                                                  left: w / 50,
                                                  right: w / 50),
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
                        padding: EdgeInsets.all(w / 60),
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
                                          color: Colors.white.withOpacity(0.5),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(30)),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.1),
                                              blurRadius: 40,
                                              spreadRadius: 10,
                                            ),
                                          ],
                                        ),
                                        height: h / 100,
                                        width: double.infinity,
                                        margin: EdgeInsets.only(
                                            bottom: w / 10,
                                            left: w / 50,
                                            right: w / 50),
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
  'Attendence Book'.tr,
  'Exams'.tr,
  'TimeTable'.tr,
  'Notices'.tr,
  'Subjects'.tr,
  'Events'.tr,
  'Meetings'.tr,
];
var _acc_images = [
  'assets/images/classroom.png',
  'assets/images/exam.png',
  'assets/images/library.png',
  'assets/images/notices.png',
  'assets/images/subjects.png',
  'assets/images/activity.png',
  'assets/images/meetings.png',
];
var hasDataImages = [
  'assets/images/attendance.png',
  'assets/images/classroom.png',
  'assets/images/exam.png',
  'assets/images/library.png',
  'assets/images/homework.png',
  'assets/images/notices.png',
  'assets/images/activity.png',
  'assets/images/progressreport.png',
  'assets/images/subjects.png',
  'assets/images/meetings.png',
];
List<String> hasDataText = [
  'Take Attendance'.tr,
  'Attendence Book'.tr,
  'Exams'.tr,
  'TimeTable'.tr,
  'HomeWorks'.tr,
  'Notices'.tr,
  'Events'.tr,
  'Progress Report'.tr,
  'Subjects'.tr,
  'Meetings'.tr,
];
