// ignore_for_file: must_be_immutable

import 'package:dujo_kerala_application/ui%20team/abin/Homework/chat_interface_std.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:dujo_kerala_application/view/widgets/container_image.dart';
import 'package:dujo_kerala_application/view/widgets/fonts/google_monstre.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';


class PopUpcontainerWidget extends StatelessWidget {
   PopUpcontainerWidget({
  
    required this.text,
    required this.text1,
    required this.text2,
    super.key,

  });
  
  String text;
  String text1;
  String text2;

  @override
  Widget build(BuildContext context) {
    return Container(
          height: 320.h,
      width: double.infinity-10,
       margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
      decoration: const BoxDecoration(
              color: cgrey,
              borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          kHeight20,
          ContainerImage(
            imagePath: 'assets/images/leptonlogo.png',
            height: 90.h,
            width: 120.w,
          ),
          kWidth20,
          GoogleMonstserratWidgets(text: text, fontsize: 18,fontWeight: FontWeight.w600,color: cWhite),
          kHeight20,
          GoogleMonstserratWidgets(
              text: text1, fontsize: 18,fontWeight: FontWeight.w700,color: cWhite),
          kHeight20,
         
           InkWell(
     onTap: () {
       Navigator.push(context,
           MaterialPageRoute(builder: ((context) => const SubjectChat())));
     },
     child: Container(
       width: 240.w,
       margin: EdgeInsets.only(left: 35.w),
       child: Row(
         children: [
           SvgPicture.asset(
             'assets/icons/chat (2).svg',
             height: 40.h,
             width: 40.w,
             //color: cblack,
           ),
           GoogleMonstserratWidgets(
             text: text2,
             fontsize: 18,
             color: cWhite,
           )
         ],
       ),
     ),
              )
        ],
      ),
    );
  }
}
