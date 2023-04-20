import 'package:dropdown_search/dropdown_search.dart';
import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:dujo_kerala_application/view/widgets/container_image.dart';
import 'package:dujo_kerala_application/view/widgets/sinup_textform_filed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../widgets/fonts/google_monstre.dart';
import '../../../widgets/fonts/google_poppins.dart';

class StudentSignInPageScreen extends StatelessWidget {
  TextEditingController studentNameController = TextEditingController();
  StudentSignInPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ContainerImage(
                        height: 100.h,
                        width: 100.w,
                        imagePath: 'assets/images/leptonlogo.png'),
                    GoogleMonstserratWidgets(
                      text: 'Lepton Dujo',
                      fontsize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
                GooglePoppinsWidgets(
                  fontsize: 20,
                  fontWeight: FontWeight.w400,
                  text: 'Welcome..',
                ),
                Center(
                  child: GooglePoppinsWidgets(
                    fontsize: 24,
                    fontWeight: FontWeight.w600,
                    text: 'Sign up',
                  ),
                ),
                kHeight10,
                Center(
                  child: GooglePoppinsWidgets(
                    fontsize: 20,
                    fontWeight: FontWeight.w300,
                    text: 'Personal Data',
                  ),
                ),
              ],
            ),
          ),
          kHeight10,
          Stack(
            children: [
              Container(
                height: 800,
                width: double.infinity,
                // color: Colors.red,
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      child: Stack(
                        children: [
                          CircleAvatar(
                              // backgroundColor: c,
                              )
                        ],
                      ),
                    ),
                    SinUpTextFromFiled(
                        text: 'Your Name',
                        hintText: 'Enter your Name',
                        // textfromController: studentNameController
                        ),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 180,
                          child: DropdownSearch<String>(
                            selectedItem: 'Gender',
                            validator: (v) => v == null ? "required field" : null,
                            items: const ['Male', 'Female', 'Others'],
                          ),
                        ),
                           Container(
                          width: 180,
                          child: DropdownSearch<String>(
                            selectedItem: 'Blood Group',
                            validator: (v) => v == null ? "required field" : null,
                            items: const ['A +ve','A -ve','B +ve','B -ve','O +ve','O -ve'],
                          ),
                        ),
                      ],
                    ),
                    SinUpTextFromFiled(
                        text: 'House Name',
                        hintText: 'Enter your House Name',
                        // textfromController: studentNameController
                        ),
                    SinUpTextFromFiled(
                        text: 'House Number',
                        hintText: 'Enter your House Number',
                        // textfromController: studentNameController
                        ),
                    SinUpTextFromFiled(
                        text: 'Place',
                        hintText: 'Enter your Place',
                        // textfromController: studentNameController
                        ),
                    SinUpTextFromFiled(
                        text: 'email',
                        hintText: 'Enter your email',
                        // textfromController: studentNameController
                        )
                  ],
                ),
              )
            ],
          )
        ],
      )),
    );
  }
}
