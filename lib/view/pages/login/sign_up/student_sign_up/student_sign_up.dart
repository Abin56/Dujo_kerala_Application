// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:dujo_kerala_application/controllers/sign_up_controller/student_sign_up_controller.dart';
import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:dujo_kerala_application/view/pages/login/users_login_screen/student%20login/student_login.dart';
import 'package:dujo_kerala_application/view/widgets/container_image.dart';
import 'package:dujo_kerala_application/view/widgets/sinup_textform_filed.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  GlobalKey<FormState> formKey1 = GlobalKey<FormState>();

  final StudentSignUpController studentController =
      Get.find<StudentSignUpController>();

  StudentSignInPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        getImageController.pickedImage.value="";
        studentController.clearFields();
        return Future.value(true);
      },
      child: Scaffold(
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
                          height: 70.h,
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
                    text: 'Welcome..'.tr,
                  ),
                  kHeight20,
                  Center(
                    child: GooglePoppinsWidgets(
                      fontsize: 24,
                      fontWeight: FontWeight.w600,
                      text: 'Sign up'.tr,
                    ),
                  ),
                  kHeight10,
                  Center(
                    child: GooglePoppinsWidgets(
                      fontsize: 20,
                      fontWeight: FontWeight.w300,
                      text: 'Personal Data'.tr,
                    ),
                  ),
                ],
              ),
            ),
            kHeight10,
            Stack(children: [
              SingleChildScrollView(
                child: Form(
                  key: formKey1,
                  child: Column(
                    children: [
                      Obx(
                        () => CircleAvatar(
                          backgroundImage: getImageController
                                  .pickedImage.value.isEmpty
                              ? const NetworkImage(netWorkImagePathPerson)
                              : FileImage(
                                      File(getImageController.pickedImage.value))
                                  as ImageProvider,
                          radius: 60,
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
                              text: "Gender".tr,
                              fontsize: 14,
                              fontWeight: FontWeight.w300,
                            ),
                            kWidth30,
                            Flexible(
                              child: SizedBox(
                                width: 330.w,
                                child: DropdownSearch<String>(
                                  selectedItem: 'Select Gender'.tr,
                                  validator: (v) =>
                                      v == null ? "required field" : null,
                                  items: const ['Male', 'Female', 'Others'],
                                  onChanged: (value) {
                                    studentController.gender = value;
                                  },
                                ),
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
                              text: "Blood Group".tr,
                              fontsize: 14,
                              fontWeight: FontWeight.w300,
                            ),
                            kWidth30,
                            Flexible(
                              child: SizedBox(
                                width: 330.w,
                                child: DropdownSearch<String>(
                                  selectedItem: 'Select Group'.tr,
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
                        text: 'Date of birth'.tr,
                        hintText: 'Date of birth'.tr,
                        readOnly: true,
                        textfromController:
                            studentController.dateOfBirthController,
                        onTapFunction: () async {
                          studentController.dateOfBirthController.text =
                              await dateTimePicker(context);
                        },
                      ),
                      SinUpTextFromFiled(
                        text: 'House Name'.tr,
                        hintText: 'Enter your House Name'.tr,
                        textfromController: studentController.houseNameController,
                        validator: checkFieldEmpty,
                      ),
                      SinUpTextFromFiled(
                        keyboardType: TextInputType.number,
                        text: 'House Number'.tr,
                        hintText: 'Enter your House Number'.tr,
                        textfromController:
                            studentController.houseNumberController,
                        validator: checkFieldEmpty,
                      ),
                      SinUpTextFromFiled(
                        text: 'Place'.tr,
                        hintText: 'Enter your Place'.tr,
                        textfromController: studentController.placeController,
                        validator: checkFieldEmpty,
                      ),
                      SinUpTextFromFiled(
                        text: 'District'.tr,
                        hintText: 'Enter your District'.tr,
                        textfromController: studentController.districtController,
                        validator: checkFieldEmpty,
                      ),
                      SinUpTextFromFiled(
                        keyboardType: TextInputType.number,
                        text: ' Alternate Number'.tr,
                        hintText: 'Alternate Number'.tr,
                        textfromController:
                            studentController.altPhoneNoController,
                        validator: checkFieldPhoneNumberIsValid,
                      ),
                      kHeight30,
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: GestureDetector(
                          onTap: () {
                              if (getImageController.pickedImage.value.isEmpty) {
                                return showToast(msg: 'Please upload your image');
                              } else {
                                if (studentController.checkAllFieldIsEmpty()) {
                                  showToast(msg: "All Fields are mandatory");
                                  return;
                                } else {
                                  try {
                                    studentController.isLoading.value=true;
                                    FirebaseAuth.instance
                                      .createUserWithEmailAndPassword(
                                          email:
                                              UserEmailandPasswordSaver.userEmail,
                                          password: UserEmailandPasswordSaver
                                              .userPassword)
                                      .then((value)  {
                                         studentController.isLoading.value=false;
                                            studentController
                                                .updateStudentData()
                                                .then((value) {
                                              return showDialog(
                                                context: context,
                                                barrierDismissible:
                                                    false, // user must tap button!
                                                builder: (BuildContext context) {
                                                  studentController.isLoading.value=false;
                                                  return AlertDialog(
                                                    title: const Text('Message'),
                                                    content:
                                                           SingleChildScrollView(
                                                      child: ListBody(
                                                        children: <Widget>[
                                                          Text(
                                                              'Your Profile Created Successfully,\nPlease Login again')
                                                        ],
                                                      ),
                                                    ),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        child: const Text('Ok'),
                                                        onPressed: () {
                                                          Navigator
                                                              .pushAndRemoveUntil(
                                                                  context,
                                                                  MaterialPageRoute(
                                                            builder: (context) {
                                                              return StudentLoginScreen();
                                                            },
                                                          ), (route) => false);
                                                        },
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            });
                                          }).catchError((error){
                                             studentController.isLoading.value=false;
                                    showToast(msg: error.code);
                                          });
                                  }on FirebaseAuthException catch (e) {
                                    studentController.isLoading.value=false;
                                    showToast(msg: e.code);
                                  }


                          
                                }}
                            },
                              
                            
                          
                          child: Obx(() => studentController.isLoading.value
                              ? circularProgressIndicatotWidget
                              : loginButtonWidget(
                                  height: 60, width: 180, text: 'Submit'.tr)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ])
          ],
        )),
      ),
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
