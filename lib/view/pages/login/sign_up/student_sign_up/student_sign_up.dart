// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:dujo_kerala_application/controllers/sign_up_controller/sign_up_controller.dart';
import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:dujo_kerala_application/view/pages/home/home.dart';
import 'package:dujo_kerala_application/view/widgets/container_image.dart';
import 'package:dujo_kerala_application/view/widgets/sinup_textform_filed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../model/Signup_Image_Selction/image_selection.dart';
import '../../../../../utils/utils.dart';
import '../../../../../widgets/login_button.dart';
import '../../../../constant/sizes/constant.dart';
import '../../../../widgets/bottom_container_profile_photo_container.dart';
import '../../../../widgets/fonts/google_monstre.dart';
import '../../../../widgets/fonts/google_poppins.dart';

class StudentSignInPageScreen extends StatelessWidget {
  final getImageController = Get.put(GetImage());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final StudentSignUpController studentController =
      Get.find<StudentSignUpController>();

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
                  Obx(
                    () => CircleAvatar(
                      backgroundImage: getImageController
                              .pickedImage.value.isEmpty
                          ? const NetworkImage(
                              "https://img.freepik.com/premium-photo/teenager-student-girl-yellow-pointing-finger-side_1368-40175.jpg")
                          : FileImage(
                                  File(getImageController.pickedImage.value))
                              as ImageProvider,
                      radius: 60,
                      child: Form(
                        key: formKey,
                        child: Stack(
                          children: [
                            InkWell(
                              onTap: () async {
                                _getCameraAndGallery(context);
                              },
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundColor:
                                      const Color.fromARGB(255, 95, 92, 92),
                                  child: IconButton(
                                    icon: const Icon(Icons.camera_alt),
                                    color: Colors.white,
                                    onPressed: () async {
                                      _getCameraAndGallery(context);
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  kHeight10,
                  GooglePoppinsWidgets(
                    text: "ID : 8934883839",
                    fontsize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                  kWidth30,
                  Padding(
                    padding: EdgeInsets.only(left: 8.h, right: 8.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GooglePoppinsWidgets(
                          text: "Gender",
                          fontsize: 14,
                          fontWeight: FontWeight.w300,
                        ),
                        kWidth30,
                        SizedBox(
                          width: 330.w,
                          child: DropdownSearch<String>(
                            selectedItem: 'Select Gender',
                            validator: (v) =>
                                v == null ? "required field" : null,
                            items: const ['Male', 'Female', 'Others'],
                            onChanged: (value) {
                              studentController.gender = value;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  kWidth30,
                  Padding(
                    padding: EdgeInsets.only(left: 8.h, right: 8.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GooglePoppinsWidgets(
                          text: "Blood Group",
                          fontsize: 14,
                          fontWeight: FontWeight.w300,
                        ),
                        kWidth30,
                        Flexible(
                          child: SizedBox(
                            width: 330.w,
                            child: DropdownSearch<String>(
                              selectedItem: 'Select Group',
                              validator: (v) =>
                                  v == null ? "required field" : null,
                              items: const [
                                'A+',
                                'A-',
                                'B+',
                                'B-',
                                'AB+',
                                'AB-',
                                'O+',
                                'O-',
                              ],
                              onChanged: (value) {
                                studentController.bloodGroup = value;
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  kHeight30,
                  SinUpTextFromFiled(
                    text: 'Date of birth',
                    hintText: 'Date of birth',
                    readOnly: true,
                    textfromController: studentController.dateOfBirthController,
                    onTapFunction: () async {
                      studentController.dateOfBirthController.text =
                          await dateTimePicker(context);
                    },
                  ),
                  SinUpTextFromFiled(
                    text: 'House Name',
                    hintText: 'Enter your House Name',
                    textfromController: studentController.houseNameController,
                    validator: checkFieldEmpty,
                  ),
                  SinUpTextFromFiled(
                    keyboardType: TextInputType.number,
                    text: 'House Number',
                    hintText: 'Enter your House Number',
                    textfromController: studentController.houseNumberController,
                    validator: checkFieldEmpty,
                  ),
                  SinUpTextFromFiled(
                    text: 'Place',
                    hintText: 'Enter your Place',
                    textfromController: studentController.placeController,
                    validator: checkFieldEmpty,
                  ),
                  SinUpTextFromFiled(
                    text: 'District',
                    hintText: 'Enter your District',
                    textfromController: studentController.districtController,
                    validator: checkFieldEmpty,
                  ),
                  SinUpTextFromFiled(
                      keyboardType: TextInputType.number,
                      text: ' Al Phone Number',
                      hintText: 'Enter your Al Phone Number',
                      textfromController:
                          studentController.altPhoneNoController,
                          validator: checkFieldPhoneNumberIsValid,),
                  kHeight30,
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: GestureDetector(
                      onTap: () {
                        if(formKey.currentState!.validate()){}
                        studentController
                            .updateStudentData()
                            .then((value) => Get.offAll(const HomeScreen()));
                      },
                      child: loginButtonWidget(
                          height: 60, width: 180, text: 'Submit'),
                    ),
                  ),
                ],
              ),
            ),
          ])
        ],
      )),
    );
  }

  void _getCameraAndGallery(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return BottomProfilePhotoContainerWidget(
              getImageController: getImageController);
        });
  }
}
