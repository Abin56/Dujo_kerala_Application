// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables


import 'package:dujo_kerala_application/sruthi/Subject/subject_chapterwise_display.dart';
import 'package:dujo_kerala_application/ui%20team/abin/Subject%20dialog%20and%20chat/popup_container.dart';

import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:dujo_kerala_application/view/widgets/fonts/google_poppins.dart';
import 'package:dujo_kerala_application/widgets/Iconbackbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../../../view/widgets/container_image.dart';

class StudentSubjectHome extends StatelessWidget {
  const StudentSubjectHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: cWhite,
       title: Row(
          children: [            
            IconButtonBackWidget(color: cblack),SizedBox(width: 90.h,),
            GooglePoppinsWidgets(text: "Subject", fontsize: 20.h,color: cblack,)
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

                                        shape: 
                                       
                                        RoundedRectangleBorder(

                                          borderRadius:
                                              BorderRadius.only(bottomRight: Radius.circular(40),topLeft: Radius.circular(40)),
                                        ),
                                        backgroundColor: cWhite,elevation: 0,
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
