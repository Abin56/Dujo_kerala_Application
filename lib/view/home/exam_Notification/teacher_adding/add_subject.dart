import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:dujo_kerala_application/view/home/exam_Notification/list_of_exam/list_of_exam.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../widgets/fonts/google_poppins.dart';
import '../exam_time_table.dart';

class AddTimeTable extends StatelessWidget {
  const AddTimeTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: adminePrimayColor,
        title: Text('Exam Time Table'.tr),
      ),
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Get.to(const ViewSchoolExamScreen());
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: adminePrimayColor),
                child: SizedBox(
                    height: 80.h,
                    width: 250.w,
                    child: Center(
                      child: GooglePoppinsWidgets(
                        text: 'Upload Time Table'.tr,
                        fontsize: 15.w,
                        color: cWhite,
                      ),
                    )),
              ),
            ),
            kHeight30,
            GestureDetector(
              onTap: () {
                Get.to(() => const ExmNotifications());
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: adminePrimayColor),
                child: SizedBox(
                    height: 80.h,
                    width: 250.w,
                    child: Center(
                      child: GooglePoppinsWidgets(
                        text: 'View Time Table'.tr,
                        fontsize: 15.w,
                        color: cWhite,
                      ),
                    )),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
