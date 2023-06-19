import 'package:dujo_kerala_application/view/pages/exam_notification/view_exams.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

class ExamNotification extends StatelessWidget {
  const ExamNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: ()async {
              
              Get.to(()=>ViewExamsScreen());
            },
            child: Text('View'))
        ],
      ),
    );
  }
}