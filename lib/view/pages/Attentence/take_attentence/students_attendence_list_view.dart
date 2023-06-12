import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../model/teacher_model/attentence/attendance_model.dart';

class StudentsAttendenceListViewScreen extends StatelessWidget {
  String schoolId;
  String classID;
  String date;
  String subject;
  String batchId;
  String month;

  StudentsAttendenceListViewScreen(
      {required this.schoolId,
      required this.classID,
      required this.batchId,
      required this.date,
      required this.subject,
      required this.month,
      super.key});

  @override
  Widget build(BuildContext context) {
    log(classID);
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance List'.tr),
        backgroundColor: adminePrimayColor,
      ),
      body: SafeArea(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("SchoolListCollection")
              .doc(schoolId)
              .collection(batchId)
              .doc(batchId)
              .collection("classes")
              .doc(classID)
              .collection("Attendence")
              .doc(month)
              .collection(month)
              .doc(date)
              .collection("Subjects")
              .doc(subject)
              .collection("PresentList")
              .orderBy("studentName", descending: false)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.separated(
                  itemBuilder: (context, index) {
                    final data = GetAttendenceModel.fromJson(
                        snapshot.data!.docs[index].data());
                    return Container(
                      color: data.present == true
                          ? Colors.green.withOpacity(0.4)
                          : Colors.red.withOpacity(0.4),
                      height: 40,
                      width: double.infinity,
                      child: Center(
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text('${index + 1}'),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              data.studentName,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(data.present == true ? ' - Pr' : ' - Ab')
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                  itemCount: snapshot.data!.docs.length);
            } else {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
          },
        ),
      ),
    );
  }
}
