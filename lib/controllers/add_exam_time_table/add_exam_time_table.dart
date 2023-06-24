import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/view/constant/sizes/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/exam_list_model/add_ex_timeTable.dart';
import '../userCredentials/user_credentials.dart';

class AddExamTimeTableController extends GetxController {
  Future<void>uploadSubject(
      String collectionName,
      String examdocID,
      String subject,
      dynamic startingtime,
      dynamic endingtime,
      String examDate,
      String fromTime,
      String totime,
    BuildContext context,

      ) async {
    final docids = subject + uuid.v1();
    Duration getTimeDifferences = getTimeDifference(startingtime, endingtime);
    final x = getTimeDifferences.inMinutes;
    final y = getTimeDifferences.inHours;
    final data = AddExamTimeTableModel(
      createDate: DateTime.now().toString(),
        docid: docids,
        subject: subject,
        startingtime: fromTime,
        endingtime: totime,
        hours: x <= 60 || x ==120 ?'${y}hrs' : '${x}mins',
        examDate: examDate);
    log('docid ${data.docid}');
    log('subject ${data.subject}');
    log('startingtime ${data.startingtime}');
    log('hours ${data.hours}');
    log('examDate ${data.examDate}');

    await FirebaseFirestore.instance
        .collection('SchoolListCollection')
        .doc(UserCredentialsController.schoolId)
        .collection(UserCredentialsController.batchId!)
        .doc(UserCredentialsController.batchId!)
        .collection('classes')
        .doc(UserCredentialsController.classId)
        .collection(collectionName)
        .doc(examdocID)
        .collection('subjects')
        .doc(docids)
        .set(data.toMap())
        .then((value) {

      Navigator.pop(context);
    });
  }

  String formatTimeWithoutPeriod(TimeOfDay timeOfDay) {
    String period = timeOfDay.period == DayPeriod.am ? 'AM' : 'PM';
    int hour = timeOfDay.hourOfPeriod;

    // Adjust hour if it's 0 (midnight)
    if (hour == 0) {
      hour = 12;
    }

    String minute = timeOfDay.minute.toString().padLeft(2, '0');

    return '$hour:$minute';
  }

  Duration getTimeDifference(TimeOfDay time1, TimeOfDay time2) {
    DateTime now = DateTime.now();
    DateTime dateTime1 =
        DateTime(now.year, now.month, now.day, time1.hour, time1.minute);
    DateTime dateTime2 =
        DateTime(now.year, now.month, now.day, time2.hour, time2.minute);

    if (dateTime2.isBefore(dateTime1)) {
      dateTime2 = dateTime2.add(const Duration(days: 1));
    }

    return dateTime2.difference(dateTime1);
  }
}
