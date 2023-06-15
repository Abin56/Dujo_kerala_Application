// ignore_for_file: must_be_immutable

import 'package:dujo_kerala_application/view/widgets/fonts/google_poppins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExamUploadTextFormFeild extends StatelessWidget {
  String text;
  int? maxLines;
  String hintText;
  TextInputType? keyboardType;
  String? Function(String?)? validator;
  // bool readOnly;

  void Function()? onTapFunction;
  ExamUploadTextFormFeild({
    required this.text,
    required this.hintText,
    this.validator,
    this.keyboardType,
    this.textfromController,
    this.onTapFunction,
    // this.readOnly=false,
    this.maxLines,
    super.key,
  });

  final TextEditingController? textfromController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GooglePoppinsWidgets(
              fontsize: 12,
              fontWeight: FontWeight.w300,
              text: text,
            ),
            SizedBox(
              height: 70.h,
              width: double.infinity,
              // color: const Color.fromARGB(255, 211, 225, 236),
              child: Center(
                child: TextFormField(
                  controller: textfromController,
                  validator: validator,

                  // keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: hintText,
                    border: const OutlineInputBorder(),
                    contentPadding: const EdgeInsets.all(7),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
