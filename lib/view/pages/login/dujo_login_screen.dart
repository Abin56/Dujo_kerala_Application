import 'package:dujo_kerala_application/view/pages/login/widgets/login_screenDegin.dart';
import 'package:dujo_kerala_application/view/widgets/fonts/google_monstre.dart';
import 'package:dujo_kerala_application/view/widgets/fonts/google_poppins.dart';
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
            height: 10,
          ),
          const LoginScreenDesign(),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GoogleMonstserratWidgets(
                  text: 'Welcome To'.tr,
                  letterSpacing: 2,
                  fontsize: 25,
                  fontWeight: FontWeight.w500,
                ),
                 Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GoogleMonstserratWidgets(
                  text: 'COSTECH',
                  fontsize: 25,
                  color: const Color.fromARGB(255, 230, 18, 3),
                  fontWeight: FontWeight.bold,
                ),
                GoogleMonstserratWidgets(
                  text: ' DuJo',
                  fontsize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => SearchSchoolScreen());
                  },
                  child: loginButtonWidget(
                    height: 60,
                    width: 180,
                    text: 'Login'.tr,
                  ),
                ),
                
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GooglePoppinsWidgets(text: "Developed by", fontsize: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 32,
                          width: 32,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/leptonlogo.png'))),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: GoogleMonstserratWidgets(
                              text: "Lepton Communications",
                              fontsize: 13,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}
