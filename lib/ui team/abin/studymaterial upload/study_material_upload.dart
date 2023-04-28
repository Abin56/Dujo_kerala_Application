import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:dujo_kerala_application/view/widgets/buttonWidget.dart';
import 'package:dujo_kerala_application/view/widgets/fonts/google_monstre.dart';
import 'package:dujo_kerala_application/view/widgets/fonts/google_poppins.dart';
import 'package:dujo_kerala_application/view/widgets/textformfield_login.dart';
import 'package:dujo_kerala_application/widgets/login_button.dart';
import 'package:dujo_kerala_application/widgets/textformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../view/colors/colors.dart';
import '../../../widgets/Iconbackbutton.dart';

class StudyMaterialUpload extends StatelessWidget {
  const StudyMaterialUpload({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(resizeToAvoidBottomInset: false,
      backgroundColor: cWhite,
      appBar: AppBar( title: Row(
          children: [            
            IconButtonBackWidget(color: cblack),SizedBox(width: 50.h,),
            GoogleMonstserratWidgets(text: "Study Material upload", fontsize: 20.h,color: cblack,fontWeight: FontWeight.w600,)
          ],
        ),backgroundColor: cWhite),
    body: Column(mainAxisAlignment: MainAxisAlignment.center,
      children: [
      StudyContainerWidget(
        hintText: 'Subject Name',
        hintText1: 'Enter Chapter Name',
        hintText2:'Enter Topic',
      hintText3:'Enter Title Name',
      
       ),
    ]),);
  }
}

class StudyContainerWidget extends StatelessWidget {
   StudyContainerWidget({
    required this.hintText,
    required this.hintText1,
    required this.hintText2,
    required this. hintText3,


    super.key,
  });
  String hintText;
  String hintText1;
  String hintText2;
  String hintText3;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 15.h,right: 15.h),
      height: 600.h,
      width: double.infinity,
      decoration: BoxDecoration(color: Color.fromARGB(255, 71, 73, 167),
      borderRadius: BorderRadius.all(
        Radius.circular(20.h))
        ),
        child: Column(children: [
            TextFormFieldWidget(hintText: hintText,
           // textEditingController: 
            ),
             TextFormFieldWidget(hintText: hintText1,
             //textEditingController:
              ),
              TextFormFieldWidget(hintText: hintText2,
              //textEditingController: 
              ),
              TextFormFieldWidget(hintText: hintText3,
             // textEditingController: 
              ),

              kHeight20,

             UploadButtonWidget(text: 'Upload Doc'),
              kHeight20,
              UploadButtonWidget(text: 'Submit'),


          ]),
        );
  }
}

