// ignore_for_file: camel_case_types, file_names

import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/widgets/container_image.dart';
import 'package:dujo_kerala_application/view/widgets/fonts/google_poppins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class leptonDujoWidget extends StatelessWidget {
  const leptonDujoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
             mainAxisAlignment: MainAxisAlignment.start,
             children: [
           ContainerImage(
               height: 60.h,
               width: 60.w,
               imagePath: 'assets/images/leptonlogo.png'),
           GooglePoppinsWidgets(
             text: "Lepton DuJo",
             fontsize: 15,
             color: cred,
             fontWeight: FontWeight.w600,
           ),
             ],
           );
  }
}