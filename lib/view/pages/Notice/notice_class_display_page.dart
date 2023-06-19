import 'package:dujo_kerala_application/model/notice_model/class_level_notice_model.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../widgets/fonts/google_poppins.dart';

class NoticeClassDisplayPage extends StatelessWidget {
  const NoticeClassDisplayPage(
      {super.key, required this.classLevelNoticeModel});
  final ClassLevelNoticeModel classLevelNoticeModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: adminePrimayColor,
          title: Text("Notices".tr),
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
                        padding: EdgeInsets.only(left: 17.h, right: 17.h),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.h),
                            color: Colors.blue[50],
                          ),
                          height: 650.h,
                          width: 360.w,
                          child: Padding(
                            padding: EdgeInsets.all(13.h),
                            child: ListView(
                              children: [
                                Center(
                                  child: GooglePoppinsWidgets(
                                      text: classLevelNoticeModel.heading,
                                      fontsize: 22.h),
                                ),
                                kHeight50,
                                GooglePoppinsWidgets(
                                  text: "Topic :",
                                  fontsize: 18.h,
                                  fontWeight: FontWeight.w200,
                                ),
                                GooglePoppinsWidgets(
                                  text: classLevelNoticeModel.topic,
                                  fontsize: 19.h,
                                ),
                                kHeight20,
                                GooglePoppinsWidgets(
                                  text: "Content :",
                                  fontsize: 18.h,
                                  fontWeight: FontWeight.w200,
                                ),
                                GooglePoppinsWidgets(
                                  text: classLevelNoticeModel.content,
                                  fontsize: 19.h,
                                ),
                                kHeight30,
                                GooglePoppinsWidgets(
                                  text: "Date : ",
                                  fontsize: 18.h,
                                  fontWeight: FontWeight.w200,
                                ),
                                GooglePoppinsWidgets(
                                  text: classLevelNoticeModel.date,
                                  fontsize: 19.h,
                                ),
                                kHeight30,
                                GooglePoppinsWidgets(
                                    text: "Signed by :",
                                    fontsize: 18.h,
                                    fontWeight: FontWeight.w200),
                                GooglePoppinsWidgets(
                                  text: classLevelNoticeModel.signedBy,
                                  fontsize: 19.h,
                                ),
                                kHeight30,
                                kHeight30,
                              ],
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
