import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:dujo_kerala_application/controllers/sign_up_controller/guardian_signup_controller.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:dujo_kerala_application/model/student_model/student_model.dart';
import 'package:dujo_kerala_application/utils/utils.dart';
import 'package:dujo_kerala_application/view/constant/sizes/constant.dart';
import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:dujo_kerala_application/view/pages/login/userVerify_Phone_OTP/get_otp..dart';
import 'package:dujo_kerala_application/view/widgets/Leptonlogoandtext.dart';
import 'package:dujo_kerala_application/view/widgets/container_image.dart';
import 'package:dujo_kerala_application/view/widgets/textformfield_login.dart';
import 'package:dujo_kerala_application/widgets/login_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../controllers/sign_up_controller/student_sign_up_controller.dart';
import '../../../../../model/Text_hiden_Controller/password_field.dart';

class GuardianSignInScreen extends StatelessWidget {
  int pageIndex;
  PasswordField hideGetxController = Get.find<PasswordField>();
  GuardianSignInScreen({required this.pageIndex, super.key});

  final guardianFormKey = GlobalKey<FormState>();
  StudentSignUpController studentSignUpController =
      Get.put(StudentSignUpController()); 
  GuardianController guardianController = Get.put(GuardianController());

      String? wardDetail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            const leptonDujoWidget(),
            //  kHeight20,
            ContainerImage(
              height: 250.h,
              width: double.infinity,
              imagePath: 'assets/images/splash.png',
            ),
            kHeight30,
            Obx(() => studentSignUpController.isLoading.value
                ? circularProgressIndicatotWidget
                : SizedBox(
                    height: 60.h,
                    width: 350.w,
                    child: DropdownSearch<StudentModel>(
                        selectedItem: StudentModel(
                          admissionNumber: "",
                          alPhoneNumber: "",
                          bloodgroup: "",
                          createDate: "",
                          dateofBirth: "",
                          district: "",
                          gender: "",
                          houseName: "",
                          parentPhoneNumber: "",
                          place: "",
                          profileImageId: "",
                          profileImageUrl: '',
                          studentName: 'Select Your Ward',
                          studentemail: '',
                          uid: '',
                          docid: '',
                          userRole: '',
                          classId: '',
                          guardianId: '',
                          parentId: '',
                        ),
                        validator: (v) => v == null ? "required field" : null,
                        items: guardianController.classWiseStudentList,
                        itemAsString: (StudentModel u) => u.studentName,
                        onChanged: (value) {
                          UserCredentialsController.studentModel = value; 
                          wardDetail = value!.parentPhoneNumber; 
                          
                          log('wardDetail:${wardDetail!}'); 
                        }),
                  )),
            kHeight30,
            Form(
              key: guardianFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  kHeight10,
                  SigninTextFormfield(
                      obscureText: false,
                      hintText: 'Email id',
                      labelText: 'Enter Mail ID',
                      prefixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.mail_outline,
                        ),
                      ),
                      textEditingController:
                          studentSignUpController.emailController,
                      function: checkFieldEmailIsValid),
                  Obx(
                    () => SigninTextFormfield(
                      hintText: 'Password',
                      obscureText: hideGetxController.isObscurefirst.value,
                      labelText: 'Password',
                      icon: Icons.lock,
                      textEditingController:
                          studentSignUpController.passwordController,
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
                      hintText: 'Confirm Password',
                      obscureText: hideGetxController.isObscureSecond.value,
                      labelText: 'Confirm Password',
                      icon: Icons.lock,
                      textEditingController:
                          studentSignUpController.confirmPasswordController,
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
                      onTap: () async {
                        if (studentSignUpController.passwordController.text !=
                            studentSignUpController
                                .confirmPasswordController.text) {
                          showToast(msg: "Password Missmatch");
                          return;
                        }

                        if (guardianFormKey.currentState!.validate()) { 
                       // Query<Map<String, dynamic>> querySnapshot = guardianController.finalFirebaseData.where('parentPhoneNumber', isEqualTo: UserCredentialsController.guardianModel?.guardiantPhoneNumber); 
                                  
                           if (wardDetail != '' || wardDetail != null) {
                            Get.to(() => UserSentOTPScreen(
                                  userpageIndex: pageIndex,
                                  phoneNumber:
                                      "+91${wardDetail}",
                                  userEmail: studentSignUpController
                                      .emailController.text,
                                  userPassword: studentSignUpController
                                      .passwordController.text,
                                ));
                          } else {
                            log(wardDetail!);
                            showToast(msg: "Please select student detail.");
                          }
                        }
                        //   if (UserCredentialsController
                        //           .studentModel?.parentPhoneNumber !=
                        //       null) {
                        //     Get.to(() => UserSentOTPScreen(
                        //           userpageIndex: pageIndex,
                        //           phoneNumber:
                        //               "+91${UserCredentialsController.studentModel?.parentPhoneNumber}",
                        //           userEmail: studentSignUpController
                        //               .emailController.text,
                        //           userPassword: studentSignUpController
                        //               .passwordController.text,
                        //         ));
                        //   } else {
                        //     showToast(msg: "Please select student detail.");
                        //   }
                        // }
                      },
                      child: loginButtonWidget(
                        height: 60,
                        width: 180,
                        text: 'Submit',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
