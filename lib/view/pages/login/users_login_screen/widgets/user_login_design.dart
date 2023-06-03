import 'dart:developer';

import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:dujo_kerala_application/view/widgets/fonts/google_poppins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../widgets/container_image.dart';

class UserLoginDesgin extends StatelessWidget {
  const UserLoginDesgin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          kHeight20,
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: GooglePoppinsWidgets(
              fontsize: 28,
              fontWeight: FontWeight.w700,
              text: 'Welcome..'.tr,
            ),
          ),
          kHeight10,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 50.h),
            child: Container(
              child: GooglePoppinsWidgets(
                fontsize: 23,
                fontWeight: FontWeight.w500, 
                text: 'Select Who You Are ?'.tr,
              ),
              
            ),
          ),
          kHeight10,
          Center(
              child: ContainerImage(
                  height: 300,
                  width: double.infinity.w,
                  imagePath: 'assets/images/select_user (1).png'))
        ],
      ),
    );
  }
}
