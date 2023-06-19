// ignore_for_file: must_be_immutable

import 'package:dujo_kerala_application/utils/utils.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:dujo_kerala_application/widgets/forget_password_page.dart';
import 'package:dujo_kerala_application/widgets/login_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../controllers/sign_in_controller/teacher_login_controller.dart';
import '../../../../../model/Text_hiden_Controller/password_field.dart';
import '../../../../constant/sizes/constant.dart';
import '../../../../widgets/container_image.dart';
import '../../../../widgets/fonts/google_monstre.dart';
import '../../../../widgets/fonts/google_poppins.dart';
import '../../../../widgets/textformfield_login.dart';
import '../class_teacher_login/sigin/teacher_sigup_screen.dart';

class TeacherLoginScreen extends StatelessWidget {
  int? pageIndex;
  PasswordField hideGetxController = Get.find<PasswordField>();

  TeacherLoginScreen({this.pageIndex, super.key});
  TeacherLoginController teacherLoginController =
      Get.put(TeacherLoginController());

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
              ContainerImage(
                  height: 340.h,
                  width: double.infinity,
                  imagePath: 'assets/images/Login_screen.png'),
              Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Enter Mail id Session >>>>>>>
                    Padding(
                      padding: EdgeInsets.only(right: 140.w, left: 10.w),
                      child: GoogleMonstserratWidgets(
                        fontsize: 25.w,
                        text: 'Teacher Login'.tr,
                        color: cblack,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5,
                      ),
                    ),
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
                            teacherLoginController.emailIdController,
                        function: checkFieldEmailIsValid),
                    // Enter Password session >>>>>>>>
                    Obx(
                      () => SigninTextFormfield(
                        hintText: 'Password'.tr,
                        obscureText: hideGetxController.isObscurefirst.value,
                        labelText: 'Password',
                        icon: Icons.lock,
                        textEditingController:
                            teacherLoginController.passwordController,
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
                    kHeight10,
                    Padding(
                      padding: EdgeInsets.only(left: 210.w),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  const ForgotPasswordScreen(),
                            ),
                          );
                        },
                        child: GooglePoppinsWidgets(
                          fontsize: 16,
                          text: 'Forgot Password?'.tr,
                          fontWeight: FontWeight.w400,
                          color: adminePrimayColor,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 60.h),
                      child: GestureDetector(
                        onTap: () {
                          teacherLoginController.signIn(context);
                        },
                        child: Obx(
                          () => teacherLoginController.isLoading.value
                              ? circularProgressIndicatotWidget
                              : loginButtonWidget(
                                  height: 60,
                                  width: 180,
                                  text: 'Login'.tr,
                                ),
                        ),
                      ),
                    ),
                    kHeight20,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GooglePoppinsWidgets(
                            text: "Don't Have an account?".tr, fontsize: 15),
                        GestureDetector(
                          onTap: () {
                            Get.to(()=>TeachersSignUpScreen(
                              pageIndex: 3,
                            ));
                          },
                          child: GooglePoppinsWidgets(
                            text: ' Sign Up'.tr,
                            fontsize: 19,
                            color: cblue,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
