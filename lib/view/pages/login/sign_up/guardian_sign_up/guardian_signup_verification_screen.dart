import 'package:dropdown_search/dropdown_search.dart';
import 'package:dujo_kerala_application/model/Text_hiden_Controller/password_field.dart';
import 'package:dujo_kerala_application/model/guardian_model/guardian_model.dart';
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
import '../../../../../controllers/sign_up_controller/guardian_signup_controller.dart';
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
                      hintText: 'Email id',
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
                                  .passwordController.text !=
                              guardianSignUpController
                                  .confirmPasswordController.text) {
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
                                        .emailController.text,
                                    userPassword: guardianSignUpController
                                        .passwordController.text,
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
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
