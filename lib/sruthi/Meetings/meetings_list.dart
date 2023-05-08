import 'package:dujo_kerala_application/sruthi/Meetings/Tabs/class_level_meeting_tab.dart';
import 'package:dujo_kerala_application/sruthi/Meetings/Tabs/school_level_meetings_tab.dart';
import 'package:flutter/material.dart';

import '../../view/colors/colors.dart';

class MeetingList extends StatelessWidget {
  const MeetingList({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Meeting List"),
          backgroundColor: adminePrimayColor,
          bottom: const TabBar(tabs: [
            Tab(
              text: 'Class Level',
            ),
            Tab(
              text: 'School Level',
            )
          ]),
        ),
        body: SafeArea(
          child: TabBarView(
            children: [const ClassLevelMeetingPage(), SchoolLevelMeetingPage(),],
          ),
        ),
      ),
    );
  }
}
