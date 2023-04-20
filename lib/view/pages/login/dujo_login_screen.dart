import 'package:dujo_kerala_application/view/pages/login/widgets/login_screenDegin.dart';
import 'package:dujo_kerala_application/view/widgets/fonts/google_monstre.dart';
import 'package:dujo_kerala_application/view/widgets/fonts/google_poppins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../colors/colors.dart';
import '../../fonts/fonts.dart';
import '../../widgets/login_button.dart';

class DujoLoginScren extends StatelessWidget {
  const DujoLoginScren({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          const LoginScreenDesign(),
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GoogleMonstserratWidgets(
                    text: 'Hello..',
                    letterSpacing: 2,
                    fontsize: 30,
                    fontWeight: FontWeight.w500,
                  ),
                  loginButtonWidget(
                 text: 'Login',)
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}

