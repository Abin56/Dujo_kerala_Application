// ignore_for_file: file_names

import 'package:dujo_kerala_application/view/widgets/container_image.dart';
import 'package:dujo_kerala_application/view/widgets/fonts/google_monstre.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreenDesign extends StatelessWidget {
  const LoginScreenDesign({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500.h,
      width: double.infinity.w,
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            Container(
              height: 90,
              width: 90,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/costech-logo-90x90.png'),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GoogleMonstserratWidgets(
                  text: 'COSTECH',
                  fontsize: 20,
                  color: const Color.fromARGB(255, 230, 18, 3),
                  fontWeight: FontWeight.bold,
                ),
                GoogleMonstserratWidgets(
                  text: ' DuJo',
                  fontsize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
              Text('''                              Kerala State Co-Operative
                           Institute of Information Technology
                           Electronics & Communications Ltd No. 4435
              ''',style: TextStyle(fontSize: 12
              .sp,fontWeight: FontWeight.bold),),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ContainerImage(
                  height: 80.h,
                  width: 200.w,
                  imagePath: 'assets/images/dujo top login.png'),
            ),
            ContainerImage(
                height: 200.h,
                width: double.infinity.w,
                imagePath: 'assets/images/leptondujobg.png'),
          ],
        ),
      ),
    );
  }
}
