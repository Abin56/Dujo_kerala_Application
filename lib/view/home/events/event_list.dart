import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import 'Tabs/class_level_tab.dart';
import 'Tabs/school_level_tab.dart';

class EventList extends StatelessWidget {
  const EventList({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              // IconButtonBackWidget(),
              SizedBox(
                width: 20.w,
              ),
               Text("Events".tr),
            ],
          ),
          backgroundColor: adminePrimayColor,
          bottom: TabBar(tabs: [
            Tab(
              text: 'Class Level'.tr,
            ),
            Tab(
              text: 'School Level'.tr,
            )
          ]),
        ),

        //  appBar: AppBar(backgroundColor: adminePrimayColor),
        body: const SafeArea(
          child: TabBarView(
            children: [ ClassLevelPage(), SchoolLevelPage()],
          ),
        ),
      ),
    );
  }
}
