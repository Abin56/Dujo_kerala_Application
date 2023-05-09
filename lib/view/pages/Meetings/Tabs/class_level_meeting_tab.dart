import 'package:dujo_kerala_application/view/pages/Meetings/meetings_class_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constant/sizes/sizes.dart';
import '../../../widgets/fonts/google_poppins.dart';

class ClassLevelMeetingPage extends StatelessWidget {
  const ClassLevelMeetingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Heading_Container_Widget(text: 'Event List',),
          Expanded(
            child: ListView.builder(
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ListTile(
                          leading: const Icon(Icons.message_outlined),
                          trailing: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const MeetingDisplayClassLevel()));
                            },
                            child: GooglePoppinsWidgets(
                              text: "View",
                              fontsize: 16.h,
                              color: Colors.blue,
                            ),
                          ),
                          title: Padding(
                            padding: EdgeInsets.only(top: 10.h),
                            child: GooglePoppinsWidgets(
                                text: "Meeting", fontsize: 19.h),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 10.h),
                                child: GooglePoppinsWidgets(
                                    text: "Date : 00/00/00", fontsize: 14.h),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 10.h),
                                child: GooglePoppinsWidgets(
                                    text: "Time : 00:00", fontsize: 14.h),
                              ),
                            ],
                          )),
                      const Divider(),
                      kHeight10
                    ],
                  );
                }),
          ),
        ],
      ),
    );
  }
}
