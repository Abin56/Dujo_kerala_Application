import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:dujo_kerala_application/view/widgets/fonts/google_monstre.dart';
import 'package:dujo_kerala_application/view/widgets/fonts/google_poppins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../widgets/container_image.dart';

class UserLoginDesgin extends StatelessWidget {
  const UserLoginDesgin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ContainerImage(
                  height: 100.h,
                  width: 100.w,
                  imagePath: 'assets/images/leptonlogo.png'),
              GoogleMonstserratWidgets(
                text: 'Lepton Dujo',
                fontsize: 20,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
          GooglePoppinsWidgets(
            fontsize: 20,
            fontWeight: FontWeight.w400,
            text: 'Welcome..',
          ),
          kHeight10,
          Center(
            child: GooglePoppinsWidgets(
              fontsize: 20,
              fontWeight: FontWeight.w300,
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
      ),
    );
  }
}