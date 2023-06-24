import 'package:dropdown_search/dropdown_search.dart';
import 'package:dujo_kerala_application/model/Text_hiden_Controller/password_field.dart';
import 'package:dujo_kerala_application/model/parent_model/parent_model.dart';
import 'package:dujo_kerala_application/utils/utils.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/constant/sizes/constant.dart';
import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:dujo_kerala_application/view/pages/login/users_login_screen/parent_login/parent_login.dart';
import 'package:dujo_kerala_application/view/widgets/container_image.dart';
import 'package:dujo_kerala_application/view/widgets/fonts/google_poppins.dart';
import 'package:dujo_kerala_application/view/widgets/textformfield_login.dart';
import 'package:dujo_kerala_application/widgets/login_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../controllers/userCredentials/user_credentials.dart';
import '../../../../../controllers/sign_up_controller/parent_sign_up_controller.dart';
import '../../userVerify_Phone_OTP/get_otp..dart';

class ParentSignUpFirstScreen extends StatelessWidget {
  final int pageIndex;
  final PasswordField hideGetxController = Get.find<PasswordField>();
  ParentSignUpFirstScreen({required this.pageIndex, super.key});

  final formKey = GlobalKey<FormState>();
  final ParentSignUpController parentSignUpController =
      Get.put(ParentSignUpController());

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await parentSignUpController.getAllParent();
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
            Obx(() => parentSignUpController.isLoading.value
                ? circularProgressIndicatotWidget
                : SizedBox(
                    height: 60.h,
                    width: 350.w,
                    child: parentSignUpController.isLoading.value
                        ? circularProgressIndicatotWidget
                        : DropdownSearch<ParentModel>(
                            selectedItem:
                                ParentModel(parentName: "Select Parent".tr),
                            validator: (v) =>
                                v == null ? "required field" : null,
                            items: parentSignUpController.parentModelList,
                            itemAsString: (ParentModel u) => u.parentName ?? "",
                            onChanged: (value) {
                              UserCredentialsController.parentModel = value;
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
                          parentSignUpController.emailController,
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
                          parentSignUpController.passwordController,
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
                          parentSignUpController.confirmPasswordController,
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
                        if (parentSignUpController.passwordController.text.trim() !=
                            parentSignUpController
                                .confirmPasswordController.text.trim()) {
                          showToast(msg: "Password Missmatch".tr);
                          return;
                        }

                        if (formKey.currentState!.validate()) {
                          if (UserCredentialsController
                                  .parentModel?.parentPhoneNumber !=
                              null) {
                            Get.to(() => UserSentOTPScreen(
                                  userpageIndex: pageIndex,
                                  phoneNumber:
                                      "+91${UserCredentialsController.parentModel?.parentPhoneNumber}",
                                  userEmail: parentSignUpController
                                      .emailController.text.trim(),
                                  userPassword: parentSignUpController
                                      .passwordController.text.trim(),
                                ));
                          } else {
                            showToast(msg: "Please select parent detail.");
                          }
                        }
                      },
                      child: Obx(() =>  parentSignUpController.isLoading.value
                          ? circularProgressIndicatotWidget
                          : loginButtonWidget(
                              height: 60,
                              width: 180,
                              text: 'Submit'.tr,
                            ),)
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
                          Get.to(()=>ParentLoginScreen(
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
