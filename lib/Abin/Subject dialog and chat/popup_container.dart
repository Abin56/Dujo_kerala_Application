
import 'package:dujo_kerala_application/ui%20team/abin/Subject%20dialog%20and%20chat/popup_containerwidget.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/widgets/fonts/google_monstre.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class PopUpContainer extends StatelessWidget {
  const PopUpContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
    //  margin: EdgeInsets.only(top: 50.h),
      height:  350.h,
      width: 570.w,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Column(
        children: [
          Column(
           children: [
             PopUpcontainerWidget(
               text1: 'Email :' + ' lepton@gmail.com', 
               text: 'Name :' + ' Lepton',
               text2: ' Chat with your teacher', 
               ),
           
            TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Container(
            //  color: cblue,
            height: 30.h,
            width: 70.w,
            child: GoogleMonstserratWidgets(text: 'Close',fontsize: 20,color: Colors.red,fontWeight: FontWeight.w700,))
            // Text("Close",style: TextStyle(color: Colors.red))),
        ),
           ],
          ),
        ],
      ),
    );
  }
}

