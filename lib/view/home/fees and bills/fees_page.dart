import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/widgets/fonts/google_monstre.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/get_utils.dart';

import 'fees_class_level.dart';
import 'fees_school_level.dart';

class FeesPage extends StatelessWidget {
  const FeesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: adminePrimayColor,
          title: GoogleMonstserratWidgets(
              text: 'Fees List'.tr, fontsize: 18.w, fontWeight: FontWeight.w700),
          bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: Colors.white,
            tabs: [
              Tab(
                child: Padding(
                  padding: EdgeInsets.all(8.0.w),
                  child: GoogleMonstserratWidgets(
                    text: 'School Level'.tr,
                    fontsize: 15.w,
                  ),
                ),
              ),
              Tab(
                child: Padding(
                  padding: EdgeInsets.all(8.0.w),
                  child: GoogleMonstserratWidgets(
                    text: 'Class Level'.tr,
                    fontsize: 15.w,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            children: [
              SchoolLevelFees(),
              ClassLevelFees(),
            ],
          ),
        ),
      ),
    );
  }
}
