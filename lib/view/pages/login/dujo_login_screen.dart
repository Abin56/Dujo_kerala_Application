import 'package:dujo_kerala_application/view/pages/login/widgets/login_screenDegin.dart';
import 'package:dujo_kerala_application/view/widgets/fonts/google_monstre.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/login_button.dart';
import '../search/search_school/search_school.dart';

class DujoLoginScren extends StatelessWidget {
  const DujoLoginScren({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          const LoginScreenDesign(),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GoogleMonstserratWidgets(
                  text: 'Hello..'.tr,
                  letterSpacing: 2,
                  fontsize: 30,
                  fontWeight: FontWeight.w500,
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(()=>SearchSchoolScreen());
                  },
                  child: loginButtonWidget(
                    height: 60,
                    width: 180,
                    text: 'Login'.tr,
                  ),
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}
