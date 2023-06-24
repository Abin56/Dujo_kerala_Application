// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../model/bus_route_model/bus_route_model.dart';
import '../../colors/colors.dart';
import '../../constant/sizes/sizes.dart';
import '../../widgets/fonts/google_poppins.dart';

class BusRouteDetailPage extends StatelessWidget {
  const BusRouteDetailPage({super.key, required this.busRouteModel});

  final BusRouteModel busRouteModel;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: adminePrimayColor,
            title: GooglePoppinsWidgets(text: 'View bus status'.tr,
           fontsize: 18.w)),
            body: Center(
      child: ListView(children: [
        Card(
          child: ListTile(
            leading: kHeight,
            subtitle: GooglePoppinsWidgets(
                text: busRouteModel.routeNumber, fontsize: 19.h),
            title: GooglePoppinsWidgets(text: "Route No.", fontsize: 12.h),
          ),
        ),
        kHeight10,
        Card(
          child: ListTile(
            leading: kHeight,
            subtitle: GooglePoppinsWidgets(
                text: busRouteModel.busNumber, fontsize: 19.h),
            title: GooglePoppinsWidgets(text: "Bus No.", fontsize: 12.h),
          ),
        ),
        kHeight10,
        BusRouteDetailPageListileWidget(
          leading: kHeight,
          title1: GooglePoppinsWidgets(
              text: busRouteModel.driveMobNum, fontsize: 15.h),
          title: GooglePoppinsWidgets(
              text: busRouteModel.staffInCharge, fontsize: 19.h),
          title2: GooglePoppinsWidgets(
              text: busRouteModel.staffInCharge, fontsize: 12.h),
        ),
        kHeight10,
        // BusRouteDetailPageListileWidget(
        //   leading: kHeight,
        //   title1: GooglePoppinsWidgets(text: "00000000000", fontsize: 15.h),
        //   title: GooglePoppinsWidgets(text: "Navas", fontsize: 19.h),
        //   title2: GooglePoppinsWidgets(text: "Incharge", fontsize: 12.h),
        // ),
        // kHeight10,
        // BusRouteDetailPageListileWidget(
        //   leading: kHeight,
        //   title1: GooglePoppinsWidgets(text: "8785691236", fontsize: 15.h),
        //   title: GooglePoppinsWidgets(text: "Venu", fontsize: 19.h),
        //   title2: GooglePoppinsWidgets(text: "Assistant", fontsize: 12.h),
        // ),
        // kHeight20,
        Center(
          child: Container(
            height: 65.h,
            width: 220.w,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.elliptical(20, 20)),
                color: adminePrimayColor),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                kHeight,
                Text(
                  "View bus status".tr,
                  style: TextStyle(color: cWhite, fontSize: 20.h),
                ),
              ],
            ),
          ),
        ),
      ]),
    )));
  }
}

class BusRouteDetailPageListileWidget extends StatelessWidget {
  const BusRouteDetailPageListileWidget({
    super.key,
    required this.leading,
    required this.title,
    required this.title1,
    required this.title2,
    this.onTap,
  });
  final Widget title1;
  final Widget title;

  final Widget leading;
  final Widget title2;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(left: 10.w,right: 10.w,top: 20.w),
      child: Card(
        child: ListTile(
          onTap: onTap,
          
          leading: leading,
          title: title,
          
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              kHeight20,
              title1,
              kHeight20,
              title2,
            ],
          ),
        ),
      ),
    );
  }
}
