
import 'package:dujo_kerala_application/view/home/exam_Notification/list_of_exam/list_of_exam.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AddTimeTable extends StatelessWidget {
  const AddTimeTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                Get.to(const ViewSchoolExamScreen());
              },
              child: SizedBox(
                height: 50.h,
                width: 130.w,
                child: const Text('Upload Time tabel'),
              ),
            ),
            SizedBox(
              height: 50.h,
              width: 130.w,
              child: const Text('View Time Table'),
            ),
          ],
        ),
      )),
    );
  }
}
