// ignore_for_file: must_be_immutable

import 'package:dropdown_search/dropdown_search.dart';
import 'package:dujo_kerala_application/controllers/sign_up_controller/sign_up_controller.dart';
import 'package:dujo_kerala_application/model/Text_hiden_Controller/password_field.dart';
import 'package:dujo_kerala_application/utils/utils.dart';
import 'package:dujo_kerala_application/view/constant/sizes/constant.dart';
import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:dujo_kerala_application/view/widgets/Leptonlogoandtext.dart';
import 'package:dujo_kerala_application/view/widgets/container_image.dart';
import 'package:dujo_kerala_application/widgets/login_button.dart';
import 'package:dujo_kerala_application/view/widgets/textformfield_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../../controllers/userCredentials/user_credentials.dart';
import '../../../../../../model/student_model/student_model.dart';
import '../../../userVerify_Phone_OTP/get_otp..dart';

class StudentSignInScreen extends StatelessWidget {
  int pageIndex;
  PasswordField hideGetxController = Get.find<PasswordField>();
  StudentSignInScreen({required this.pageIndex, super.key});

  final formKey = GlobalKey<FormState>();
  StudentSignUpController studentSignUpController =
      Get.put(StudentSignUpController());

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
                            studentName: 'Select Student',
                            studentemail: '',
                            uid: '',
                            whichClass: '',
                            docid: ''),
                        validator: (v) => v == null ? "required field" : null,
                        items: studentSignUpController.classWiseStudentList,
                        itemAsString: (StudentModel u) => u.studentName,
                        onChanged: (value) {
                          UserCredentialsController.studentModel = value;
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

                        if (formKey.currentState!.validate()) {
                          if (UserCredentialsController
                                  .studentModel?.parentPhoneNumber !=
                              null) {
                            Get.to(() => UserSentOTPScreen(
                                  userpageIndex: pageIndex,
                                  phoneNumber:
                                      "+91${UserCredentialsController.studentModel?.parentPhoneNumber}",
                                  userEmail: studentSignUpController
                                      .emailController.text,
                                  userPassword: studentSignUpController
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
