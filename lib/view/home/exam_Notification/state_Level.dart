import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/widgets/fonts/google_poppins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controllers/userCredentials/user_credentials.dart';
import '../../../model/exam_list_model/exam_list.model.dart';
import '../../constant/sizes/constant.dart';
import 'list_of_exam/time_table_view.dart';

class StateLevel extends StatelessWidget {
  const StateLevel({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('SchoolListCollection')
                .doc(UserCredentialsController.schoolId)
                .collection(UserCredentialsController.batchId!)
                .doc(UserCredentialsController.batchId!)
                .collection('Public Level')
                .snapshots(),
            builder: (context, snaps) {
              if (snaps.hasData) {
                if (snaps.data!.docs.isEmpty) {
                  return Center(
                    child: GooglePoppinsWidgets(
                        text: 'No Records Found'.tr, fontsize: 20),
                  );
                } else {
                  return ListView.separated(
                      itemBuilder: (context, index) {
                        final data = AddExamModel.fromMap(
                            snaps.data!.docs[index].data());
                        return GestureDetector(
                          onTap: () {
                            Get.to(TeacherExamTimeTableViewScreen(
                                examID: data.docid,
                                collectionName: 'Public Level',
                                date: stringTimeToDateConvert(data.publishDate),
                                examName: data.examName));
                          },
                          child: Container(
                              margin: EdgeInsets.only(
                                  top: 10.h, left: 10.h, right: 10.h),
                              height: 135.h,
                              width: 80.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.h),
                                color: adminePrimayColor,
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(top: 12.h, left: 20.w),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //  Text(data.examName),
                                    GooglePoppinsWidgets(
                                        text: "Exam Name  :   ${data.examName}",
                                        fontsize: 16.h,
                                        color: cWhite),
                                    SizedBox(
                                      height: 5.w,
                                    ),
                                    GooglePoppinsWidgets(
                                      text:
                                          "Published date :  ${stringTimeToDateConvert(data.publishDate)}",
                                      fontsize: 14.h,
                                      color: cWhite,
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    GooglePoppinsWidgets(
                                        text:
                                            "Starting date :  ${data.startingDate}",
                                        fontsize: 14.h,
                                        color: cWhite),
                                    GooglePoppinsWidgets(
                                        text: "Ending date :  ${data.endDate}",
                                        fontsize: 14.h,
                                        color: cWhite),
                                  ],
                                ),
                              )),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider();
                      },
                      itemCount: snaps.data!.docs.length);
                }
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}
