// ignore_for_file: prefer_const_constructors

import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFormFieldWidget extends StatelessWidget {
  TextFormFieldWidget({
    super.key,
    required this.hintText,
    this.textEditingController,
    this.function,
    
  });
 final TextEditingController? textEditingController;
  final String hintText;
  String? Function(String? fieldContent)? function;
 

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(25),
      child: TextFormField(
        validator: function,
        // controller: textEditingController,
        decoration: InputDecoration(
         border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.h)
          ), labelStyle: TextStyle(color: cblack,fontWeight: FontWeight.w600), 
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color.fromARGB(255, 255, 255, 255)), 
    ),
    fillColor: cWhite, 
    filled: true,
        
          hintText: hintText,hintStyle: TextStyle(color: cblack)
        ),
      ),
    );
  }
}
