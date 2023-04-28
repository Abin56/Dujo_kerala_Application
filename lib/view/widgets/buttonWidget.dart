import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UploadButtonWidget extends StatelessWidget {
  const UploadButtonWidget({
    required this.text,
    super.key,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
     height: 60.h, width: 250.w,
    decoration: BoxDecoration( gradient: LinearGradient(
       begin: Alignment.topLeft,
       end: Alignment.bottomCenter,
       colors: [
        cgraident1,  cgraident2
       ],
     ),
     borderRadius: BorderRadius.all(Radius.circular(20))),
     child: Center(child: Text(text,style: TextStyle(color: cWhite,fontWeight: FontWeight.w700,fontSize: 18.h))) ,
    );
  }
}


