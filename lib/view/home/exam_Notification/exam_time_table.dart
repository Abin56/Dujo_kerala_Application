import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/home/exam_Notification/public_level.dart';
import 'package:dujo_kerala_application/view/home/exam_Notification/state_Level.dart';
import 'package:flutter/material.dart';

class ExmNotifications extends StatelessWidget {
  const ExmNotifications({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: adminePrimayColor,
          bottom: const TabBar(tabs: [
            Tab(
              text: 'Public Level',
            ),
            Tab(
              text: 'State Level',
            )
          ]),
        ),
        body: const SafeArea(
          child: TabBarView(
            children: [PublicLevel(), StateLevel()],
          ),
        ),
      ),
    );
  }
}

