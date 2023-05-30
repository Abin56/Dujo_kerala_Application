import 'package:dujo_kerala_application/sruthi/Study%20Materials/study_materials_list.dart';
import 'package:dujo_kerala_application/sruthi/homeWork/student_homework_list.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:dujo_kerala_application/view/pages/Meetings/meetings_list.dart';
import 'package:dujo_kerala_application/view/pages/Notice/notice_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../sruthi/Subject 2/subject_display.dart';
import '../view/pages/exams/exam_display.dart';

class TestingPage extends StatelessWidget {
  const TestingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Student View')),
      body: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            kHeight50,
            Container(
              height: 250,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => const SubjectList())));
                    },
                    child: Containerwidget(text: 'Subject Student View')),
                kWidth30,
                InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => HomeWorkList())));
                    },
                    child: Containerwidget(text: 'Homework View Student')),
              ],
            ),
            kHeight20,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: ((context) => const StudyMaterials())));
                    },
                    child:
                        Containerwidget(text: 'study material view Student')),
                kWidth30,
                InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => const ExmNotification())));
                    },
                    child: Containerwidget(text: 'Exm Noti student')),
              ],
            ),
            kHeight20,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => NoticePage())));
                    },
                    child: Containerwidget(text: 'Notice view Student')),
                kWidth30,
                InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => const MeetingList())));
                    },
                    child: Containerwidget(text: 'Meeting View student')),
              ],
            ),
          ]),
    );
  }
}

class Containerwidget extends StatelessWidget {
  Containerwidget({
    required this.text,
    super.key,
  });
  String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.h,
      width: 200.w,
      color: ccblue,
      child: Center(
          child: Text(
        text,
        style: const TextStyle(fontSize: 20),
      )),
    );
  }
}
