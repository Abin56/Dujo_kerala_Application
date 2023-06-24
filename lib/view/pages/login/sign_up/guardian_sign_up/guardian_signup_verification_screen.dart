import 'package:dropdown_search/dropdown_search.dart';
import 'package:dujo_kerala_application/model/Text_hiden_Controller/password_field.dart';
import 'package:dujo_kerala_application/utils/utils.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/constant/sizes/constant.dart';
import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:dujo_kerala_application/view/pages/login/users_login_screen/guardian_login/guardian_login.dart';
import 'package:dujo_kerala_application/view/widgets/container_image.dart';
import 'package:dujo_kerala_application/view/widgets/fonts/google_poppins.dart';
import 'package:dujo_kerala_application/view/widgets/textformfield_login.dart';
import 'package:dujo_kerala_application/widgets/login_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../controllers/userCredentials/user_credentials.dart';
import '../../../../../controllers/sign_up_controller/guardian_signup_controller.dart';
import '../../../../../model/guardian_model/guardian_model.dart';
import '../../userVerify_Phone_OTP/get_otp..dart';

class GuardianSignUpFirstScreen extends StatelessWidget {
  final int pageIndex;
  final PasswordField hideGetxController = Get.find<PasswordField>();
  GuardianSignUpFirstScreen({required this.pageIndex, super.key});

  final formKey = GlobalKey<FormState>();
  final GuardianSignUpController guardianSignUpController =
      Get.put(GuardianSignUpController());

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await guardianSignUpController.getAllGuardian();
    });

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
            Obx(() => guardianSignUpController.isLoading.value
                ? circularProgressIndicatotWidget
                : SizedBox(
                    height: 60.h,
                    width: 350.w,
                    child: guardianSignUpController.isLoading.value
                        ? circularProgressIndicatotWidget
                        : DropdownSearch<GuardianModel>(
                            selectedItem:
                                GuardianModel(guardianName: "Select Guardian"),
                            validator: (v) =>
                                v == null ? "required field" : null,
                            items: guardianSignUpController.guardianModelList,
                            itemAsString: (GuardianModel u) =>
                                u.guardianName ?? "",
                            onChanged: (value) {
                              UserCredentialsController.guardianModel = value;
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
                      hintText: 'Email ID',
                      labelText: 'Enter Mail ID',
                      prefixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.mail_outline,
                        ),
                      ),
                      textEditingController:
                          guardianSignUpController.emailController,
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
                      hintText: 'Password',
                      obscureText: hideGetxController.isObscurefirst.value,
                      labelText: 'Password',
                      icon: Icons.lock,
                      textEditingController:
                          guardianSignUpController.passwordController,
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
                          guardianSignUpController.confirmPasswordController,
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
                          if (guardianSignUpController
                                  .passwordController.text.trim() !=
                              guardianSignUpController
                                  .confirmPasswordController.text.trim()) {
                            showToast(msg: "Password Missmatch");
                            return;
                          }

                          if (formKey.currentState!.validate()) {
                            if (UserCredentialsController
                                    .guardianModel?.guardianPhoneNumber !=
                                null) {
                              Get.to(() => UserSentOTPScreen(
                                    userpageIndex: pageIndex,
                                    phoneNumber:
                                        "+91${UserCredentialsController.guardianModel?.guardianPhoneNumber}",
                                    userEmail: guardianSignUpController
                                        .emailController.text.trim(),
                                    userPassword: guardianSignUpController
                                        .passwordController.text.trim(),
                                  ));
                            } else {
                              showToast(msg: "Please select Guardian detail.");
                            }
                          }
                        },
                        child: Obx(
                          () => guardianSignUpController.isLoading.value
                              ? circularProgressIndicatotWidget
                              : loginButtonWidget(
                                  height: 60,
                                  width: 180,
                                  text: 'Submit',
                                ),
                        )),
                  ),
                   const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
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
                          Get.to(()=>GuardianLoginScreen(
                            pageIndex: 3,
                          ));
                        },
                        child: Text(
                          "Login",
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
