import 'package:dujo_kerala_application/view/constant/sizes/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddExamTimeTableController extends GetxController {
  Future<void> uploadSubject(
    String collectionName,
    String examdocID,
    String subject,
    TimeOfDay startingtime,
    TimeOfDay endingtime,
    String examDate,
  ) async {
 
    final docids = subject + uuid.v1();
    // String formatTimeWithoutPeriod1 = formatTimeWithoutPeriod(startingtime);
    //   String formatTimeWithoutPeriod2 = formatTimeWithoutPeriod(startingtime);
 Duration getTimeDifferences = getTimeDifference(startingtime, endingtime);
 final x =
 getTimeDifferences.inMinutes
 ;
//  log(x.toString());
        // log('geting ${getTimeDifferences.toString()}');
        // var results = getTimeDifferences.toString().split('.');
    // String extractSubstring2 = extractSubstring(startingtime, 'P');

    // TimeOfDay time1 = parseTimeString(startingtime);
    // TimeOfDay time2 = parseTimeString(endingtime);
    // Duration diff = getTimeDifference(time1, time2);
    // log('collectionName ${collectionName.toString()}');
    // log('examdocID ${examdocID.toString()}');
    // log('subject ${subject.toString()}');
    // log('startingtime ${startingtime.toString()}');
    // log('endingtime ${endingtime.toString()}');
    // log('examDate ${examDate.toString()}');
    // log('time1 ${time1.toString()}');
    // log('time2 ${time2.toString()}');
    // log('diff  ${diff.toString()}');
    // final data = AddExamTimeTableModel(
    //     docid: docids,
    //     subject: subject,
    //     startingtime: startingtime,
    //     endingtime: endingtime,
    //     hours: x<=60?x:x/60,
    //     examDate: examDate);

    // FirebaseFirestore.instance
    //     .collection('SchoolListCollection')
    //     .doc(UserCredentialsController.schoolId)
    //     .collection(UserCredentialsController.batchId!)
    //     .doc(UserCredentialsController.batchId!)
    //     .collection(collectionName)
    //     .doc(examdocID)
    //     .collection('subjects')
    //     .doc(docids)
    //     .set(data.toMap())
    //     .then((value) {
    //   showToast(msg: 'Added Subject');
    // });
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

  TimeOfDay parseTimeString(String timeString) {
    List<String> parts = timeString.split(':');
    int hour = int.parse(parts[0]);
    int minute = int.parse(parts[1]);

    return TimeOfDay(hour: hour, minute: minute);
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

  String extractSubstring(String text, String targetLetter) {
    int startIndex = 0;
    int targetIndex = text.indexOf(targetLetter);

    if (targetIndex >= 0) {
      return text.substring(startIndex, targetIndex);
    } else {
      return text;
    }
  }
}
