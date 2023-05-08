import 'package:dujo_kerala_application/sruthi/Exam%20Notification/Teacher_Upload/exm_teacher_upload.dart';
import 'package:dujo_kerala_application/sruthi/Meetings/meetings_list.dart';
import 'package:dujo_kerala_application/sruthi/Notice/notice_list.dart';

import 'package:dujo_kerala_application/sruthi/Study%20Materials/study_materials_list.dart';
import 'package:dujo_kerala_application/sruthi/homeWork/student_homework_list.dart';


import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../sruthi/Subject 2/subject_display.dart';

class TestingPage extends StatelessWidget {
  const TestingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Student View')),
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
                              builder: ((context) => SubjectList())));
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => StudyMaterials())));
                    },
                    child:
                        Containerwidget(text: 'study material view Student')),
                kWidth30,
                InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => ExmNotification())));
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
                    child:
                        Containerwidget(text: 'Notice view Student')),
                kWidth30,
                InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => MeetingList())));
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
        style: TextStyle(fontSize: 20),
      )),
    );
  }
}
