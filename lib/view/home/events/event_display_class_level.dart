import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:google_fonts/google_fonts.dart';

import 'event_display_school_level.dart';

class EventDisplayClassLevel extends StatelessWidget {
  const EventDisplayClassLevel(
      {super.key,
      required this.signedBy,
      required this.description,
      required this.eventDate,
      required this.eventName,
      required this.venue});

  final String eventName;
  final String eventDate;
  final String description;
  final String venue;
  final String signedBy;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: adminePrimayColor,
          title:  Text("Events".tr),
        ),
        body: SizedBox(
          height: double.infinity, // set the height to fill available space
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              kHeight30,
              Expanded(
                child: ListView(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(17.h),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.h),
                          color: Colors.blue[50],
                        ),
                        height: 650.h,
                        width: 360.w,
                        child: Padding(
                          padding: EdgeInsets.all(15.h),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GooglePoppinseventClassLevelWidgets(
                                      text: eventName, fontsize: 22.h),
                                  const Icon(Icons.event_note)
                                ],
                              ),
                              kHeight50,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: GooglePoppinseventClassLevelWidgets(
                                      text: "Description : ",
                                      fontsize: 18.h,
                                      fontWeight: FontWeight.w200,
                                    ),
                                  )
                                ],
                              ),
                              kHeight20,
                              Flexible(
                                child: GooglePoppinsEventsWidgets(
                                  text: description,
                                  fontsize: 18.h,
                                  fontWeight: FontWeight.w200,
                                ),
                              ),
                              kHeight10,
                              Row(
                                children: [
                                  GooglePoppinseventClassLevelWidgets(
                                      text: "Date :$eventDate",
                                      fontsize: 18.h,
                                      fontWeight: FontWeight.w200),
                                ],
                              ),
                              kHeight10,
                              Row(
                                children: [
                                  GooglePoppinseventClassLevelWidgets(
                                      text: "Venue :$venue",
                                      fontsize: 18.h,
                                      fontWeight: FontWeight.w200),
                                ],
                              ),
                              kHeight30,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GooglePoppinseventClassLevelWidgets(
                                      text: "Signed by : $signedBy",
                                      fontsize: 18.h,
                                      fontWeight: FontWeight.w200),
                                ],
                              ),
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
        ));
  }
}

class GooglePoppinseventClassLevelWidgets extends StatelessWidget {
  String text;
  double fontsize;
  FontWeight? fontWeight;
  Color? color;
  VoidCallback? onTap;
  GooglePoppinseventClassLevelWidgets({
    required this.text,
    required this.fontsize,
    this.fontWeight,
    this.color,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.poppins(
        fontSize: fontsize,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }
}
