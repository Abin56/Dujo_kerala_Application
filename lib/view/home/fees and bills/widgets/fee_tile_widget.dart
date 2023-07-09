import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../colors/colors.dart';
import '../../../widgets/fonts/google_monstre.dart';

class ViewFeeContainerTile extends StatelessWidget {
  const ViewFeeContainerTile({
    required this.text,
    super.key,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0.w),
      child: Container(
        width: double.infinity,
        height: 100.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5.w)),
            border: Border.all(width: 0.09)),
        child: Center(
            child: GoogleMonstserratWidgets(
          text: text,
          fontsize: 15.w,
          color: cblack,
          fontWeight: FontWeight.w600,
        )),
      ),
    );
  }
}
