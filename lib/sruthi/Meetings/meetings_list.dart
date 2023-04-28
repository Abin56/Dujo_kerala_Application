import 'package:dujo_kerala_application/sruthi/Meetings/Tabs/class_level_meeting_tab.dart';
import 'package:dujo_kerala_application/sruthi/Meetings/Tabs/school_level_meetings_tab.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../view/constant/sizes/sizes.dart';
import '../../../view/widgets/fonts/google_poppins.dart';
import '../../view/colors/colors.dart';
import '../Event/Tabs/class_level_tab.dart';
import '../Event/Tabs/school_level_tab.dart';



class MeetingList extends StatelessWidget {
  const MeetingList({super.key});

  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Text("Meeting List"),
            ],
          ),
          backgroundColor: adminePrimayColor,
          bottom: TabBar(tabs: [
            Tab(
              text: 'Class Level',
            ),
            Tab(
              text: 'School Level',
            )
          ]),
        ),

        //  appBar: AppBar(backgroundColor: adminePrimayColor),
        body: SafeArea(
          child: TabBarView(
            children: [ClassLevelMeetingPage(), SchoolLevelMeetingPage()],
          ),
        ),
      ),
    );
  }
}