import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/constant/sizes/constant.dart';
import 'package:dujo_kerala_application/view/home/exam_Notification/users_exam_list_view/user_exam_list_view.dart';
import 'package:dujo_kerala_application/view/widgets/fonts/google_poppins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../controllers/userCredentials/user_credentials.dart';
import '../../../../model/exam_list_model/exam_list.model.dart';

class UserPublicLevel extends StatelessWidget {
  const UserPublicLevel({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('SchoolListCollection')
                .doc(UserCredentialsController.schoolId)
                .collection(UserCredentialsController.batchId!)
                .doc(UserCredentialsController.batchId!)
                .collection('School Level')
                .snapshots(),
            builder: (context, snaps) {
              if (snaps.hasData) {
                if (snaps.data!.docs.isEmpty) {
                  return Center(
                    child: GooglePoppinsWidgets(
                        text: 'No Records Found'.tr, fontsize: 20.h),
                  );
                } else {
                  return ListView.separated(
                      itemBuilder: (context, index) {
                        final data = AddExamModel.fromMap(
                            snaps.data!.docs[index].data());
                        return GestureDetector(
                          onTap: () {
                            Get.to(()=>UsersExamTimeTableViewScreen(
                                examID: data.docid,
                                collectionName: 'School Level',
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
                                padding:  EdgeInsets.only(top: 12.h,left: 10.h),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                    // Text(data.examName),
                                  children: [
                                                          
                                    GooglePoppinsWidgets(
                                        text:
                                            "Exam Name  :   ${data.examName}",
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
                                      height: 5.w,
                                    ),
                                    GooglePoppinsWidgets(
                                        text:
                                            "Starting date :  ${data.startingDate}",
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
