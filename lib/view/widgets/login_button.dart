 import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../fonts/fonts.dart';

class loginButtonWidget extends StatelessWidget {

  String text;
   loginButtonWidget({
    required this.text,
    super.key,
  });             

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      width: 280.w,
     
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
         color: cblue,),
      child: Center(
        child: Text(
          text,
          style: DGoogleFonts.subhighTextStyle,
        ),
      ),
    );
  }
}
