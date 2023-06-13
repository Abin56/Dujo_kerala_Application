import 'package:dujo_kerala_application/sruthi/widget/exm_upload_textformfeild.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:dujo_kerala_application/view/widgets/button_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SubjectUploading extends StatelessWidget {
  const SubjectUploading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: const [
            Text("Subject Upload "),
          ],
        ),
        backgroundColor: adminePrimayColor,
      ),
      body: Column(
        children: [
          kHeight20,
          ExamUploadTextFormFeild(text: "Teacher's Name", hintText: "Name"),
          kHeight20,
          ExamUploadTextFormFeild(
              text: "Subject Name", hintText: "Subject Name"),
          kHeight20,
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
        ],
      ),
    );
  }
}
