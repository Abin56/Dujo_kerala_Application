import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../widgets/button_container_widget.dart';

class TakeAttenenceScreen extends StatefulWidget {
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
      super.key});

  @override
  State<TakeAttenenceScreen> createState() => _TakeAttenenceScreenState();
}

class _TakeAttenenceScreenState extends State<TakeAttenenceScreen> {
  bool? present;
  Map<String, bool?> presentlist = {};
  String timer = '';
  List<String> tokenList = [];
  List<String> tokenList2 = [];
  DateTime? attendanceTime;


  List<Map<String, dynamic>> parentListOfAbsentees = []; 
  List<Map<String, dynamic>> guardianListOfAbsentees = []; 

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
    timer = timersnap.data()!['timeToDeliverAbsenceNotification'];
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTime();
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
          if (snapshot.hasData) {
            return ListView.separated(
                itemBuilder: (context, index) {
                  final datetimeNow = DateTime.now();
                  DateTime parseDatee = DateTime.parse(datetimeNow.toString());
                  final DateFormat dayformatterr = DateFormat('EEEE');
                  String dayformattedd = dayformatterr.format(parseDatee);
                  final DateFormat formatterr = DateFormat('dd-MMMM-yyy');
                  String formattedd = formatterr.format(parseDatee);

                  return Container(
                    height: 60,
                    color: presentlist[snapshot.data!.docs[index]
                                ['studentName']] ==
                            null
                        ? Colors.transparent
                        : presentlist[snapshot.data!.docs[index]
                                    ['studentName']] ==
                                true
                            ? Colors.green
                            : Colors.red,
                    width: double.infinity,
                    child: Row(
                      children: [
                        Text('${index + 1}'),
                        kWidth20,
                        Text(snapshot.data!.docs[index]['studentName']),
                        const Spacer(),
                        IconButton(
                            onPressed: () async {
                              setState(() {
                                presentlist[snapshot.data!.docs[index]
                                    ['studentName']!] = true;
                                log(present.toString());
                              });
                              final date = DateTime.now();
                              DateTime parseDate =
                                  DateTime.parse(date.toString());
                              final DateFormat formatter =
                                  DateFormat('dd-MM-yyyy');
                              String formatted = formatter.format(parseDate);
                              await FirebaseFirestore.instance
                                  .collection("SchoolListCollection")
                                  .doc(widget.schoolID)
                                  .collection(widget.batchId)
                                  .doc(widget.batchId)
                                  .collection("classes")
                                  .doc(widget.classID)
                                  .collection("Attendence")
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
                                    .doc(formatted)
                                    .collection("Subjects")
                                    .doc(widget.subjectID)
                                    .set({
                                  "docid": widget.subjectID,
                                  'subject': widget.subjectName,
                                  'date': DateTime.now().toString()
                                }).then((value) {
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
                                      .doc(snapshot.data!.docs[index]
                                          ['studentName'])
                                      .set({
                                    "studentName": snapshot.data!.docs[index]
                                        ['studentName'],
                                    "uid": snapshot.data!.docs[index]['docid'],
                                    "present": true,
                                    "Date": DateTime.now().toString()
                                  });
                                });
                              });

                              log(present.toString());
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

                              final date = DateTime.now();
                              DateTime parseDate =
                                  DateTime.parse(date.toString());
                              final DateFormat formatter =
                                  DateFormat('dd-MM-yyyy');
                              String formatted = formatter.format(parseDate);
                              await FirebaseFirestore.instance
                                  .collection("SchoolListCollection")
                                  .doc(widget.schoolID)
                                  .collection(widget.batchId)
                                  .doc(widget.batchId)
                                  .collection("classes")
                                  .doc(widget.classID)
                                  .collection("Attendence")
                                  .doc(formatted)
                                  .set({
                                "docid": formatted,
                                'dDate': formattedd,
                                'day': dayformattedd
                              }, SetOptions(merge: true)).then((value) {
                                FirebaseFirestore.instance
                                    .collection("SchoolListCollection")
                                    .doc(widget.schoolID)
                                    .collection("classes")
                                    .doc(widget.classID)
                                    .collection("Attendence")
                                    .doc(formatted)
                                    .collection("Subjects")
                                    .doc(widget.subjectID)
                                    .set({
                                  "docid": widget.subjectID,
                                  'subject': widget.subjectName,
                                  'date': DateTime.now().toString()
                                }).then((value) {
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
                                      .doc(snapshot.data!.docs[index]
                                          ['studentName'])
                                      .set({
                                    "studentName": snapshot.data!.docs[index]
                                        ['studentName'],
                                    "uid": snapshot.data!.docs[index]['docid'],
                                    "present": false,
                                    "Date": DateTime.now().toString()
                                  });
                                });
                              });
                              log(present.toString());
                            },
                            icon: const Icon(Icons.remove))
                      ],
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
      )),
      floatingActionButton: GestureDetector(
        onTap: () async {
          await getAttedenceList();
        },
        child: ButtonContainerWidget(
          curving: 10,
          colorindex: 5,
          height: 60,
          width: 130,
          child: Center(
              child: Text(
            'Confirm'.tr,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white),
          )),
        ),
      ),
    );
  }

  getAttedenceList() async {
    final date = DateTime.now();
    DateTime parseDate = DateTime.parse(date.toString());
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    String formatted = formatter.format(parseDate);
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Absent List'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                SizedBox(
                  height: 400,
                  width: double.maxFinite,
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
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
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.separated(
                              itemBuilder: (context, index) {
                                return Container(
                                  height: 40,
                                  width: double.maxFinite,
                                  color: Colors.white,
                                  child: Row(
                                    children: [
                                      Text('${index + 1}'),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Text(snapshot.data!.docs[index]
                                          ['studentName'])
                                    ],
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
                      }),
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('ok'),
              onPressed: () async {
                Navigator.of(context).pop();
                attendanceTime = DateTime.now();
                 String formattedDate = DateFormat.yMMMMd().format(attendanceTime!);
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


                 QuerySnapshot<Map<String, dynamic>> snapshot3 = await guardianss;
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


                Timer(Duration(hours: int.parse(timer)), () {
                  // Function to be executed after the duration

                  for (var l in tokenList) {
                    for (var i = 0; i < tokenList.length; i++) {
                      sendPushMessage(tokenList[i], 'Sir/Madam, your ward was absent today at $formattedTime, on $formattedDate.', 'Absent Notification');
                    }
                  } 

                   for (var m in tokenList2) {
                    for (var i = 0; i < tokenList2.length; i++) {
                      sendPushMessage(tokenList2[i], 'Sir/Madam, your ward was absent today at $formattedTime, on $formattedDate.', 'Absent Notification');
                    }
                  }
                });

                //                        for (String searchValue in mappedAbsentStudentsList[0]['uid']) {
                // QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
                //     .collection(collectionPath)
                //     .where('propertyName', isEqualTo: searchValue)
                //     .get();

                // FirebaseFirestore.instance //how to check whether a list of items property value is equal to property of another list values (in loop)
                //           .collection("SchoolListCollection")
                //           .doc(widget.schoolID)
                //           .collection(widget.batchId)
                //           .doc(widget.batchId)
                //           .collection("classes")
                //           .doc(widget.classID)
                //           .collection('ParentCollection')
              },
            ),
          ],
        );
      },
    );
  }
}
