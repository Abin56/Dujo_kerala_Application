import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:dujo_kerala_application/view/widgets/fonts/google_monstre.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/get_utils.dart';

import '../../../model/fees_bills_model/fees_model.dart';
import '../../../model/student_model/data_base_model.dart';
import 'widgets/fee_tile_widget.dart';

class ViewFeeDetails extends StatelessWidget {
  const ViewFeeDetails({
    super.key,
    required this.feesModel,
    required this.addStudentModel,
  });
  final FeesModel feesModel;
  final AddStudentModel addStudentModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: adminePrimayColor,
          title: GoogleMonstserratWidgets(
              text: 'View Fee Details'.tr, fontsize: 18.w),
        ),
        body: Center(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(10),
            children: [
              ViewFeeContainerTile(
                text: 'Student Name ' ' : ${addStudentModel.studentName}',
              ),
              ViewFeeContainerTile(
                text: 'Fee : ${feesModel.feesName}',
              ),
              ViewFeeContainerTile(
                text: 'Amount : ${feesModel.amount}',
              ),
              ViewFeeContainerTile(
                text: 'Due Date : ${feesModel.dueDate}',
              ),
              ViewFeeContainerTile(
                text: 'Period : ${feesModel.feePeriod}',
              ),
              kHeight40,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: GestureDetector(
                        onTap: () {},
                        child: const FeeButtonWidget(
                          text: 'Pay Online',
                          color: Color.fromARGB(255, 83, 212, 87),
                        )),
                  ),
                  kWidth10,
                  Expanded(
                    child: GestureDetector(
                        onTap: () {},
                        child: const FeeButtonWidget(
                          text: 'Pay Offline',
                          color: Colors.red,
                        )),
                  )
                ],
              )
            ],
          ),
        ));
  }
}

class FeeButtonWidget extends StatelessWidget {
  const FeeButtonWidget({
    required this.text,
    required this.color,
    super.key,
  });
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 190,
      height: 62.h,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(5.w)),
          border: Border.all(width: 0.09)),
      child: Center(
          child: GoogleMonstserratWidgets(
        text: text,
        color: cWhite,
        fontsize: 14.w,
        fontWeight: FontWeight.w600,
      )),
    );
  }
}
