// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:dujo_kerala_application/controllers/sign_up_controller/teacher_signup_controller.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:dujo_kerala_application/utils/utils.dart';
import 'package:dujo_kerala_application/view/constant/sizes/constant.dart';
import 'package:dujo_kerala_application/view/pages/login/users_login_screen/users_login_screen.dart';
import 'package:dujo_kerala_application/view/widgets/fonts/google_poppins.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../model/Signup_Image_Selction/image_selection.dart';
import '../../../../../widgets/login_button.dart';
import '../../../../constant/sizes/sizes.dart';
import '../../../../widgets/bottom_container_profile_photo_container.dart';
import '../../../../widgets/container_image.dart';
import '../../../../widgets/fonts/google_monstre.dart';
import '../../../../widgets/sinup_textform_filed.dart';

class TeachersSignUpPage extends StatelessWidget {
  TeachersSignUpPage({super.key});
  TextEditingController userNameController = TextEditingController();
  TextEditingController useremailController = TextEditingController();
  TextEditingController houseNameController = TextEditingController();
  TextEditingController houseNumberController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController altPhoneNoController = TextEditingController();

  final getImageController = Get.put(GetImage());

  final TeacherSignUpController teacherController =
      Get.find<TeacherSignUpController>();
      
  // final ImageProvider imageProvider;
  // final double radius;
      
  // ValidatedCircleAvatar({
  //   required this.imageProvider,
  //   required this.radius,
  // });

//   @override
//   Widget build(BuildContext context) {
//     // Validate the imageProvider here (add your validation logic)
//     final isValid = true; // Replace with your own validation check

//     return CircleAvatar(
//       backgroundImage: isValid ? imageProvider : null,
//       radius: radius,
//       child: isValid ? null : Icon(Icons.error), // Display an error icon if the avatar is not valid
//     );
//   }
// }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        getImageController.pickedImage.value="";
        teacherController.clearFields();
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
                      text:
                          "ID : ${UserCredentialsController.teacherModel!.userRole}",
                      fontsize: 14,
                      fontWeight: FontWeight.w300,
                    ),
                    kWidth30,
                    SinUpTextFromFiled(
                      text: "Your Name".tr,
                      hintText:
                          //UserCredentialsController.teacherModel!.teacherName ??
                          "Enter Your Name",
                      textfromController: teacherController.nameController,
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
                                onChanged: (val) {
                                  teacherController.gender = val;
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
                      textfromController: teacherController.houseNameController,
                      validator: checkFieldEmpty,
                    ),
                    SinUpTextFromFiled(
                      keyboardType: TextInputType.number,
                      text: 'House Number'.tr,
                      hintText: 'Enter your House Number'.tr,
                      textfromController: teacherController.houseNumberController,
                      validator: checkFieldEmpty,
                    ),
                    SinUpTextFromFiled(
                      text: 'Place'.tr,
                      hintText: 'Enter your Place'.tr,
                      textfromController: teacherController.placeController,
                      validator: checkFieldEmpty,
                    ),
                    SinUpTextFromFiled(
                      text: 'District'.tr,
                      hintText: 'Enter your District'.tr,
                      textfromController: teacherController.districtController,
                      validator: checkFieldEmpty,
                    ),
                    SinUpTextFromFiled(
                      keyboardType: TextInputType.number,
                      text: ' Alternate Number'.tr,
                      hintText: 'Alternate Number'.tr,
                      textfromController: teacherController.altPhoneNoController,
                      validator: checkFieldEmpty,
                    ),
                    kHeight30,
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: GestureDetector(
                        onTap: () {
                          if (teacherController.checkAllFieldIsEmpty()) {
                            showToast(msg: "All Fields are mandatory");
                            return;
                          } else {
                            if (getImageController.pickedImage.value.isEmpty) {
                              return showToast(msg: 'Please upload your image');
                            } else {
                              teacherController.isLoading.value=true;
                              FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                      email: UserEmailandPasswordSaver.userEmail,
                                      password:
                                          UserEmailandPasswordSaver.userPassword)
                                  .then((value) {
                                    teacherController.isLoading.value=false;
                                teacherController
                                    .updateTeacherData()
                                    .then((value) {
                                  return showDialog(
                                    context: context,
                                    barrierDismissible:
                                        false, // user must tap button!
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Message'),
                                        content: SingleChildScrollView(
                                          child: ListBody(
                                            children: const <Widget>[
                                              Text(
                                                  'Your Profile Created Successfully,\nPlease Login again')
                                            ],
                                          ),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            child: const Text('Ok'),
                                            onPressed: () {
                                              Get.offAll(UsersLoginScreen());
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                });
                                // .then(
                                //     (value) =>);
                              }).catchError((error){
                                teacherController.isLoading.value=false;
                                showToast(msg: error.code);
                              });
                            }
                          }
                        },
                        //   Get.offAll(const HomeScreen());
    
                        child: Obx(() => teacherController.isLoading.value
                            ? circularProgressIndicatotWidget
                            : loginButtonWidget(
                                height: 60, width: 180, text: 'Submit'.tr)),
                      ),
                    ),
                  ],
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
