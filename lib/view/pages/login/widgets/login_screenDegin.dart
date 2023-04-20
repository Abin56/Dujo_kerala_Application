// ignore_for_file: file_names

import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:dujo_kerala_application/view/fonts/fonts.dart';
import 'package:dujo_kerala_application/view/widgets/container_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreenDesign extends StatelessWidget {
  const LoginScreenDesign({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500.h,
      width: double.infinity.w,
      child: Column(
        children: [
          Center(
            child: ContainerImage(
                height: 100.h,
                width: 200.w,
                imagePath: 'assets/images/leptonlogo.png'),
          ),
          kHeight10,
          Text(
            "Lepton DuJo",
            style: DGoogleFonts.headTextStyleMont,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ContainerImage(
                height: 80.h,
                width: 200.w,
                imagePath: 'assets/images/dujo top login.png'),
          ),
          ContainerImage(
              height: 200.h,
              width: double.infinity.w,
              imagePath: 'assets/images/leptondujobg.png'),
        ],
      ),
    );
  }
}