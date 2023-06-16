import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../../model/meeting_model/meeting_model.dart';
import '../../widgets/fonts/google_poppins.dart';

class MeetingDisplaySchoolLevel extends StatelessWidget {
  const MeetingDisplaySchoolLevel({super.key, required this.meetingModel});
  final MeetingModel meetingModel;

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
                        padding: EdgeInsets.all(15.h),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.h),
                            color: Colors.blue[50],
                          ),
                          height: 650.h,
                          width: 360.w,
                          child: Padding(
                            padding: EdgeInsets.all(17.h),
                            child: ListView(
                              children: [
                                Center(
                                  child: GooglePoppinsWidgets(
                                      text: meetingModel.heading,
                                      fontsize: 22.h),
                                ),
                                kHeight50,
                                GooglePoppinsWidgets(
                                  text: "Category :",
                                  fontsize: 18.h,
                                  fontWeight: FontWeight.w200,
                                ),
                                GooglePoppinsWidgets(
                                  text: meetingModel.categoryOfMeeting,
                                  fontsize: 19.h,
                                ),
                                kHeight20,
                                GooglePoppinsWidgets(
                                  text: "Members to be expected : ",
                                  fontsize: 18.h,
                                  fontWeight: FontWeight.w200,
                                ),
                                GooglePoppinsWidgets(
                                  text: meetingModel.membersToBeExpected,
                                  fontsize: 19.h,
                                ),
                                kHeight30,
                                GooglePoppinsWidgets(
                                  text: "Special guest : ",
                                  fontsize: 18.h,
                                  fontWeight: FontWeight.w200,
                                ),
                                GooglePoppinsWidgets(
                                  text: meetingModel.specialGuest,
                                  fontsize: 19.h,
                                ),
                                kHeight30,
                                GooglePoppinsWidgets(
                                    text: "Date :",
                                    fontsize: 18.h,
                                    fontWeight: FontWeight.w200),
                                GooglePoppinsWidgets(
                                  text: meetingModel.date,
                                  fontsize: 19.h,
                                ),
                                kHeight30,
                                GooglePoppinsWidgets(
                                    text: "Time :",
                                    fontsize: 18.h,
                                    fontWeight: FontWeight.w200),
                                GooglePoppinsWidgets(
                                  text: meetingModel.time,
                                  fontsize: 19.h,
                                ),
                                kHeight30,
                                GooglePoppinsWidgets(
                                    text: "Venue :",
                                    fontsize: 18.h,
                                    fontWeight: FontWeight.w200),
                                GooglePoppinsWidgets(
                                  text: meetingModel.venue,
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
