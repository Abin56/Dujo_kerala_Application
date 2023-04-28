import 'package:dujo_kerala_application/sruthi/Event/event_display_school_levl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../view/constant/sizes/sizes.dart';
import '../../../view/widgets/fonts/google_poppins.dart';


class SchoolLevelPage extends StatelessWidget {
  const SchoolLevelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body:  Column(
                children: [
                  // Heading_Container_Widget(text: 'Event List',),
                  Expanded(
                    child: ListView.builder(
                        itemCount: 5,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              Container(
                                child: ListTile(
                                    leading: const Icon(Icons.event_sharp),
                                    trailing: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => EventDisplaySchoolLevel()));
                                      },
                                      child: GooglePoppinsWidgets(
                                        text: "View",
                                        fontsize: 16.h,
                                        color: Colors.green,
                                      ),
                                    ),
                                    title: GooglePoppinsWidgets(text: "Events", fontsize: 19.h),
                                    subtitle: GooglePoppinsWidgets(
                                        text: "Date : 00/00/00", fontsize: 14.h)),
                              ),
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