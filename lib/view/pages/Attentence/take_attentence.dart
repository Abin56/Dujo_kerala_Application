import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:dujo_kerala_application/model/attendence_model/attendence-model.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../widgets/button_container_widget.dart';

class TakeAttenenceScreen extends StatefulWidget {
  String periodNumber;
  String periodTokenID;
  String schoolID;
  String classID;
  String teacheremailID;
  String subjectID;
  String subjectName;
  String batchId;

  TakeAttenenceScreen(
      {required this.classID,
      required this.schoolID,
      required this.teacheremailID,
      required this.subjectID,
      required this.subjectName,
      required this.batchId,
      required this.periodTokenID,
      required this.periodNumber,
      super.key});

  @override
  State<TakeAttenenceScreen> createState() => _TakeAttenenceScreenState();
}

class _TakeAttenenceScreenState extends State<TakeAttenenceScreen> {
  String schoolTimer = '';

  bool? present;
  Map<String, bool?> presentlist = {};
  String timer = '';
  List<AttendanceStudentModel> attendanceList = [];
  List<String> tokenList = [];
  List<String> tokenList2 = [];
  DateTime? attendanceTime;
  String substring = '';
  String finalSubjectName = '';
  String schoolName = '';
  String studentName = '';
  bool notificationEnabledOrNot = true;

  List<Map<String, dynamic>> parentListOfAbsentees = [];
  List<Map<String, dynamic>> guardianListOfAbsentees = [];

  getSchoolName() async {
    final docRef = await FirebaseFirestore.instance
        .collection('SchoolListCollection')
        .doc(widget.schoolID)
        .get();
    schoolName = docRef['schoolName'];
  }

  getStudentsCollectionList(String studentID) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection("SchoolListCollection")
        .doc(widget.schoolID)
        .collection(widget.batchId)
        .doc(widget.batchId)
        .collection("classes")
        .doc(widget.classID)
        .collection('Students')
        .where('docid', isEqualTo: studentID)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      // Retrieve the first document that matches the query
      DocumentSnapshot documentSnapshot = querySnapshot.docs[0];

      // Access the desired field value from the document
      var fieldValue = documentSnapshot.get('studentName');

      log(fieldValue);

      studentName = fieldValue;

