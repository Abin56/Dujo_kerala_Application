import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewExamResultsScreen extends StatelessWidget {
  String classID;
  String examLevel;
  String studentId;
  String examdocid;

  ViewExamResultsScreen(
      {required this.classID,
      required this.examLevel,
      required this.studentId,
      required this.examdocid,
      super.key});

  @override
  Widget build(BuildContext context) {
    int columnCount = 3;
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Exam'.tr),
        backgroundColor: adminePrimayColor,
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('SchoolListCollection')
              .doc(UserCredentialsController.schoolId)
              .collection(UserCredentialsController.batchId!)
              .doc(UserCredentialsController.batchId!)
              .collection('classes')
              .doc(classID)
              .collection('Students')
              .doc(studentId)
              .collection(examLevel)
              .doc(examdocid)
              .collection('Marks')
              .snapshots(),
          builder: (context, snaps) {
            if (snaps.hasData) {
              return ListView.separated(
                  itemBuilder: (context, index) {
                    return SizedBox(
                      height: 40,
                      child: Row(
                        children: [
                          Text('${index + 1}'),
                          kWidth20,
                          Text(snaps.data!.docs[index]['subjectName']),
                          const Spacer(),
                          Text(snaps.data!.docs[index]['obtainedMark']),
                          kWidth10,
                          Text(snaps.data!.docs[index]['obtainedGrade']),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                  itemCount: snaps.data!.docs.length);
            } else {
              return const Text('');
            }
          }),
    );
  }
}
