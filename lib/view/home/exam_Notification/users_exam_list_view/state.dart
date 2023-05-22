import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/model/exam_list_model/exam_list.model.dart';
import 'package:dujo_kerala_application/view/home/exam_Notification/users_exam_list_view/user_exam_list_view.dart';
import 'package:dujo_kerala_application/view/widgets/fonts/google_poppins.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/userCredentials/user_credentials.dart';
import '../../../constant/sizes/constant.dart';
import '../list_of_exam/time_table_view.dart';



class UserStateLevel extends StatelessWidget {
  const UserStateLevel({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('SchoolListCollection')
                .doc(UserCredentialsController.schoolId)
                .collection(UserCredentialsController.batchId!)
                .doc(UserCredentialsController.batchId!)
                .collection('State Level')
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
                            Get.to(UsersExamTimeTableViewScreen(
                                examID: data.docid,
                                collectionName: 'State Level',
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
