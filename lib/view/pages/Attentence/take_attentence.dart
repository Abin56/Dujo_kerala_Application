import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('Take Attendence'.tr),backgroundColor: adminePrimayColor,
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
          child:  Center(
              child: Text(
            'View'.tr,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
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
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
