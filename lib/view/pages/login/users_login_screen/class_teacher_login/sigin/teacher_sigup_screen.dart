// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:dujo_kerala_application/controllers/sign_up_controller/teacher_signup_controller.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:dujo_kerala_application/model/Text_hiden_Controller/password_field.dart';
import 'package:dujo_kerala_application/model/teacher_model/teacher_model.dart';
import 'package:dujo_kerala_application/utils/utils.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/constant/sizes/constant.dart';
import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:dujo_kerala_application/view/pages/login/users_login_screen/teacher_login/teacher_login.dart';
import 'package:dujo_kerala_application/view/widgets/container_image.dart';
import 'package:dujo_kerala_application/view/widgets/fonts/google_poppins.dart';
import 'package:dujo_kerala_application/view/widgets/textformfield_login.dart';
import 'package:dujo_kerala_application/widgets/login_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../userVerify_Phone_OTP/get_otp..dart';

class TeachersSignUpScreen extends StatelessWidget {
  int pageIndex;
  TeachersSignUpScreen({required this.pageIndex, super.key});
  PasswordField hideGetxController = Get.find<PasswordField>();
  final formKey = GlobalKey<FormState>();
  TeacherSignUpController teacherSignUpController =
      Get.put(TeacherSignUpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
        title: ContainerImage(
            height: 28.h,
            width: 90.w,
            imagePath: 'assets/images/dujoo-removebg.png'),
        backgroundColor: adminePrimayColor,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
        
             kHeight20,
            ContainerImage(
              height: 250.h,
              width: double.infinity,
              imagePath: 'assets/images/splash.png',
            ),
            kHeight30,
            Obx(() => teacherSignUpController.isLoading.value
                ? circularProgressIndicatotWidget
                : SizedBox(
                    height: 60.h,
                    width: 350.w,
                    child: DropdownSearch<TeacherModel>(
                        selectedItem: TeacherModel(
                          teacherName: 'Select Teacher'.tr,
                          teacherEmail: '',
                          houseName: '',
                          houseNumber: '',
                          place: '',
                          gender: '',
                          district: '',
                          altPhoneNo: '',
                          employeeID: '',
                          createdAt: '',
                          teacherPhNo: "",
                          docid: '',
                          userRole: '',
                          imageId: '',
                          imageUrl: '',
                        ),
                        validator: (v) => v == null ? "required field" : null,
                        items: teacherSignUpController.teachersList,
                        itemAsString: (TeacherModel u) => u.teacherName ?? "",
                        onChanged: (value) {
                          UserCredentialsController.teacherModel = value;
                          log(value?.teacherPhNo ?? "");
                        }),
                  )),
            kHeight30,
            Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  kHeight10,
                  SigninTextFormfield(
                      obscureText: false,
                      hintText: 'Email ID'.tr,
                      labelText: 'Enter Mail ID',
                      prefixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.mail_outline,
                        ),
                      ),
                      textEditingController:
                          teacherSignUpController.emailController,
                      function: checkFieldEmailIsValid),

                       kHeight10,
                       Padding(
                    padding: EdgeInsets.only(right: 29.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GooglePoppinsWidgets(
                            text: "* Use a valid email".tr,
                            fontsize: 13.w,
                            fontWeight: FontWeight.w400,
                            color: adminePrimayColor),
                      ],
                    ),
                  ),

                  Obx(
                    () => SigninTextFormfield(
                      hintText: 'Password'.tr,
                      obscureText: hideGetxController.isObscurefirst.value,
                      labelText: 'Password',
                      icon: Icons.lock,
                      textEditingController:
                          teacherSignUpController.passwordController,
                      function: checkFieldPasswordIsValid,
                      prefixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.lock),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(hideGetxController.isObscurefirst.value
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          hideGetxController.toggleObscureFirst();
                        },
                      ),
                    ),
                  ),
                  Obx(
                    () => SigninTextFormfield(
                      hintText: 'Confirm Password'.tr,
                      obscureText: hideGetxController.isObscureSecond.value,
                      labelText: 'Confirm Password',
                      icon: Icons.lock,
                      textEditingController:
                          teacherSignUpController.confirmPasswordController,
                      function: checkFieldPasswordIsValid,
                      prefixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.lock),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(hideGetxController.isObscureSecond.value
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          hideGetxController.toggleObscureSecond();
                        },
                      ),
                    ),
                  ),
                  kHeight10,
                  Padding(
                    padding: EdgeInsets.only(top: 20.h),
                    child: GestureDetector(
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          if (UserCredentialsController
                                      .teacherModel?.teacherPhNo !=
                                  '' ||
                              UserCredentialsController
                                      .teacherModel?.teacherPhNo !=
                                  null) {
                            Get.to(() => UserSentOTPScreen(
                                  userpageIndex: pageIndex,
                                  phoneNumber:
                                      "+91${UserCredentialsController.teacherModel?.teacherPhNo}",
                                  userEmail: teacherSignUpController
                                      .emailController.text,
                                  userPassword: teacherSignUpController
                                      .passwordController.text,
                                ));
                          } else {
                            showToast(msg: "Please select student detail.");
                          }
                        }
                      },
                      child: loginButtonWidget(
                        height: 60,
                        width: 180,
                        text: 'Submit'.tr,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?".tr,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(()=>TeacherLoginScreen(
                            pageIndex: 3,
                          ));
                        },
                        child: Text(
                          "Login".tr,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                              fontSize: 19,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
