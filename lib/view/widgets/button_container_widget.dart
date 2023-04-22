// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonContainerWidget extends StatelessWidget {
  double curving;
  int colorindex;
  double height;
  double width;
  Widget child;
  ButtonContainerWidget({
    required this.curving,
    required this.child,
    required this.colorindex,
    required this.height,
    required this.width,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height.h,
      width: width.w,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: containerColor[colorindex].first.withOpacity(0.2),
            blurRadius: 7,
            spreadRadius: 2,
            offset: const Offset(4, 4),
          ),
        ],
        gradient: LinearGradient(
            colors: containerColor[colorindex],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            ),
        borderRadius: BorderRadius.all(
          Radius.circular(curving),
          
        ),
        border: Border.all(
          color: Colors.blueGrey, // set the border color
          width: 1, // set the border width
        ),
      ),
      child: child,
    );
  }
}

const containerColor = [
  [Color.fromARGB(255, 27, 199, 159),Color.fromARGB(255, 202, 141, 161), ],
  [Color.fromARGB(255, 202, 141, 161),Color.fromARGB(255, 55, 124, 158)],
  [Color(0xff6448fe), Color(0xff5fc6ff)],
  [Color(0xfffe6197), Color.fromARGB(255, 159, 94, 25)],
  [Color.fromARGB(107, 2, 141, 64), Color.fromARGB(107, 2, 141, 64)],
  [Color.fromARGB(255, 116, 130, 255), Color.fromARGB(255, 86, 74, 117)],
  [Color.fromARGB(255, 205, 215, 15), Color.fromARGB(255, 224, 173, 22)],
  [Color.fromARGB(255, 208, 104, 105), Color.fromARGB(255, 241, 66, 66)],
  [Color.fromARGB(255, 242, 230, 230), Color.fromARGB(255, 255, 252, 252)]
];