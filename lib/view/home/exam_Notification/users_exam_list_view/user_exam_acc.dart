import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/home/exam_Notification/users_exam_list_view/public.dart';
import 'package:dujo_kerala_application/view/home/exam_Notification/users_exam_list_view/state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserExmNotifications extends StatelessWidget {
  const UserExmNotifications({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(title: Text("Exams".tr),
          backgroundColor: adminePrimayColor,
          bottom:  const TabBar(tabs: [
            Tab(
              text: 'State Level',
            ),
            Tab(
              text: 'School Level',
            )
          ]),
        ),
        body:  const SafeArea(
          child: TabBarView(
            children: [UserStateLevel(),UserPublicLevel()],
          ),
        ),
      ),
    );
  }
}

