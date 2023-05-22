import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/view/constant/sizes/constant.dart';
import 'package:dujo_kerala_application/view/home/exam_Notification/list_of_exam/time_table_view.dart';
import 'package:dujo_kerala_application/view/widgets/fonts/google_poppins.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/userCredentials/user_credentials.dart';
import '../../../model/exam_list_model/exam_list.model.dart';

class PublicLevel extends StatelessWidget {
  const PublicLevel({super.key});

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
                        text: 'No Records Found', fontsize: 20),
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
                          child: SizedBox(
                            height: 100,
                            child: Text(data.examName),
                          ),
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


