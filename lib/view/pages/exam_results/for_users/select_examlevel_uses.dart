import 'package:dujo_kerala_application/view/pages/exam_results/for_users/select_exam_users.dart';
import 'package:flutter/material.dart';
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
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton.icon(
              onPressed: () async {
                Get.to(UsersSelectExamWiseScreen(
                  classID: classId,
                  examLevel: 'State Level',
                  studentId: studentID,
                ));
              },
              icon: const Icon(Icons.list_alt),
              label: const Text("School Level")),
          kHeight30,
          TextButton.icon(
              onPressed: () async {
                      Get.to(UsersSelectExamWiseScreen(
                  classID: classId,
                  examLevel: 'Public Level',
                  studentId: studentID,
                ));
              },
              icon: const Icon(Icons.list_alt),
              label: const Text("Public Level"))
        ],
      )),
    );
  }
}
