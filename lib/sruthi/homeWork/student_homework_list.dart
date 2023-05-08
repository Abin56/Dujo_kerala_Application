import 'package:dujo_kerala_application/sruthi/homeWork/homework_display.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/widgets/Iconbackbutton.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../view/constant/sizes/sizes.dart';
import '../../view/widgets/fonts/google_poppins.dart';

class HomeWorkList extends StatelessWidget {
  const HomeWorkList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        title: Row(
          children: [
            kHeight20,
            GooglePoppinsWidgets(text: "HomeWork", fontsize: 25.h)
          ],
        ),
        backgroundColor: adminePrimayColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                  itemCount: 5,
                  separatorBuilder: ((context, index) {
                    return kHeight10;
                  }),
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: 10.h, right: 10.h, top: 10.h),
                          child: Card(
                            child: ListTile(
                                shape: BeveledRectangleBorder(
                                    side: BorderSide(
                                        color: Colors.grey, width: 0.2)),
                                leading: const Icon(Icons.paste_sharp),
                                title: GooglePoppinsWidgets(
                                  text: "Chapter 1",
                                  fontsize: 19.h,
                                  fontWeight: FontWeight.bold,
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: 10.h),
                                      child: GooglePoppinsWidgets(
                                          text: "Subject : Maths",
                                          fontsize: 15.h,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 10.h),
                                      child: Row(
                                        children: [
                                          GooglePoppinsWidgets(
                                              text: "Task : ",
                                              fontsize: 15.h,
                                              fontWeight: FontWeight.bold),
                                          InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          HomeWorkDisplay()));
                                            },
                                            child: GooglePoppinsWidgets(
                                              text: "View",
                                              fontsize: 16.h,
                                              color: adminePrimayColor,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 10.h),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          GooglePoppinsWidgets(
                                              text: "From : 00/00/00",
                                              fontsize: 15.h,
                                              fontWeight: FontWeight.bold),
                                          GooglePoppinsWidgets(
                                              text: "To : 00/00/00",
                                              fontsize: 15.h,
                                              fontWeight: FontWeight.bold),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:  EdgeInsets.only(top:10.h),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          GooglePoppinsWidgets(
                                              text: "Assigned Teacher:",
                                              fontsize: 15.h),
                                          Flexible(
                                            child: GooglePoppinsWidgets(
                                                text: " Anupama Neena ",
                                                fontWeight: FontWeight.bold,
                                                fontsize: 15.h),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                        ),
                      ],
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
