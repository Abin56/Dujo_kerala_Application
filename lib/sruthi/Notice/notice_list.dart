import 'package:dujo_kerala_application/sruthi/Event/Tabs/school_level_tab.dart';
import 'package:dujo_kerala_application/sruthi/Notice/Tabs/class_level_tab.dart';
import 'package:dujo_kerala_application/sruthi/Notice/Tabs/school_level_tab.dart';
import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:dujo_kerala_application/widgets/Iconbackbutton.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../view/colors/colors.dart';
import '../../view/widgets/fonts/google_poppins.dart';


class NoticePage extends StatelessWidget {
  const NoticePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
           appBar: AppBar(
            title: Row(
              children: [
                IconButtonBackWidget(),
                Text("Notice List"),
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
            body: SafeArea(
          child: TabBarView(
            children: [ClassLevelNoticePage(), SchoolLevelNoticePage()],
          ),
      ),
       )) );
  }
}
