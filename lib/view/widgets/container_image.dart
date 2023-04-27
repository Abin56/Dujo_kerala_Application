// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContainerImage extends StatelessWidget {
  double height;
  double width;
  String imagePath;

  ContainerImage({
    required this.height,
    required this.width,
    required this.imagePath,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height.h,
      width: width.w,
      decoration:
          BoxDecoration(image: DecorationImage(image: AssetImage(imagePath),fit: BoxFit.fill)),
    );
  }
}
