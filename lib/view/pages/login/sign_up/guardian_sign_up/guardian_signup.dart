// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:dujo_kerala_application/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../controllers/sign_up_controller/guardian_signup_controller.dart';
import '../../../../../model/Signup_Image_Selction/image_selection.dart';
import '../../../../../widgets/login_button.dart';
import '../../../../constant/sizes/constant.dart';
import '../../../../constant/sizes/sizes.dart';
import '../../../../widgets/bottom_container_profile_photo_container.dart';
import '../../../../widgets/container_image.dart';
import '../../../../widgets/fonts/google_monstre.dart';
import '../../../../widgets/fonts/google_poppins.dart';
import '../../../../widgets/sinup_textform_filed.dart';

class GuardianSignUp extends StatelessWidget {
  GuardianSignUp({super.key});

  final getImageController = Get.put(GetImage());
  GuardianSignUpController guardianSignUpController =
      Get.put(GuardianSignUpController());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
       onWillPop: (){
        getImageController.pickedImage.value="";
        guardianSignUpController.clearControllers();
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
                  key: formKey,
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
                      SinUpTextFromFiled(
                        text: "Your Name".tr,
                        hintText: 'Enter your Name'.tr,
                        textfromController:
                            guardianSignUpController.userNameController,
                        validator: checkFieldEmpty,
                      ),
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
                                    guardianSignUpController.gender = value;
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      kHeight30,
                      SinUpTextFromFiled(
                        text: 'House Name'.tr,
                        hintText: 'Enter your House Name'.tr,
                        textfromController:
                            guardianSignUpController.houseNameController,
                        validator: checkFieldEmpty,
                      ),
                      SinUpTextFromFiled(
                        keyboardType: TextInputType.number,
                        text: 'House Number'.tr,
                        hintText: 'Enter your House Number'.tr,
                        textfromController:
                            guardianSignUpController.houseNumberController,
                        validator: checkFieldEmpty,
                      ),
                      SinUpTextFromFiled(
                        text: 'Place'.tr,
                        hintText: 'Enter your Place'.tr,
                        textfromController:
                            guardianSignUpController.placeController,
                        validator: checkFieldEmpty,
                      ),
                      SinUpTextFromFiled(
                        text: 'District'.tr,
                        hintText: 'Enter your District'.tr,
                        textfromController:
                            guardianSignUpController.districtController,
                        validator: checkFieldEmpty,
                      ),
                      SinUpTextFromFiled(
                        text: 'State'.tr,
                        hintText: 'Enter your State'.tr,
                        textfromController:
                            guardianSignUpController.stateController,
                        validator: checkFieldEmpty,
                      ),
                      SinUpTextFromFiled(
                        keyboardType: TextInputType.number,
                        text: 'Pincode'.tr,
                        hintText: 'Enter your Pincode'.tr,
                        textfromController:
                            guardianSignUpController.pinCodeController,
                        validator: checkFieldEmpty,
                      ),
                      SinUpTextFromFiled(
                        keyboardType: TextInputType.number,
                        text: ' Alternate Number'.tr,
                        hintText: 'Alternate Number'.tr,
                        textfromController:
                            guardianSignUpController.altPhoneNoController,
                        validator: checkFieldPhoneNumberIsValid,
                      ),
                      kHeight30,
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: GestureDetector(
                          onTap: () async {
                            if (formKey.currentState?.validate() ?? false) {
                              if (getImageController.pickedImage.value.isEmpty) {
                                return showToast(msg: 'Please upload your image');
                              } else {
                                guardianSignUpController.isLoading.value=true;
                                FirebaseAuth.instance
                                    .createUserWithEmailAndPassword(
                                        email:
                                            UserEmailandPasswordSaver.userEmail,
                                        password: UserEmailandPasswordSaver
                                            .userPassword)
                                    .then((value) async {
                                      guardianSignUpController.isLoading.value=false;
                                  await guardianSignUpController
                                      .updateGuardianData();
                                }).catchError((error){
                                  guardianSignUpController.isLoading.value=false;
                                   showToast(msg: error.code);
                                });
                              }
                            }
                          },
                          child: Obx(
                            () => guardianSignUpController.isLoading.value
                                ? circularProgressIndicatotWidget
                                : loginButtonWidget(
                                    height: 60, width: 180, text: 'Submit'.tr),
                          ),
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
