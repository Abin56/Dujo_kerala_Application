import 'package:dujo_kerala_application/controllers/parent_controller/parent_notice_controller/parent_notice_controller.dart';
import 'package:dujo_kerala_application/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../colors/colors.dart';
import 'parent_class_level_notice.dart';
import 'parent_school_level_notice.dart';

class ParentNoticePage extends StatelessWidget {
  ParentNoticePage({super.key});
  final ParentNoticeController parentNoticeController =
      Get.put(ParentNoticeController());

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await parentNoticeController.getSchoolLevelNotices();
      await parentNoticeController.getClassLevelNotices();
    });
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
          body: parentNoticeController.isLoading.value
              ? circularProgressIndicatotWidget
              : SafeArea(
                  child: TabBarView(
                    children: [
                      ParentClassLevelNoticePage(),
                      ParentSchoolLevelNoticePage(),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
