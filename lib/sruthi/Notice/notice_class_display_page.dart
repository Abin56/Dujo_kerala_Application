import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../view/widgets/fonts/google_poppins.dart';

class NoticeClassDisplayPage extends StatelessWidget {
  const NoticeClassDisplayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(backgroundColor:adminePrimayColor,title: GooglePoppinsWidgets(fontsize:20.h , text: 'Notice',),),
        body: ListView(children: [
          Container(
            width: 90.w,
            height: 900.h,

            decoration: BoxDecoration( ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                 
                  kHeight30,
                  Container(
                    height: 150,
                    width: 150,
                    child: Image(
                      image: NetworkImage(
                          "https://media.istockphoto.com/id/926144358/photo/portrait-of-a-little-bird-tit-flying-wide-spread-wings-and-flushing-feathers-on-white-isolated.jpg?b=1&s=170667a&w=0&k=20&c=DEARMqqAI_YoA5kXtRTyYTYU9CKzDZMqSIiBjOmqDNY="),
                      fit: BoxFit.fill,
                    ),
                  ),
                  kHeight30,
                  Expanded(
                    child: ListView(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.h),
                          child: Container(
                            height: 600.h,
                            width: 360.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(width: 1, color: Colors.grey)),
                            child: Padding(
                              padding: EdgeInsets.all(8.h),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GooglePoppinsWidgets(
                                        text: "New Notice",
                                        fontsize: 22.h,
                                        fontWeight: FontWeight.w500,
                                      )
                                    ],
                                  ),
                                  kHeight20,
                                  GooglePoppinsWidgets(
                                      text: "This is to inform all the students that " +
                                          " __________________  will be  conductod" +
                                          " __________________  at __________________ with various cultural programmes.______________ will be grace the occasion. Student who would like to occasion in various programme should contact their\nrespective classteacher latest by __________________ .",
                                      fontsize: 19.h),
                                  kHeight30,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      GooglePoppinsWidgets(
                                          text: "Date : 12/12/12",
                                          fontsize: 17.h),
                                    ],
                                  ),
                                  kHeight10,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      GooglePoppinsWidgets(
                                          text: "Signed by: Principal",
                                          fontsize: 17.h)
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
                ]),
          )
        ]),
      ),
    );
  }
}
