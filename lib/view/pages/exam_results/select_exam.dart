import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:dujo_kerala_application/view/pages/exam_results/examListview.dart';
import 'package:dujo_kerala_application/view/pages/exam_results/upload_exam_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/fonts/google_monstre.dart';

class SelectExamLevelScreen extends StatelessWidget {
  String classId;
  SelectExamLevelScreen({super.key, required this.classId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton.icon(
              onPressed: () async {
                return getBottomSheet(classId, 'State Level');
              },
              icon: const Icon(Icons.list_alt),
              label: const Text("School Level")),
          kHeight30,
          TextButton.icon(
              onPressed: () async {
                return getBottomSheet(classId, 'Public Level');
              },
              icon: const Icon(Icons.list_alt),
              label: const Text("Public Level"))
        ],
      )),
    );
  }
}

getBottomSheet(String classId, String examlevel) {
  Get.bottomSheet(
      SizedBox(
        height: 200,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                Get.to(ExamResultsView(
                  classID: classId,
                  examlevel: examlevel,
                ));
              },
              child: GoogleMonstserratWidgets(
                text: 'Upload',
                fontsize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.to(SelectExamWiseScreen(
                  classID: classId,
                  examLevel: examlevel,
                ));
              },
              child: GoogleMonstserratWidgets(
                text: 'View',
                fontsize: 16,
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
      ),
      backgroundColor: cWhite);
}
