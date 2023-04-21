import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:dujo_kerala_application/view/widgets/fonts/google_poppins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../widgets/container_image.dart';
import '../../../../widgets/fonts/google_monstre.dart';

class UserLoginDesgin extends StatelessWidget {
  const UserLoginDesgin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       SizedBox(
            height: 60,
            child: Row(
              children: [
                ContainerImage(
                    height: 50.h,
                    width: 50.w,
                    imagePath: 'assets/images/leptonlogo.png'),
                GoogleMonstserratWidgets(
                  text: 'Lepton Dujo',
                  fontsize: 17,
                  letterSpacing: 1,
                  fontWeight: FontWeight.w800,
                ),
              ],
            ),
          ),
        kHeight20,
        Padding(
      padding: const EdgeInsets.only(left: 20),
          child: GooglePoppinsWidgets(
            fontsize: 28,
            fontWeight: FontWeight.w700,
            text: 'Welcome..',
          ),
        ),
        kHeight10,
        Center(
          child: GooglePoppinsWidgets(
            fontsize: 23,
            fontWeight: FontWeight.w500,
            text: 'Select Who You Are ?',
          ),
        ),
        kHeight10,
        Center(
            child: ContainerImage(
                height: 300,
                width: double.infinity.w,
                imagePath: 'assets/images/select_user (1).png'))
      ],
    );
  }
}