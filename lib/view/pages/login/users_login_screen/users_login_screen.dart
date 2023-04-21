import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/pages/login/users_login_screen/guardian_login/guardian_login.dart';
import 'package:dujo_kerala_application/view/pages/login/users_login_screen/parent_login/parent_login.dart';
import 'package:dujo_kerala_application/view/pages/login/users_login_screen/student%20login/student_login.dart';
import 'package:dujo_kerala_application/view/pages/login/users_login_screen/teacher_login/teacher_login.dart';
import 'package:dujo_kerala_application/view/pages/login/users_login_screen/widgets/user_login_design.dart';
import 'package:dujo_kerala_application/view/widgets/container_image.dart';
import 'package:dujo_kerala_application/view/widgets/fonts/google_monstre.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

import '../../../../model/Text_hiden_Controller/password_field.dart';
import 'class_taecher_login/class_teacher_login.dart';

class UsersLoginScreen extends StatelessWidget {
  PasswordField hideGetxController = Get.put(PasswordField());

  UsersLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int columnCount = 2;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: cWhite,
      body: SafeArea(
          child: Column(
        children: [
          const UserLoginDesgin(),
          Expanded(
            child: AnimationLimiter(
              child: GridView.count(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                padding: EdgeInsets.all(w / 60),
                crossAxisCount: columnCount,
                children: List.generate(
                  4,
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
                              if (index == 0) {
                                Get.to(StudentLoginScreen());
                              } else if (index == 1) {
                                Get.to(StudentLoginScreen());
                              } else if (index == 2) {
                                Get.to(StudentLoginScreen());
                              } else if (index == 3) {
                                getWhichTeacher();
                              }
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  bottom: w / 10, left: w / 20, right: w / 20),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color:
                                        const Color.fromARGB(255, 27, 75, 235),
                                    width: 0.3),
                                color: const Color.fromARGB(251, 194, 213, 246)
                                    .withOpacity(0.4),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(16),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 40,
                                    spreadRadius: 10,
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ContainerImage(
                                      height: 60,
                                      width: 60,
                                      imagePath: icons[index]),
                                  GoogleMonstserratWidgets(
                                    text: userList[index],
                                    letterSpacing: 1,
                                    fontsize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ],
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
          ),
        ],
      )),
    );
  }

  List<String> userList = ['Student', 'Parent', 'Guardian', 'Teacher'];
}

var icons = [
  'assets/images/reading.png',
  'assets/images/family.png',
  'assets/images/guard.png',
  'assets/images/teacher.png',
];
getWhichTeacher() {
  Get.bottomSheet(Container(
    color: Colors.white,
    height: 200.h,
    width: 200.w,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () {
            Get.to(TeacherLoginScreen());
          },
          child: Container(
            color: const Color.fromARGB(255, 171, 198, 249),
            height: 80.h,
            width: 200.w,
            child: Center(
              child: GoogleMonstserratWidgets(
                text: 'Teacher',
                fontsize: 19,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
              Get.to(ClassTeacherLoginScreen());
          },
          child: Container(
            color: const Color.fromARGB(255, 171, 198, 249),
            height: 80.h,
            width: 200.w,
            child: Center(
              child: GoogleMonstserratWidgets(
                text: 'Class Teacher',
                fontsize: 19,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        )
      ],
    ),
  ));
}
