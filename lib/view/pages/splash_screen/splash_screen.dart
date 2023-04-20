import 'package:dujo_kerala_application/view/pages/login/dujo_login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../fonts/fonts.dart';
import '../login/student login/student_login.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    nextpage();
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              height: 200.h,
              width: 200.w,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/leptonlogo.png'))),
            ),
          ),
          Text(
            "Lepton DuJo",
            style: DGoogleFonts.headTextStyleMont,
          )
        ],
      )),
    );
  }
}

nextpage() async {
  await Future.delayed(const Duration(seconds: 3))
      .then((value) => Get.to(const StudentLogin()));
}
