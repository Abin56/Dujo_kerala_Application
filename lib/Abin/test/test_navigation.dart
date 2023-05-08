

import 'package:dujo_kerala_application/Abin/Teacher_studymaterial_upload/study_material_upload.dart';
import 'package:dujo_kerala_application/Abin/teacher%20Homework/homework.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';




class NavigationCheck extends StatelessWidget {
  const NavigationCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(appBar: AppBar(title: Text('dvs')),
    body: Column(
      //crossAxisAlignment: CrossAxisAlignment.start,
    //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        kHeight50,
        Container(height: 250,),
      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
  
       
      kWidth30,
       InkWell(onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: ((context) => HomeWorkUpload())));

      },child: Containerwidget(text: 'Homework upload')),
       ],
      ),
      kHeight20,
       Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
           InkWell(onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: ((context) => StudyMaterialUpload())));

      },child: Containerwidget(text: 'study material upload')),
       
      kWidth30,
      
       ],
      ),
    ]),
    
    );
  }
}

class Containerwidget extends StatelessWidget {
   Containerwidget({
    required this.text,
    super.key,
  });
 String text;
  @override
  Widget build(BuildContext context) {
    return Container(height: 150.h,
    width: 200.w,color: ccblue,
    child: Center(child: Text(text,style: TextStyle(fontSize: 20),)),);
  }
}