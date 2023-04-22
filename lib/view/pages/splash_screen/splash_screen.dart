// ignore_for_file: must_be_immutable

import 'package:dujo_kerala_application/view/pages/login/dujo_login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../model/Text_hiden_Controller/password_field.dart';
import '../../fonts/fonts.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

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
  await Future.delayed(const Duration(seconds: 3));
  Get.to(const DujoLoginScren());
}