      // Use the fieldValue as needed
    }
  }

  String subjectNameFormatting() {
    substring = getSubstringUntilNumber(widget.subjectName)!;
    print(substring);
    return substring;
  }

  String? getSubstringUntilNumber(String input) {
    RegExp regex = RegExp(r'^\D+');
    RegExpMatch? match = regex.firstMatch(input);
    if (match != null) {
      return match.group(0);
    }
    return '';
  }

  Future<void> sendPushMessage(String token, String body, String title) async {
    try {
      final reponse = await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAAd0ScEck:APA91bELuwPRaLXrNxKTwj-z6EK-mCSPOon5WuZZAwkdklLhWvbi_NxXGtwHICE92vUzGJyE9xdOMU_-4ZPbWy8s2MuS_s-4nfcN_rZ1uBTOCMCcJ5aNS7rQHeUTXgYux54-n4eoYclp'
        },
        body: jsonEncode(
          <String, dynamic>{
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'status': 'done',
              'body': body,
              'title': title,
            },
            "notification": <String, dynamic>{
              'title': title,
              'body': body,
              'android_channel_id': 'high_importance_channel'
            },
            'to': token,
          },
        ),
      );
      log(reponse.body.toString());
    } catch (e) {
      if (kDebugMode) {
        log("error push Notification");
      }
    }
  }

  Future<void> getTime() async {
    DocumentSnapshot<Map<String, dynamic>> timersnap = await FirebaseFirestore
        .instance
        .collection('SchoolListCollection')
        .doc(UserCredentialsController.schoolId)
        .collection('Notifications')
        .doc('Attendance')
        .get();
    log(timersnap.data()!['timeToDeliverAbsenceNotification']);
    setState(() {
      notificationEnabledOrNot = timersnap.data()!['notificationNeededOrNot'];
      log('tof : $notificationEnabledOrNot');
    });

    timer = timersnap.data()!['timeToDeliverAbsenceNotification'];
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSchoolTimer();

    getTime();
    finalSubjectName = subjectNameFormatting();
    log(finalSubjectName);

    getSchoolName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Take Attendance'.tr),
        backgroundColor: adminePrimayColor,
      ),
      body: SafeArea(
          child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("SchoolListCollection")
            .doc(widget.schoolID)
            .collection(widget.batchId)
            .doc(widget.batchId)
            .collection("classes")
            .doc(widget.classID)
            .collection('Students')
            .orderBy('studentName', descending: false)
            .snapshots(),
        builder: (context, snapshot) {
          final date = DateTime.now();
          DateTime parseDate = DateTime.parse(date.toString());
          final month = DateFormat('MMMM-yyyy');
          String monthwise = month.format(parseDate);
          final DateFormat formatter = DateFormat('dd-MM-yyyy');
          String formatted = formatter.format(parseDate);
          if (snapshot.hasData) {
            return ListView.separated(
                itemBuilder: (context, index) {
                  final datetimeNow = DateTime.now();
                  DateTime parseDatee = DateTime.parse(datetimeNow.toString());
                  final DateFormat dayformatterr = DateFormat('EEEE');
                  String dayformattedd = dayformatterr.format(parseDatee);
                  final DateFormat formatterr = DateFormat('dd-MMMM-yyy');
                  String formattedd = formatterr.format(parseDatee);
                  if (index == snapshot.data!.docs.length) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            List<AttendanceStudentModel> newlist =
                                attendanceList
                                    .where(
                                        (element) => element.present == false)
                                    .toList();
                            await getAttedenceList(newlist, attendanceList);
                          },
                          child: ButtonContainerWidget(
                            curving: 10,
                            colorindex: 5,
                            height: 60,
                            width: 150,
                            child: Center(
                                child: Text(
                              'Submit'.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )),
                          ),
                        ),
                      ],
                    );
                  }

                  return Container(
                    height: 60,
                    color: presentlist[snapshot.data!.docs[index]
                                ['studentName']] ==
                            null
                        ? Colors.transparent
                        : presentlist[snapshot.data!.docs[index]
                                    ['studentName']] ==
                                true
                            ? Colors.green.withOpacity(0.4)
                            : Colors.red.withOpacity(0.4),
                    width: double.infinity,
                    child: Row(
                      children: [
                        Text('${index + 1}'),
                        kWidth20,
                        SizedBox(
                          width: 200,
                          child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Center(
                                  child: Text(snapshot.data!.docs[index]
                                      ['studentName']))),
                        ),
                        const Spacer(),
                        IconButton(
                            onPressed: () async {
                              setState(() {
                                presentlist[snapshot.data!.docs[index]
                                    ['studentName']!] = true;
                                log(present.toString());
                              });

                              final indexx = attendanceList.indexWhere(
                                  (element) =>
                                      element.uid ==
                                      snapshot.data!.docs[index]['docid']);

                              if (indexx != -1) {
                                attendanceList[indexx].present = true;
                              } else {
                                attendanceList.add(AttendanceStudentModel(
                                    Date: date.toString(),
                                    present: true,
                                    studentName: snapshot.data!.docs[index]
                                        ['studentName'],
                                    uid: snapshot.data!.docs[index]['docid']));
                              }
                            },
                            icon: const Icon(Icons.add)),
                        kWidth20,
                        IconButton(
                            onPressed: () async {
                              setState(() {
                                presentlist[snapshot.data!.docs[index]
                                    ['studentName']!] = false;
                                log(present.toString());
                              });
                              final indexx = attendanceList.indexWhere(
                                  (element) =>
                                      element.uid ==
                                      snapshot.data!.docs[index]['docid']);

                              if (indexx != -1) {
                                //condition means hasdata in list
                                attendanceList[indexx].present = false;
                              } else {
                                attendanceList.add(AttendanceStudentModel(
                                    Date: date.toString(),
                                    present: false,
                                    studentName: snapshot.data!.docs[index]
                                        ['studentName'],
                                    uid: snapshot.data!.docs[index]['docid']));
                              }
                            },
                            icon: const Icon(Icons.remove))
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemCount: snapshot.data!.docs.length + 1);
          } else {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
        },
      )),
    );
  }

  void getSchoolTimer() async {
    var vari = await FirebaseFirestore.instance
        .collection("SchoolListCollection")
        .doc(UserCredentialsController.schoolId)
        .collection('Notifications')
        .doc('Attendance')
        .get();
    setState(() {
      schoolTimer = vari.data()!['timeToDeliverAbsenceNotification'];
      log('schoolTimer >>>>>>>>>>>>>$schoolTimer');
    });
  }

  getAttedenceList(List<AttendanceStudentModel> list,
      List<AttendanceStudentModel> alllist) async {
    log("message$list");

    final date = DateTime.now();
    DateTime parseDate = DateTime.parse(date.toString());
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    String formatted = formatter.format(parseDate);

    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        final month = DateFormat('MMMM-yyyy');
        String monthwise = month.format(parseDate);
        return AlertDialog(
          title: const Text('Absentess List'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                SizedBox(
                  height: 400,
                  width: double.maxFinite,
                  child: list.isEmpty
                      ? const Center(
                          child: Text("No Absentess"),
                        )
                      : ListView.separated(
                          itemBuilder: (context, index) {
                            log(" List >>>>>>$list");
                            if (list[index].present == false) {
                              return Container(
                                height: 40,
                                width: double.maxFinite,
                                color: Colors.red.withOpacity(0.3),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Text('${index + 1}'),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Text(list[index].studentName),
                                      const Spacer(),
                                      const Text(' - Ab')
                                    ],
                                  ),
                                ),
                              );
                            } else if (list.isEmpty) {
                              log("Emptyyyy");
                              return const Center(child: Text("data"));
                            } else {
                              return const SizedBox();
                            }
                          },
                          separatorBuilder: (context, index) {
                            return const Divider();
                          },
                          itemCount: list.length),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Edit'),
              onPressed: () async {
                Navigator.of(context).pop();

                attendanceTime = DateTime.now();
                String formattedDate =
                    DateFormat.yMMMMd().format(attendanceTime!);
                String formattedTime = DateFormat.jm().format(DateTime.now());
                Future<QuerySnapshot<Map<String, dynamic>>> absentStudentsList =
                    FirebaseFirestore.instance
                        .collection("SchoolListCollection")
                        .doc(widget.schoolID)
                        .collection(widget.batchId)
                        .doc(widget.batchId)
                        .collection("classes")
                        .doc(widget.classID)
                        .collection("Attendence")
                        .doc(formatted)
                        .collection("Subjects")
                        .doc(widget.subjectID)
                        .collection('PresentList')
                        .where('present', isEqualTo: false)
                        .get();

                QuerySnapshot<Map<String, dynamic>> snapshot =
                    await absentStudentsList;
                List<Map<String, dynamic>> mappedAbsentStudentsList =
                    snapshot.docs.map((doc) => doc.data()).toList();

                Future<QuerySnapshot<Map<String, dynamic>>> parentss =
                    FirebaseFirestore.instance
                        .collection("SchoolListCollection")
                        .doc(widget.schoolID)
                        .collection(widget.batchId)
                        .doc(widget.batchId)
                        .collection("classes")
                        .doc(widget.classID)
                        .collection('ParentCollection')
                        .get();

                Future<QuerySnapshot<Map<String, dynamic>>> guardianss =
                    FirebaseFirestore.instance
                        .collection("SchoolListCollection")
                        .doc(widget.schoolID)
                        .collection(widget.batchId)
                        .doc(widget.batchId)
                        .collection("classes")
                        .doc(widget.classID)
                        .collection('GuardianCollection')
                        .get();

                QuerySnapshot<Map<String, dynamic>> snapshot2 = await parentss;
                List<Map<String, dynamic>> parentsList =
                    snapshot2.docs.map((doc) => doc.data()).toList();

                QuerySnapshot<Map<String, dynamic>> snapshot3 =
                    await guardianss;
                List<Map<String, dynamic>> guardiansList =
                    snapshot2.docs.map((doc) => doc.data()).toList();

                bool isValueEqual = false;

                for (var item1 in parentsList) {
                  for (var item2 in mappedAbsentStudentsList) {
                    if (item1['studentID'] == item2['uid']) {
                      log('yesss!!!!!');
                      parentListOfAbsentees.add(item1);

                      log('THE LIST : ${parentListOfAbsentees.length.toString()}');
                      isValueEqual = true;
                      break;
                    }
                  }
                  //parentListOfAbsentees
                }

                for (var item1 in guardiansList) {
                  for (var item2 in mappedAbsentStudentsList) {
                    if (item1['studentID'] == item2['uid']) {
                      log('yesss!!!!!');
                      guardianListOfAbsentees.add(item1);

                      log('THE GLIST : ${parentListOfAbsentees.length.toString()}');
                      isValueEqual = true;
                      break;
                    }
                  }
                  //parentListOfAbsentees
                }

                log('HWG: $parentListOfAbsentees');
                for (var k in parentListOfAbsentees) {
                  tokenList.add(k['deviceToken']);
                }

                for (var r in guardianListOfAbsentees) {
                  tokenList2.add(r['deviceToken']);
                }

                Timer(Duration(hours: int.parse(timer)), () async {});
              },
            ),
            TextButton(
              child: const Text('Upload'),
              onPressed: () async {
                return showDialog(
                  context: context,
                  barrierDismissible: false, // user must tap button!
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Alert'),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: const <Widget>[
                            Text(
                                'Are you sure to continue with this absentees list?\nIf you want to edit, please do it before publishing from the Attendance book..')
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                            child: const Text('Upload Attendance'),
                            onPressed: () async {
                              final datetimeNow = DateTime.now();
                              DateTime parseDatee =
                                  DateTime.parse(datetimeNow.toString());
                              final DateFormat dayformatterr =
                                  DateFormat('EEEE');
                              String dayformattedd =
                                  dayformatterr.format(parseDatee);
                              final DateFormat formatterr =
                                  DateFormat('dd-MMMM-yyy');
                              String formattedd = formatterr.format(parseDatee);
                              final date = DateTime.now();
                              DateTime parseDate =
                                  DateTime.parse(date.toString());
                              final month = DateFormat('MMMM-yyyy');
                              String monthwise = month.format(parseDate);
                              final DateFormat formatter =
                                  DateFormat('dd-MM-yyyy');
                              String formatted = formatter.format(parseDate);

                              log('period document id ${widget.periodTokenID}');

                              attendanceTime = DateTime.now();
                              String formattedDate =
                                  DateFormat.yMMMMd().format(attendanceTime!);
                              String formattedTime =
                                  DateFormat.jm().format(DateTime.now());

                              for (var i = 0; i < alllist.length; i++) {
                                await FirebaseFirestore.instance
                                    .collection("SchoolListCollection")
                                    .doc(widget.schoolID)
                                    .collection(widget.batchId)
                                    .doc(widget.batchId)
                                    .collection("classes")
                                    .doc(widget.classID)
                                    .collection("Attendence")
                                    .doc(monthwise)
                                    .set({'id': monthwise}).then((value) async {
                                  await FirebaseFirestore.instance
                                      .collection("SchoolListCollection")
                                      .doc(widget.schoolID)
                                      .collection(widget.batchId)
                                      .doc(widget.batchId)
                                      .collection("classes")
                                      .doc(widget.classID)
                                      .collection("Attendence")
                                      .doc(monthwise)
                                      .collection(monthwise)
                                      .doc(formatted)
                                      .set({
                                    "docid": formatted,
                                    'dDate': formattedd,
                                    'day': dayformattedd
                                  }, SetOptions(merge: true)).then((value) {
                                    FirebaseFirestore.instance
                                        .collection("SchoolListCollection")
                                        .doc(widget.schoolID)
                                        .collection(widget.batchId)
                                        .doc(widget.batchId)
                                        .collection("classes")
                                        .doc(widget.classID)
                                        .collection("Attendence")
                                        .doc(monthwise)
                                        .collection(monthwise)
                                        .doc(formatted)
                                        .collection("Subjects")
                                        .doc(widget.periodTokenID)
                                        .set({
                                      "docid": widget.periodTokenID,
                                      'period': widget.periodNumber,
                                      'subject': widget.subjectName,
                                      'date': DateTime.now().toString(),
                                      'onSubmit': false,
                                      'exTime': DateTime.now()
                                          .add(Duration(
                                              minutes: int.parse(schoolTimer)))
                                          .toString()
                                    }).then((value) {
                                      FirebaseFirestore.instance
                                          .collection("SchoolListCollection")
                                          .doc(widget.schoolID)
                                          .collection(widget.batchId)
                                          .doc(widget.batchId)
                                          .collection("classes")
                                          .doc(widget.classID)
                                          .collection("Attendence")
                                          .doc(monthwise)
                                          .collection(monthwise)
                                          .doc(formatted)
                                          .collection("Subjects")
                                          .doc(widget.periodTokenID)
                                          .collection('PresentList')
                                          .doc(alllist[i].uid)
                                          .set(alllist[i].toMap());
                                    });
                                  });
                                });
                              }

                              FirebaseFirestore.instance
                                  .collection("SchoolListCollection")
                                  .doc(widget.schoolID)
                                  .collection(widget.batchId)
                                  .doc(widget.batchId)
                                  .collection("classes")
                                  .doc(widget.classID)
                                  .collection("Attendence")
                                  .doc(monthwise)
                                  .collection(monthwise)
                                  .doc(formatted)
                                  .collection('PeriodCollection')
                                  .doc(widget.periodTokenID)
                                  .delete()
                                  .then((value) {
                                return showDialog(
                                  context: context,
                                  barrierDismissible:
                                      false, // user must tap button!
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Message'),
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children: const <Widget>[
                                            Text(
                                                'Attendance uploaded Successfully!')
                                          ],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text('ok'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            Navigator.of(context).pop();
                                            Navigator.of(context).pop();
                                            Navigator.of(context).pop();
                                            Navigator.of(context).pop();
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              });

             

                              Timer(Duration(minutes: int.parse(timer)),
                                  () async {
                                bool isValueEqual = false;
                                QuerySnapshot<Map<String, dynamic>> snap =
                                    await FirebaseFirestore.instance
                                        .collection("SchoolListCollection")
                                        .doc(widget.schoolID)
                                        .collection(widget.batchId)
                                        .doc(widget.batchId)
                                        .collection("classes")
                                        .doc(widget.classID)
                                        .collection('Attendence')
                                        .doc(monthwise)
                                        .collection(monthwise)
                                        .doc(formatted)
                                        .collection("Subjects")
                                        .doc(widget.periodTokenID)
                                        .collection('PresentList')
                                        .where('present', isEqualTo: false)
                                        .get();

                                List<Map<String, dynamic>>
                                    mappedAbsentStudentsList =
                                    snap.docs.map((doc) => doc.data()).toList();

                                ///////

                                Future<QuerySnapshot<Map<String, dynamic>>>
                                    parentss = FirebaseFirestore.instance
                                        .collection("SchoolListCollection")
                                        .doc(widget.schoolID)
                                        .collection(widget.batchId)
                                        .doc(widget.batchId)
                                        .collection("classes")
                                        .doc(widget.classID)
                                        .collection('ParentCollection')
                                        .get();

                                Future<QuerySnapshot<Map<String, dynamic>>>
                                    guardianss = FirebaseFirestore.instance
                                        .collection("SchoolListCollection")
                                        .doc(widget.schoolID)
                                        .collection(widget.batchId)
                                        .doc(widget.batchId)
                                        .collection("classes")
                                        .doc(widget.classID)
                                        .collection('GuardianCollection')
                                        .get();

                                QuerySnapshot<Map<String, dynamic>> snapshot2 =
                                    await parentss;
                                QuerySnapshot<Map<String, dynamic>> snapshot3 =
                                    await guardianss;

                                List<Map<String, dynamic>> parentsList =
                                    snapshot2.docs
                                        .map((doc) => doc.data())
                                        .toList();

                                List<Map<String, dynamic>> guardiansList =
                                    snapshot3.docs
                                        .map((doc) => doc.data())
                                        .toList();

                                for (var item1 in parentsList) {
                                  for (var item2 in mappedAbsentStudentsList) {
                                    if (item1['studentID'] == item2['uid']) {
                                      log('yesss!!!!!');
                                      parentListOfAbsentees.add(item1);

                                      log('THE LIST : ${parentListOfAbsentees.length.toString()}');
                                      isValueEqual = true; //
                                      break;
                                    } else {
                                      log('no');
                                    }
                                  }
                                  //parentListOfAbsentees
                                }

                                for (var item1 in guardiansList) {
                                  for (var item2 in mappedAbsentStudentsList) {
                                    if (item1['studentID'] == item2['uid']) {
                                      log('yesss!!!!!');
                                      guardianListOfAbsentees.add(item1);

                                      log('THE GLIST : ${guardianListOfAbsentees.length.toString()}');
                                      isValueEqual = true;
                                      break;
                                    } else {
                                      log('no2');
                                    }

                                    /////

                                    for (var doc in snap.docs) {
                                      final docData = doc.data();
                                      log('CATCH THE LIST');
                                      studentName = docData['studentName'];
                                      log(docData['studentName']);
                                    }
                                  }
                                }

                                log('HWG: ${parentListOfAbsentees[0]['studentID']}');
                                for (var k in parentListOfAbsentees) {
                                  tokenList.add(k['deviceToken']);
                                  getStudentsCollectionList(k['studentID']);
                                }

                                for (var r in guardianListOfAbsentees) {
                                  tokenList2.add(r['deviceToken']);
                                  getStudentsCollectionList(r['studentID']);
                                  log(tokenList2[0]);
                                }

                                if (notificationEnabledOrNot) {
                                  for (var l in tokenList) {
                                    for (var i = 0; i < tokenList.length; i++) {
                                      sendPushMessage(
                                          tokenList[i],
                                          'Sir/Madam, your child was absent on for $finalSubjectName period at $formattedTime on $formattedDate, സർ/മാഡം, $formattedDate തീയതി $formattedTimeന് ഉണ്ടായിരുന്ന $finalSubjectName പീരീഡിൽ നിങ്ങളുടെ കുട്ടി ഹാജരായിരുന്നില്ല',
                                          'Absent Notification from $schoolName');
                                    }
                                  }

                                  for (var l in tokenList2) {
                                    for (var i = 0;
                                        i < tokenList2.length;
                                        i++) {
                                      sendPushMessage(
                                          tokenList2[i],
                                          'Sir/Madam, your child was absent on for $finalSubjectName period at $formattedTime on $formattedDate, സർ/മാഡം, $formattedDate തീയതി $formattedTimeന് ഉണ്ടായിരുന്ന $finalSubjectName പീരീഡിൽ നിങ്ങളുടെ കുട്ടി ഹാജരായിരുന്നില്ല',
                                          'Absent Notification from $schoolName');
                                    }
                                  }
                                }
                              });
                              log('DONE');
                            }),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }
}
