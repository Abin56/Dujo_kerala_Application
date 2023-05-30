// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:dujo_kerala_application/view/widgets/fonts/google_poppins.dart';
import 'package:dujo_kerala_application/widgets/Iconbackbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../view/widgets/container_image.dart';
import 'subject_chapterwise_display.dart';

class SubjectList extends StatelessWidget {
  const SubjectList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: adminePrimayColor,
        title: Row(
          children: [
            IconButtonBackWidget(
              color: cWhite,
            ),
            GooglePoppinsWidgets(
              text: "Subject",
              fontsize: 20.h,
              color: cWhite,
            )
          ],
        ),
      ),
      body: SafeArea(
        child: GridView.count(
          padding: const EdgeInsets.all(15),
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          children: List.generate(
            4,
            (index) => GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SubjectWiseDisplay()));
              },
              child: Container(
                decoration: BoxDecoration(
                  color: adminePrimayColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                height: 50,
                child: Padding(
                  padding: EdgeInsets.only(left: 20.h, top: 20.h, right: 20.h),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: ContainerImage(
                                  height: 70.h,
                                  imagePath: 'assets/images/teachernew.png',
                                  width: 70.w,
                                ),
                              ),
                              SizedBox(width: 10.w),
                          
                                 SizedBox(
                                  height:
                                      50.h, // set a fixed height for the container
                                  child: GooglePoppinsWidgets(
                                    text: text[index],
                                    fontsize: 12.h,
                                    color: Colors.white,
                                  ),
                                ),
                              
                            ],
                          ),
                        ),
                        kHeight20,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GooglePoppinsWidgets(
                              text: "Chemistry",
                              fontsize: 25.h,
                              color: cWhite,
                            ),
                          ],
                        ),
                      ]),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

const text = ["Anu o s", "Anoop", "Anu", "Amanda Mariya Hilari"];
