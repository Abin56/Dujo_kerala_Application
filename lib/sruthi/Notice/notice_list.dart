import 'package:dujo_kerala_application/sruthi/Notice/Tabs/class_level_tab.dart';
import 'package:dujo_kerala_application/sruthi/Notice/Tabs/school_level_tab.dart';
import 'package:flutter/material.dart';

import '../../view/colors/colors.dart';

class NoticePage extends StatelessWidget {
  const NoticePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Notice List"),
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
              children: [
                 ClassLevelNoticePage(),
                SchoolLevelNoticePage(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
