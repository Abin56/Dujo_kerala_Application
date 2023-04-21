import 'package:dujo_kerala_application/abin/forgot%20password/forgot_password.dart';
import 'package:dujo_kerala_application/abin/forgot%20password/reset_password.dart';
import 'package:dujo_kerala_application/abin/user_login_verification.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';

import 'package:dujo_kerala_application/view/pages/login/users_login_screen/student%20login/student_login.dart';
import 'package:dujo_kerala_application/view/pages/login/users_login_screen/widgets/user_login_design.dart';
import 'package:dujo_kerala_application/view/widgets/container_image.dart';
import 'package:dujo_kerala_application/view/widgets/fonts/google_monstre.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';


class UsersLoginScreen extends StatelessWidget {
  const UsersLoginScreen({super.key});

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
                            onTap: () {
                              // print("object");
                              Get.to(navigationScreens[index]);
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
}


getWhichTeacher() {
  return Get.bottomSheet(Container(
    color: Colors.white,
    height: 200.h,
    child: Row(
      children: [
        SizedBox(
          height: 100.h,
          child: Center(
            child: GoogleMonstserratWidgets(
              text: 'Teacher',
              letterSpacing: 1,
              fontsize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(
          height: 100.h,
          width: double.infinity.w,
          child: Center(
            child: GoogleMonstserratWidgets(
              text: 'Class Teacher',
              letterSpacing: 1,
              fontsize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        )
      ],
    ),
  ));
}

List<String> userList = ['Student', 'Parent', 'Guardian', 'Teacher'];

var navigationScreens = [
  StudentLogin(),
  ForgotPassword(),
  ResetPassword (),
  LoginVerification(),
];
var icons = [
  'assets/images/reading.png',
  'assets/images/family.png',
  'assets/images/guard.png',
  'assets/images/teacher.png',
];
