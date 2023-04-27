import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../view/colors/colors.dart';
import '../view/widgets/fonts/google_poppins.dart';
import '../widgets/Iconbackbutton.dart';

class Heading_Container_Widget extends StatelessWidget {
  const Heading_Container_Widget({
    super.key,
    required this.text
  });
final String text;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
         
          width: double.infinity,
          height: 70,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12.h),bottomRight: Radius.circular(12.h)),
              color: adminePrimayColor
              ),
              child:Column(
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButtonBackWidget(color: cWhite,)
                  ],),
                  Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GooglePoppinsWidgets(text: text, fontsize: 34.h,color: Colors.white,),
                    ],
                  ),
                ],
              ),
        ),
      ],
    );
  }
}
