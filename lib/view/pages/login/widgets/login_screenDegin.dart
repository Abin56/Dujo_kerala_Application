// ignore_for_file: file_names

import 'package:dujo_kerala_application/view/widgets/container_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreenDesign extends StatelessWidget {
  const LoginScreenDesign({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 250,
          width: 250,
          decoration: const BoxDecoration(
            
            image: DecorationImage(
              
              image: AssetImage('assets/images/cost.png'),
            ),
          ),
        ),
        ContainerImage(
            height: 60.h,
            width: 200.w,
            imagePath: 'assets/images/dujo top login.png'),
        ContainerImage(
            height: 180.h,
            width: double.infinity.w,
            imagePath: 'assets/images/leptondujobg.png'),
      ],
    );
  }
}
