import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:dujo_kerala_application/view/widgets/fonts/google_poppins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
          title: const Text("Events"),
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
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GooglePoppinsWidgets(
                                      text: eventName, fontsize: 22.h),
                                  const Icon(Icons.event_note)
                                ],
                              ),
                              kHeight50,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  GooglePoppinsWidgets(
                                    text: "Description : ",
                                    fontsize: 18.h,
                                    fontWeight: FontWeight.w200,
                                  )
                                ],
                              ),
                              kHeight20,
                              GooglePoppinsWidgets(
                                  text: description, fontsize: 18.h),
                              kHeight10,
                              Row(
                                children: [
                                  GooglePoppinsWidgets(
                                      text: "Date :$eventDate",
                                      fontsize: 18.h,
                                      fontWeight: FontWeight.w200),
                                ],
                              ),
                              kHeight10,
                              Row(
                                children: [
                                  GooglePoppinsWidgets(
                                      text: "Venue :$venue",
                                      fontsize: 18.h,
                                      fontWeight: FontWeight.w200),
                                ],
                              ),
                              kHeight30,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GooglePoppinsWidgets(
                                      text: "Signed By : $signedBy",
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
