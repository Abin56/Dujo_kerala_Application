import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../view/colors/colors.dart';
import '../../view/constant/sizes/sizes.dart';
import '../../view/widgets/fonts/google_poppins.dart';


class HomeWorkDisplay extends StatefulWidget {
  const HomeWorkDisplay({super.key});

  @override
  State<HomeWorkDisplay> createState() => _HomeWorkDisplayState();
}


class _HomeWorkDisplayState extends State<HomeWorkDisplay> {






  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [GooglePoppinsWidgets(text: "HomeWork", fontsize: 25.h)],
          ),
          backgroundColor: adminePrimayColor,
        ),
        body: Column(
         
          children: [
            kHeight30,
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.all(18.h),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                          children: [
                            GooglePoppinsWidgets(
                              text: "Task",
                              fontsize: 22.h,
                              fontWeight: FontWeight.w500,
                            ),
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
                          text:
                              "Homework.” Merriam-Webster.com Dictionary, Merriam-Webster, . Accessed 27 Apr. 2023.fncdjnfdjnjfgvnjfgvnfjgvfjdhngrjhgjrhgjrfgjuhghg",
                          fontsize: 19.h,
                        ),
                        kHeight30,
                        
                      
                 ] ),
                  ),
                ],

              ),
            ),
          ],
     ) );
  }
}

