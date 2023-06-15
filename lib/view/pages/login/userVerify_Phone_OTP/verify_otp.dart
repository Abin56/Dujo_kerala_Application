// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable, deprecated_member_use

import 'dart:developer';

import 'package:dujo_kerala_application/view/constant/sizes/constant.dart';
import 'package:dujo_kerala_application/view/pages/login/sign_up/guardian_sign_up/guardian_signup.dart';
import 'package:dujo_kerala_application/view/pages/login/sign_up/teacher_sign_up/teacher_sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pinput/pinput.dart';

import '../../../../controllers/bloc/user_phone_otp/auth_cubit.dart';
import '../../../../controllers/bloc/user_phone_otp/auth_state.dart';
import '../sign_up/parent_sign_up/parent_sign_up.dart';
import '../sign_up/student_sign_up/student_sign_up.dart';

class UserVerifyOTPScreen extends StatelessWidget {
  int userpageIndex;

  var phoneNumber;
  var userEmail;
  var userPassword;
  final otpController = TextEditingController();
  UserVerifyOTPScreen(
      {required this.userpageIndex,
      required this.phoneNumber,
      required this.userEmail,
      required this.userPassword,
      super.key});

  @override
  Widget build(BuildContext context) {
    log('email>>>>>>>>>>>>>>>>>>>>>>>>$userEmail');
    log('password>>>>>>>>>>>>>>>>>>>>>>>>$userPassword');
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );
    // ignore: unused_local_variable
    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );
    // ignore: unused_local_variable
    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    // ignore: unused_local_variable
    var code = "";
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Center(
              child: Column(
                children: [
                  LottieBuilder.asset(
                      'assets/images/105761-verification-code-otp-v2.json',
                      height: 300),
                  const Text(
                    'Otp Verification',
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                      'We need to register your phone   $phoneNumber  before getting'),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text('started!'),
                  const SizedBox(
                    height: 10,
                  ),
                  Pinput(
                    controller: otpController,
                    length: 6,
                    showCursor: true,
                    onChanged: (value) {
                      code = value;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) async {
                      if (state is AuthLoggedInState) {
                        // FirebaseAuth.instance
                        //     .createUserWithEmailAndPassword(
                        //         email: userEmail, password: userPassword)
                        showDialog(
                          context: context,
                          barrierDismissible: false, // user must tap button!
                          builder: (BuildContext context) {
                            UserEmailandPasswordSaver.userEmail = userEmail;
                            UserEmailandPasswordSaver.userPassword =
                                userPassword;
                            return AlertDialog(
                              title: const Text('Message'),
                              content: SingleChildScrollView(
                                child: ListBody(
                                  children: const <Widget>[
                                    Text('Verification Completed!!'),
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('Ok'),
                                  onPressed: () {
                                    if (userpageIndex == 0) {
                                      Get.off(StudentSignInPageScreen());
                                    } else if (userpageIndex == 1) {
                                      Get.off(ParentSignUpPage());
                                    } else if (userpageIndex == 2) {
                                      Get.off(GuardianSignUp());
                                    } else if (userpageIndex == 3) {
                                      Get.off(TeachersSignUpPage());
                                    }
                                    ///
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      } else if (state is AuthErrorState) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                backgroundColor: Colors.red,
                                duration: Duration(milliseconds: 2000),
                                content: Text("Something Wrong!!!!!")));
                      }
                    },
                    builder: (context, state) {
                      if (state is AuthLoadingState) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            primary: Colors.green.shade600),
                        onPressed: () async {
                          BlocProvider.of<AuthCubit>(context)
                              .verifyOTP(otpController.text);
                        },
                        child: const Text('Verify Phone Number'),
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
