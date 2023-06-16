
import 'package:dujo_kerala_application/sruthi/homeWork/homework_display.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/widgets/Iconbackbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../view/constant/sizes/sizes.dart';
import '../view/widgets/fonts/google_poppins.dart';


class StudentHomeWorkPage extends StatelessWidget {
  const StudentHomeWorkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            IconButtonBackWidget(),kHeight20,
            GooglePoppinsWidgets(text: "HomeWork", fontsize: 25.h)
          ],
        ),
        backgroundColor: adminePrimayColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {},
                      child: Container(
                        height: 190.h,
                        decoration:
                            BoxDecoration(border: Border.all(width: 0.02)),
                        child: Padding(
                          padding: EdgeInsets.only(top: 18.h),
                          child: ListTile(
                              leading: const Icon(Icons.paste_sharp),
                              title: GooglePoppinsWidgets(
                                  text: "Chapter 1", fontsize: 19.h),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 10.h),
                                    child: GooglePoppinsWidgets(
                                        text: "Subjects : Maths",
                                        fontsize: 15.h),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 10.h),
                                    child: Row(
                                      children: [
                                        GooglePoppinsWidgets(
                                            text: "HomeWorks : ",
                                            fontsize: 15.h),
                                             InkWell(
                                              
                                                    onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const HomeWorkDisplay()));
                                               },
                                              
                                               child: GooglePoppinsWidgets(
                                                                         text: "View",
                                                                         fontsize: 16.h,
                                                                         color: Colors.blue,
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
                                            fontsize: 15.h),
                                        GooglePoppinsWidgets(
                                            text: "To : 00/00/00",
                                            fontsize: 15.h),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(top: 10.h),
                                        child: GooglePoppinsWidgets(
                                            text: "Assigned Teacher : Anupama",
                                            fontsize: 15.h),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
