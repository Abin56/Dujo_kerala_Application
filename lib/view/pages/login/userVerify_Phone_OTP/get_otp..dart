// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable, file_names, camel_case_types

import 'dart:developer';
import 'package:dujo_kerala_application/view/pages/login/userVerify_Phone_OTP/verify_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../../controllers/bloc/user_phone_otp/auth_cubit.dart';
import '../../../../controllers/bloc/user_phone_otp/auth_state.dart';

class UserSentOTPScreen extends StatelessWidget {
  int userpageIndex;
  var phoneNumber;
  var userEmail;
  var userPassword;
  UserSentOTPScreen(
      {required this.phoneNumber,
      required this.userpageIndex,
      required this.userPassword,
      required this.userEmail,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: ListView(
        children: [
          Center(
            child: Column(
              children: [
                LottieBuilder.asset('assets/images/otpverfication.json'),
                const Text(
                  'Phone Verification',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text('We need to register your phone before getting'),
                const SizedBox(
                  height: 10,
                ),
                const Text('started!'),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is AuthCodeSentState) {
                      Get.to(()=>UserVerifyOTPScreen(
                          userpageIndex: userpageIndex,
                          phoneNumber: phoneNumber,
                          userEmail: userEmail,
                          userPassword: userPassword));
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
                            // ignore: deprecated_member_use
                            primary: Colors.green.shade600),
                        onPressed: () async {
                          BlocProvider.of<AuthCubit>(context)
                              .sentOTP(phoneNumber);
                          log(phoneNumber);
                        },
                        child: const Text('Send OTP'));
                  },
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
