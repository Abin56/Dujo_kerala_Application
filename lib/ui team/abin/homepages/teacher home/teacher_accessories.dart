// ignore_for_file: must_be_immutable, prefer_const_constructors_in_immutables, no_leading_underscores_for_local_identifiers, non_constant_identifier_names

import 'package:dujo_kerala_application/ui%20team/abin/homepages/parent%20home/parent_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class TeacherAccessories extends StatefulWidget {
  // var schoolId;
  // var teacherEmail;
  // var classID;
  // var teacherSubject;
  TeacherAccessories({
    // required this.schoolId,
    // required this.teacherEmail,
    // required this.classID,
    // required this.teacherSubject,
    super.key,
  });

  @override
  State<TeacherAccessories> createState() => _TeacherAccessoriesState();
}

class _TeacherAccessoriesState extends State<TeacherAccessories> {
  void retrieveTimeTableData() async {}

  @override
  void initState() {
    super.initState();
    retrieveTimeTableData();
  }

  @override
  Widget build(BuildContext context) {
    final screenNavigation = [
      ParentHomePage(),
      ParentHomePage(),
      ParentHomePage(),
      ParentHomePage(),
      ParentHomePage(),
      ParentHomePage(),
      ParentHomePage(),
      ParentHomePage(),
      ParentHomePage(),
      ParentHomePage(),
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
          10,
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
  'Application List',
  'Meetings'
];
var _acc_images = [
  'assets/images/attendance.png',
  'assets/images/classroom.png',
  'assets/images/exam.png',
  'assets/images/library.png',
  'assets/images/homework.png',
  'assets/images/notice.jpg',
  'assets/images/events.png',
  'assets/images/splash.png',
  'assets/images/leave_apply.png',
  'assets/images/message.png',
];
