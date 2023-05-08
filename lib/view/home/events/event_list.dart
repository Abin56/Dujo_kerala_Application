import 'package:dujo_kerala_application/sruthi/Event/Tabs/school_level_tab.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:dujo_kerala_application/widgets/Iconbackbutton.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'Tabs/class_level_tab.dart';

class EventList extends StatelessWidget {
  EventList({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              IconButtonBackWidget(),
              SizedBox(
                width: 20.w,
              ),
              const Text("Event List"),
            ],
          ),
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

        //  appBar: AppBar(backgroundColor: adminePrimayColor),
        body: SafeArea(
          child: TabBarView(
            children: [ ClassLevelPage(), SchoolLevelPage()],
          ),
        ),
      ),
    );
  }
}
