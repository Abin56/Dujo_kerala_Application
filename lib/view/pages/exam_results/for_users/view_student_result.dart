import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        title: Text('View Results'.tr),
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
              return
                  Padding(
                    padding:  EdgeInsets.all(15.h),
                    child: Container(
                      decoration: BoxDecoration(border: Border.all(width: 1,color:Colors.grey ),
                      borderRadius: BorderRadius.circular(10)),
                         
                          child: Center(
                            child: Column(
                              children: [
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: DataTable(columns: const [
                                    DataColumn(label: Text('S.No')),
                                    DataColumn(label: Text('Subjects')),
                                    DataColumn(label: Text('Mark')),
                                    DataColumn(label: Text('Grade')),
                                  ], rows: [
                                    for (int i = 0;
                                        i <= snaps.data!.docs.length - 1;
                                        i++)
                                      DataRow(cells: [
                                        DataCell(Text('${i + 1}')),
                                        DataCell(Text(snaps.data!.docs[i]
                                            ['subjectName'])),
                                        DataCell(Text(snaps.data!.docs[i]
                                            ['obtainedMark'])),
                                        DataCell(Text(snaps.data!.docs[i]
                                            ['obtainedGrade'])),
                                      ]),
                                  ]),
                            ),
                              ],
                            ))),
                  );
              
                 
            } else {
              return const Text('');
            }
          }),
    );
  }
}