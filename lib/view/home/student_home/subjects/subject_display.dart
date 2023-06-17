// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:dujo_kerala_application/view/home/student_home/subjects/subjectchapter.dart';
import 'package:dujo_kerala_application/view/widgets/container_image.dart';
import 'package:dujo_kerala_application/view/widgets/fonts/google_poppins.dart';
import 'package:dujo_kerala_application/widgets/Iconbackbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../pages/teacher_list/teacher_chat.dart';
import '../../../widgets/fonts/google_monstre.dart';

class StudentSubjectHome extends StatelessWidget {
  const StudentSubjectHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: cWhite,
        title: Row(
          children: [
            IconButtonBackWidget(color: cblack),
            SizedBox(
              width: 90.h,
            ),
            GooglePoppinsWidgets(
              text: "Subjects".tr,
              fontsize: 20.h,
              color: cblack,
            )
          ],
        ),
        //  actions: [
        //   IconButton(onPressed: () {

        // }, icon: Icon(Icons.arrow_back_rounded),color: cblack,)],
        // title: Text('Subject'),
      ),
      body: SafeArea(
        child: Column(children: [
          // Heading_Container_Widget(
          //   text: '',
          // ),
          Expanded(
            child: GridView.count(
              padding: const EdgeInsets.all(15),
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              children: List.generate(
                4,
                (index) => Container(
                  decoration: BoxDecoration(
                    color: cWhite,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  height: 50,

                  // ignore: sort_child_properties_last
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 20.h, top: 20.h, right: 20.h),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              bottomRight: Radius.circular(40),
                                              topLeft: Radius.circular(40)),
                                        ),
                                        backgroundColor: cWhite,
                                        elevation: 0,
                                        contentPadding: EdgeInsets.zero,
                                        content: PopUpContainer(),
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  width: 75.w,
                                  height: 75.h,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(blurRadius: 3.0, color: cWhite),
                                    ],
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.white.withOpacity(0.5),
                                    border: Border.all(color: Colors.white),
                                  ),
                                  child: ContainerImage(
                                    height: 60.h,
                                    imagePath: 'assets/images/teachernew.png',
                                    width: 60.w,
                                  ),
                                ),
                              ),
                              SizedBox(width: 10.h),
                              Expanded(
                                  child: FittedBox(
                                      child: GooglePoppinsWidgets(
                                text: "Anupamah",
                                fontsize: 12.h,
                                color: Colors.grey,
                              )))
                            ],
                          ),
                          kHeight20,
                          InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            SubjectWiseDisplay()));
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GooglePoppinsWidgets(
                                    text: "Chemistry",
                                    fontsize: 28.h,
                                    color: cblack,
                                  ),
                                ],
                              )),
                        ]),
                  ),

                  // GooglePoppinsWidgets(text: "Subject", fontsize: 16),
                  // kHeight10,
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

const text = [""];

class PopUpContainer extends StatelessWidget {
  const PopUpContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      //  margin: EdgeInsets.only(top: 50.h),
      height: 350.h,
      width: 570.w,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Column(
        children: [
          Column(
            children: [
              PopUpcontainerWidget(
                text1: 'Email :' ' lepton@gmail.com',
                text: 'Name :' ' Lepton',
                text2: ' Chat with your teacher',
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: SizedBox(
                      //  color: cblue,
                      height: 30.h,
                      width: 70.w,
                      child: GoogleMonstserratWidgets(
                        text: 'Close',
                        fontsize: 20,
                        color: Colors.red,
                        fontWeight: FontWeight.w700,
                      ))
                  // Text("Close",style: TextStyle(color: Colors.red))),
                  ),
            ],
          ),
        ],
      ),
    );
  }
}

class PopUpcontainerWidget extends StatelessWidget {
  PopUpcontainerWidget({
    required this.text,
    required this.text1,
    required this.text2,
    super.key,
  });

  String text;
  String text1;
  String text2;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 270.h,
      width: 560.w,
      // width: double.infinity-10,
      // margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
      decoration: const BoxDecoration(
          color: ctran, borderRadius: BorderRadius.all(Radius.circular(1))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          kHeight20,
          ContainerImage(
            imagePath: 'assets/images/leptonlogo.png',
            height: 90.h,
            width: 120.w,
          ),
          kWidth20,
          GoogleMonstserratWidgets(
              text: text,
              fontsize: 18.w,
              fontWeight: FontWeight.w600,
              color: cblack),
          kHeight20,
          GoogleMonstserratWidgets(
              text: text1,
              fontsize: 18.w,
              fontWeight: FontWeight.w700,
              color: cblack),
          kHeight10,
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => const SubjectChat())));
            },
            child: Container(
              // color: Colors.amber,
              width: 250.w,

              margin: EdgeInsets.only(left: 5.w),
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/chat (2).svg',
                    height: 40.h,
                    width: 40.w,
                    //color: cblack,
                  ),
                  GoogleMonstserratWidgets(
                    text: text2,
                    fontsize: 16.w,
                    color: cblue,
                    fontWeight: FontWeight.w800,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
