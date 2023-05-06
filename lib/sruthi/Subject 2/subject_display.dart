// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dujo_kerala_application/ui%20team/abin/Subject%20dialog%20and%20chat/popup_container.dart';

import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:dujo_kerala_application/view/widgets/fonts/google_poppins.dart';
import 'package:dujo_kerala_application/widgets/Iconbackbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../view/widgets/container_image.dart';
import 'subject_chapterwise_display.dart';

class SubjectList extends StatelessWidget {
  const SubjectList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: adminePrimayColor,
        title: Row(
         
          children: [
            IconButtonBackWidget(color: cWhite,),
            GooglePoppinsWidgets(
              text: "Subject",
              fontsize: 20.h,
              color: cWhite,
            )
          ],
        ),
      ),
      body: SafeArea(
        child: Column(children: [
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
                    color: adminePrimayColor,
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
                                decoration: BoxDecoration(shape:  BoxShape.circle,color: Colors.white, ),
                                  child: ContainerImage(
                                    
                                    
                                    height: 70.h,
                                    imagePath: 'assets/images/teachernew.png',
                                    width: 70.w,
                                
                                  ),
                                ),
                              ),
                              SizedBox(width: 10.h),
                              Expanded(
                                child: Container(
                                  height:
                                      50, // set a fixed height for the container
                                  child: GooglePoppinsWidgets(
                                    text: "Anupamahgcfgvgfvhgvhgvhygyhgu",
                                    fontsize: 12.h,
                                    color: Colors.white,
                                    
                                  ),
                                ),
                              )
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
                                    fontsize: 25.h,
                                    color: cWhite,
                                  ),
                                ],
                              )),
                        ]),
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
