import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/pages/exam_results/for_users/select_exam_users.dart';
import 'package:dujo_kerala_application/view/widgets/fonts/google_poppins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../constant/sizes/sizes.dart';

class UsersSelectExamLevelScreen extends StatelessWidget {
  String classId;
  String studentID;
  UsersSelectExamLevelScreen(
      {super.key, required this.classId, required this.studentID});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Exam Results".tr),backgroundColor: adminePrimayColor,),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(width:250.w,
              height: 100.h,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: adminePrimayColor),
                child: TextButton.icon(
                    onPressed: () async {
                      Get.to(()=>UsersSelectExamWiseScreen(
                        classID: classId,
                        examLevel: 'School Level',
                        studentId: studentID,
                      ));
                    },
                    icon:  const Icon(Icons.receipt,color: cWhite,),
                    label: GooglePoppinsWidgets(fontsize: 20.h, text:'School Level'.tr,color: Colors.white)
                    ),
              ),
            ],
          ),
          kHeight30,
          Container(
            width:250.w,
              height: 100.h,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: adminePrimayColor),

            child: TextButton.icon(
                onPressed: () async {
                        Get.to(()=>UsersSelectExamWiseScreen(
                    classID: classId,
                    examLevel: 'Public Level',
                    studentId: studentID,
                  ));
                },
                icon: const Icon(Icons.receipt,color: cWhite,),
                label: GooglePoppinsWidgets(fontsize: 20.h, text:'Public Level'.tr,color: Colors.white)),
          )
        ],
      )),
    );
  }
}