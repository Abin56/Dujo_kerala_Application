import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/model/exam_list_model/add_ex_timeTable.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/get_utils.dart';

import '../../../../controllers/userCredentials/user_credentials.dart';
import '../../../../sruthi/Exam Notification/Teacher_Upload/exm_teacher_upload.dart';
import '../../../constant/sizes/sizes.dart';
import '../../../widgets/fonts/google_poppins.dart';

class UsersExamTimeTableViewScreen extends StatelessWidget {
  String collectionName;
  String date;
  String examID;
  String examName;
  UsersExamTimeTableViewScreen(
      {required this.collectionName,
      required this.date,
      required this.examID,
      required this.examName,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Exam Time Table'.tr),backgroundColor: adminePrimayColor,),
      body: SafeArea(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('SchoolListCollection')
                .doc(UserCredentialsController.schoolId)
                .collection(UserCredentialsController.batchId!)
                .doc(UserCredentialsController.batchId!)
                .collection('classes')
                .doc(UserCredentialsController.classId)
                .collection(collectionName)
                .doc(examID)
                .collection('subjects')
                .orderBy('examDate', descending: false)
                .snapshots(),
            builder: (context, snaps) {
              if (snaps.hasData) {
                if (snaps.data!.docs.isEmpty) {
                  return Center(
                    child: GooglePoppinsWidgets(
                        text: "No Records Found".tr, fontsize: 20),
                  );
                } else {
                  return Column(
                    children: [
                      kHeight20,
                      Padding(
                        padding: EdgeInsets.only(left: 13.h, right: 13.h),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GooglePoppinsWidgets(
                                  text: examName,
                                  fontsize: 21.h,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                            GooglePoppinsWidgets(
                              text: "Date :$date",
                              fontsize: 21.h,
                              fontWeight: FontWeight.w500,
                            ),
                          ],
                        ),
                      ),
                      kHeight20,
                      Expanded(
                        child: ListView.separated(
                            itemCount: snaps.data!.docs.length,
                            separatorBuilder: ((context, index) {
                              return kHeight10;
                            }),
                            itemBuilder: (BuildContext context, int index) {
                              final data = AddExamTimeTableModel.fromMap(
                                  snaps.data!.docs[index].data());
                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border(
                                          left: BorderSide(
                                            color: containerColor[
                                                index], // set your desired color here
                                            width:
                                                4, // set your desired width here
                                          ),
                                        ),
                                      ),
                                      child: ListTile(
                                        shape: const BeveledRectangleBorder(
                                            side: BorderSide(
                                                color: Colors.grey,
                                                width: 0.2)),
                                        title: GooglePoppinsWidgets(
                                          text: data.subject,
                                          fontsize: 21.h,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        subtitle: Padding(
                                          padding: EdgeInsets.only(top: 10.h),
                                          child: GooglePoppinsWidgets(
                                              text:
                                                  'Duration : ${data.hours}',
                                              fontsize: 14.h),
                                        ),
                                        trailing: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(top: 05.h),
                                              child: GooglePoppinsWidgets(
                                                text: data.examDate,
                                                fontsize: 15.h,
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(top: 05.h),
                                              child: GooglePoppinsWidgets(
                                                  text:
                                                      '${data.startingtime} to ${data.endingtime}',
                                                  fontsize: 15.h,
                                                  fontWeight:
                                                      FontWeight.w300),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }),
                      ),
                    ],
                  );
                }
              } else {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }
            }),
      ),
    );
  }
}
