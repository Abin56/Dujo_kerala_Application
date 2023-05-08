import 'package:dujo_kerala_application/sruthi/widget/exm_upload_textformfeild.dart';
import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:dujo_kerala_application/view/widgets/button_container_widget.dart';
import 'package:dujo_kerala_application/widgets/Iconbackbutton.dart';
import 'package:dujo_kerala_application/widgets/textformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../view/colors/colors.dart';


class ChapterUpoload extends StatelessWidget {
  const ChapterUpoload({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
              title: Row(
                children: [
                  IconButtonBackWidget(color: cWhite,),
                
                  Text("Chapter Upload "),
                ],
              ),
              backgroundColor: adminePrimayColor,
            ),
            body: Column(children: [kHeight20,
                 ExamUploadTextFormFeild(text: "Chapter No.", hintText: "Chapter Number"),kHeight20,
               ExamUploadTextFormFeild(text: "Chapter Name", hintText: "Chapter Name"),kHeight20,
                ExamUploadTextFormFeild(text: "Subject Name", hintText: "Subject Number"),kHeight20,
                 ButtonContainerWidget(
                          curving: 18,
                          colorindex: 2,
                          height: 70.h,
                          width: 300.w,
                          child: Center(
                            child: Text(
                              "SUBMIT",
                              style: GoogleFonts.montserrat(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
            ],),

    );
  }
}