import 'package:dujo_kerala_application/sruthi/Meetings/meetings_school_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../view/constant/sizes/sizes.dart';
import '../../../view/widgets/fonts/google_poppins.dart';
import '../../Event/event_display_class_level.dart';



class SchoolLevelMeetingPage extends StatelessWidget {
  const SchoolLevelMeetingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
     body: Column(
                children: [
                  // Heading_Container_Widget(text: 'Event List',),
                  Expanded(
                    child: ListView.builder(
                        itemCount: 5,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                child: ListTile(
                                    leading: const Icon(Icons.message_outlined),
                                    trailing: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => MeetingDisplaySchoolLevel()));
                                      },
                                      child: GooglePoppinsWidgets(
                                        text: "View",
                                        fontsize: 16.h,
                                        color: Colors.blue,
                                      ),
                                    ),
                                    title: Padding(
                                      padding:  EdgeInsets.only(top: 10.h),
                                      child: GooglePoppinsWidgets(text: "Meeting", fontsize: 19.h),
                                    ),
                                    subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:  EdgeInsets.only(top:10.h),
                                          child: GooglePoppinsWidgets(
                                              text: "Date : 00/00/00", fontsize: 14.h),
                                        ),
                                             Padding(
                                               padding:  EdgeInsets.only(top: 10.h),
                                               child: GooglePoppinsWidgets(
                                                                                         text: "Time : 00:00", fontsize: 14.h),
                                             ),
                                      ],
                                    )),
                              ),
                         Divider(),kHeight10
                            ],
                          );
                        }),
                  ),
                ],
              ),
    );
  }
}