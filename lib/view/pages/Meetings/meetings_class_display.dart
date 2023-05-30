import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/export.dart';

import '../../widgets/fonts/google_poppins.dart';

class MeetingDisplayClassLevel extends StatelessWidget {
  const MeetingDisplayClassLevel({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: adminePrimayColor,
          title:  Text("Meetings".tr),
        ),
        body: SizedBox(
          height: double.infinity, // set the height to fill available space
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                kHeight30,
                Expanded(
                  child: ListView(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.h),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.h),
                            color: Colors.blue[50],
                          ),
                          height: 650.h,
                          width: 360.w,
                          child: Padding(
                            padding: EdgeInsets.all(10.h),
                            child: Expanded(
                              child: ListView(
                                children: [
                                  Center(
                                    child: GooglePoppinsWidgets(
                                        text: "Heading", fontsize: 22.h),
                                  ),
                                  kHeight50,
                                  GooglePoppinsWidgets(
                                    text: "Category :",
                                    fontsize: 18.h,
                                    fontWeight: FontWeight.w200,
                                  ),
                                  GooglePoppinsWidgets(
                                    text: "Arts",
                                    fontsize: 19.h,
                                  ),
                                  kHeight20,
                                  GooglePoppinsWidgets(
                                    text: "Members to be expected : ",
                                    fontsize: 18.h,
                                    fontWeight: FontWeight.w200,
                                  ),
                                  GooglePoppinsWidgets(
                                    text: "Principal",
                                    fontsize: 19.h,
                                  ),
                                  kHeight30,
                                  GooglePoppinsWidgets(
                                    text: "Speacial Guest : ",
                                    fontsize: 18.h,
                                    fontWeight: FontWeight.w200,
                                  ),
                                  GooglePoppinsWidgets(
                                    text: "MLA",
                                    fontsize: 19.h,
                                  ),
                                  kHeight30,
                                  GooglePoppinsWidgets(
                                      text: "Date :",
                                      fontsize: 18.h,
                                      fontWeight: FontWeight.w200),
                                  GooglePoppinsWidgets(
                                    text: "00:00:00",
                                    fontsize: 19.h,
                                  ),
                                  kHeight30,
                                  GooglePoppinsWidgets(
                                      text: "Time :",
                                      fontsize: 18.h,
                                      fontWeight: FontWeight.w200),
                                  GooglePoppinsWidgets(
                                    text: "00:00",
                                    fontsize: 19.h,
                                  ),
                                  kHeight30,
                                  GooglePoppinsWidgets(
                                      text: "Venue :",
                                      fontsize: 18.h,
                                      fontWeight: FontWeight.w200),
                                  GooglePoppinsWidgets(
                                    text: "School Auditorium",
                                    fontsize: 19.h,
                                  ),
                                  kHeight30,
                                  kHeight30,
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
