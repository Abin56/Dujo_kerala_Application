
// ignore_for_file: must_be_immutable

import 'package:dropdown_search/dropdown_search.dart';

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


import '../../model/Signup_Image_Selction/image_selection.dart';
import '../view/constant/sizes/sizes.dart';

import '../view/widgets/bottom_container_profile_photo_container.dart';
import '../view/widgets/container_image.dart';
import '../view/widgets/fonts/google_monstre.dart';
import '../view/widgets/fonts/google_poppins.dart';
import '../view/widgets/login_button.dart';
import '../view/widgets/sinup_textform_filed.dart';

class GuardianSignUpPage extends StatelessWidget {
  GuardianSignUpPage({super.key});
  TextEditingController studentNameController = TextEditingController();
  final getImageController = Get.put(GetImage());


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
                kHeight20,
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
          Stack(children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundImage: const NetworkImage(
                        "https://img.freepik.com/premium-photo/teenager-student-girl-yellow-pointing-finger-side_1368-40175.jpg"),
                    radius: 60,
                    child: Stack(
                      children: [
                        InkWell(
                          onTap: () async {
                            _showBottomSheet(context);
                          },
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor: const Color.fromARGB(255, 95, 92, 92),
                              child: IconButton(
                                icon: const Icon(Icons.camera_alt),
                                color: Colors.white,
                                onPressed: () async {
                                  _showBottomSheet(context);
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  kWidth30,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 180.w,
                        height: 100.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.h),
                        ),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GooglePoppinsWidgets(
                                fontsize: 14.h,
                                text: 'Athul V',
                              ),
                              Row(children: const <Widget>[
                                Expanded(child: Divider()),
                              ]),
                              GooglePoppinsWidgets(
                                fontsize: 14.h,
                                text: 'Class : 3 A',
                              ),
                            ]),
                      ),
                    ],
                  ),
                  kHeight20,
                  SinUpTextFromFiled(
                      text: "Your Name",
                      hintText: 'Enter your Name',
                      textfromController: studentNameController),
                  Padding(
                    padding: EdgeInsets.only(left: 8.h, right: 8.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GooglePoppinsWidgets(
                          text: "Gender",
                          fontsize: 12,
                          fontWeight: FontWeight.w300,
                        ),
                        kWidth30,
                        SizedBox(
                          width: 350.w,
                          child: DropdownSearch<String>(
                            selectedItem: 'Select',
                            validator: (v) =>
                                v == null ? "required field" : null,
                            items: const ['Male', 'Female', 'Others'],
                          ),
                        ),
                      ],
                    ),
                  ),
                  kHeight30,
                  SinUpTextFromFiled(
                      text: 'House Name',
                      hintText: 'Enter your House Name',
                      textfromController: studentNameController),
                  SinUpTextFromFiled(
                      text: 'House Number',
                      hintText: 'Enter your House Number',
                      textfromController: studentNameController),
                  SinUpTextFromFiled(
                      text: 'Place',
                      hintText: 'Enter your Place',
                      textfromController: studentNameController),
                  SinUpTextFromFiled(
                      text: 'District',
                      hintText: 'Enter your District',
                      textfromController: studentNameController),
                  SinUpTextFromFiled(
                      text: 'Phone Number',
                      hintText: 'Enter your Phone Number',
                      textfromController: studentNameController),
                  SinUpTextFromFiled(
                      text: 'email',
                      hintText: 'Enter your email',
                      textfromController: studentNameController),
                  kHeight30,
                  loginButtonWidget(text: 'Sign Up'),
                ],
              ),
            ),
          ])
        ],
      )),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return BottomProfilePhotoContainerWidget(
              getImageController: getImageController);
        });
  }
}
