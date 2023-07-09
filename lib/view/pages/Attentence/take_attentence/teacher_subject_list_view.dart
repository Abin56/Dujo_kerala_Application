import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:dujo_kerala_application/view/pages/Attentence/take_attentence/students_attendence_list_view.dart';
import 'package:dujo_kerala_application/view/widgets/fonts/google_monstre.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../controllers/userCredentials/user_credentials.dart';
import '../../../../utils/utils.dart';

class AttendenceSubjectListScreen extends StatelessWidget {
  String schoolId;
  String classID;
  String date;
  String batchId;
  String month;
  AttendenceSubjectListScreen(
      {required this.schoolId,
      required this.classID,
      required this.date,
      required this.batchId,
      required this.month,
      super.key});

  @override
  Widget build(BuildContext context) {
    pageTimeexprided();
    int columnCount = 3;
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    log(classID);
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Subject'.tr),
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
            .orderBy("date", descending: false)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return AnimationLimiter(
              child: GridView.count(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                padding: EdgeInsets.all(w / 60),
                crossAxisCount: columnCount,
                children: List.generate(
                  snapshot.data!.docs.length,
                  (int index) {
                    DateTime parseDate = DateTime.parse(
                        snapshot.data!.docs[index]['date'].toString());
                    final DateFormat formatter = DateFormat('hh : mm  a');
                    String formatted = formatter.format(parseDate);

                    return AnimationConfiguration.staggeredGrid(
                      position: index,
                      duration: const Duration(milliseconds: 200),
                      columnCount: columnCount,
                      child: ScaleAnimation(
                        duration: const Duration(milliseconds: 900),
                        curve: Curves.fastLinearToSlowEaseIn,
                        child: FadeInAnimation(
                          child: GestureDetector(
                            onTap: () {
                              Get.to(()=>
                                StudentsAttendenceListViewScreen(
                                  month: month,
                                  batchId: batchId,
                                  subject: snapshot.data!.docs[index]['docid'],
                                  schoolId: schoolId,
                                  classID: classID,
                                  date: date,
                                ),
                              );
                            },
                            child: Container(
                              height: h / 100,
                              width: double.infinity,
                              margin: EdgeInsets.only(
                                  bottom: w / 10, left: w / 50, right: w / 50),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(212, 67, 30, 203)
                                    .withOpacity(0.1),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 40,
                                    spreadRadius: 10,
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Column(
                                  children: [
                                    StreamBuilder(
                                        stream: FirebaseFirestore.instance
                                            .collection("SchoolListCollection")
                                            .doc(UserCredentialsController
                                                .schoolId)
                                            .collection(
                                                UserCredentialsController
                                                    .batchId!)
                                            .doc(UserCredentialsController
                                                .batchId)
                                            .collection("classes")
                                            .doc(classID)
                                            .collection("teachers")
                                            .doc(FirebaseAuth
                                                .instance.currentUser!.uid)
                                            .collection("teacherSubject")
                                            .snapshots(),
                                        builder: (context, snaps) {
                                          log('Checking teacher idddddddddddddd$classID');
                                          if (snaps.hasData) {
                                            if (snaps.data!.docs.isEmpty) {
                                              log("No accessss");

                                              return const Text('');
                                            } else {
                                              return Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  FutureBuilder(
                                                      future: FirebaseFirestore
                                                          .instance
                                                          .collection(
                                                              "SchoolListCollection")
                                                          .doc(schoolId)
                                                          .collection(batchId)
                                                          .doc(batchId)
                                                          .collection("classes")
                                                          .doc(classID)
                                                          .collection(
                                                              "Attendence")
                                                          .doc(month)
                                                          .collection(month)
                                                          .doc(date)
                                                          .collection(
                                                              "Subjects")
                                                          .doc(snapshot.data!
                                                                  .docs[index]
                                                              ['docid'])
                                                          .get(),
                                                      builder: (context,
                                                          checkingExTime) {
                                                        if (checkingExTime
                                                            .hasData) {
                                                          final extime = DateTime
                                                              .parse(checkingExTime
                                                                      .data
                                                                      ?.data()?[
                                                                  'exTime']);
                                                          if (extime.isBefore(
                                                              DateTime.now())) {
                                                            return CircleAvatar(
                                                              backgroundColor:
                                                                  Colors.red,
                                                              radius: 13,
                                                              child: Center(
                                                                child:
                                                                    IconButton(
                                                                        onPressed:
                                                                            () async {
                                                                          return showDialog(
                                                                            context:
                                                                                context,
                                                                            barrierDismissible:
                                                                                false, // user must tap button!
                                                                            builder:
                                                                                (BuildContext context) {
                                                                              return AlertDialog(
                                                                                title: const Text('Message'),
                                                                                content: SingleChildScrollView(
                                                                                  child: ListBody(
                                                                                    children:  <Widget>[
                                                                                    GoogleMonstserratWidgets(text: 'Sorry the time exceeded!!',fontsize: 15.w,)
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                                actions: <Widget>[
                                                                                  TextButton(
                                                                                    child: const Text('Ok'),
                                                                                    onPressed: () {
                                                                                      Navigator.of(context).pop();
                                                                                    },
                                                                                  ),
                                                                                ],
                                                                              );
                                                                            },
                                                                          );
                                                                        },
                                                                        icon:
                                                                            const Icon(
                                                                          Icons
                                                                              .edit,
                                                                          size:
                                                                              10,
                                                                        )),
                                                              ),
                                                            );
                                                          } else {
                                                            return CircleAvatar(
                                                              backgroundColor:
                                                                  Colors.green,
                                                              radius: 13,
                                                              child: Center(
                                                                  child: IconButton(
                                                                      onPressed: () {
                                                                        showDialog(
                                                                          context:
                                                                              context,
                                                                          barrierDismissible:
                                                                              false, // user must tap button!
                                                                          builder:
                                                                              (BuildContext context) {
                                                                            return AlertDialog(
                                                                              title: const Text('Attendance List '),
                                                                              content: SingleChildScrollView(
                                                                                child: ListBody(
                                                                                  children: <Widget>[
                                                                                    SizedBox(
                                                                                      height: 400,
                                                                                      width: 400,
                                                                                      child: StreamBuilder(
                                                                                          stream: FirebaseFirestore.instance.collection("SchoolListCollection").doc(schoolId).collection(batchId).doc(batchId).collection("classes").doc(classID).collection("Attendence").doc(month).collection(month).doc(date).collection("Subjects").doc(snapshot.data!.docs[index]['docid']).collection("PresentList").orderBy("studentName", descending: false).snapshots(),
                                                                                          builder: (context, snapsh) {
                                                                                            if (snapsh.hasData) {
                                                                                              return ListView.separated(
                                                                                                  itemBuilder: (context, index2) {
                                                                                                    if (snapsh.data!.docs[index2]['present'] == true) {
                                                                                                      return Container(
                                                                                                        color: Colors.green.withOpacity(0.4),
                                                                                                        height: 40,
                                                                                                        child: Row(
                                                                                                          children: [
                                                                                                            Text('${index2 + 1}'),
                                                                                                            kWidth20,
                                                                                                            Text(snapsh.data!.docs[index2]['studentName']),
                                                                                                            const Spacer(),
                                                                                                            IconButton(
                                                                                                                onPressed: () async {
                                                                                                                  return showDialog(
                                                                                                                    context: context,
                                                                                                                    barrierDismissible: false, // user must tap button!
                                                                                                                    builder: (BuildContext context) {
                                                                                                                      return AlertDialog(
                                                                                                                        title: const Text('Update Attendance'),
                                                                                                                        content: SingleChildScrollView(
                                                                                                                          child: ListBody(
                                                                                                                            children: <Widget>[
                                                                                                                              Row(
                                                                                                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                                                                children: [
                                                                                                                                  GestureDetector(
                                                                                                                                    onTap: () async {
                                                                                                                                      log('index${snapshot.data!.docs[index]}');
                                                                                                                                      log('Studentname?????${snapsh.data!.docs[index2]['studentName']}');

                                                                                                                                      await FirebaseFirestore.instance.collection("SchoolListCollection").doc(schoolId).collection(batchId).doc(batchId).collection("classes").doc(classID).collection("Attendence").doc(month).collection(month).doc(date).collection("Subjects").doc(snapshot.data!.docs[index]['docid']).collection("PresentList").doc(snapsh.data!.docs[index2]['uid']).update({'present': true}).then((value) {
                                                                                                                                        showToast(msg: 'Changed');
                                                                                                                                        Get.back();
                                                                                                                                      });
                                                                                                                                    },
                                                                                                                                    child: Container(
                                                                                                                                      color: Colors.green.withOpacity(0.4),
                                                                                                                                      height: 40,
                                                                                                                                      width: 120,
                                                                                                                                      child: const Center(
                                                                                                                                        child: Text('Present'),
                                                                                                                                      ),
                                                                                                                                    ),
                                                                                                                                  ),
                                                                                                                                  GestureDetector(
                                                                                                                                    onTap: () async {
                                                                                                                                      log('Studentname${snapsh.data!.docs[index2]['studentName']}');

                                                                                                                                      FirebaseFirestore.instance.collection("SchoolListCollection").doc(schoolId).collection(batchId).doc(batchId).collection("classes").doc(classID).collection("Attendence").doc(month).collection(month).doc(date).collection("Subjects").doc(snapshot.data!.docs[index]['docid']).collection("PresentList").doc(snapsh.data!.docs[index2]['uid']).update({'present': false}).then((value) {
                                                                                                                                        showToast(msg: 'Changed');
                                                                                                                                        Get.back();
                                                                                                                                      });
                                                                                                                                    },
                                                                                                                                    child: Container(
                                                                                                                                      color: Colors.red.withOpacity(0.4),
                                                                                                                                      height: 40,
                                                                                                                                      width: 120,
                                                                                                                                      child: const Center(
                                                                                                                                        child: Text("Absent"),
                                                                                                                                      ),
                                                                                                                                    ),
                                                                                                                                  )
                                                                                                                                ],
                                                                                                                              )
                                                                                                                            ],
                                                                                                                          ),
                                                                                                                        ),
                                                                                                                        actions: <Widget>[
                                                                                                                          TextButton(
                                                                                                                            child: const Text('Ok'),
                                                                                                                            onPressed: () {
                                                                                                                              Navigator.of(context).pop();
                                                                                                                            },
                                                                                                                          ),
                                                                                                                        ],
                                                                                                                      );
                                                                                                                    },
                                                                                                                  );
                                                                                                                },
                                                                                                                icon: const Icon(Icons.edit))
                                                                                                          ],
                                                                                                        ),
                                                                                                      );
                                                                                                    } else {
                                                                                                      return Container(
                                                                                                        color: Colors.red.withOpacity(0.4),
                                                                                                        height: 40,
                                                                                                        child: Row(
                                                                                                          children: [
                                                                                                            Text('${index2 + 1}'),
                                                                                                            kWidth20,
                                                                                                            Text(snapsh.data!.docs[index2]['studentName']),
                                                                                                            const Spacer(),
                                                                                                            IconButton(
                                                                                                                onPressed: () async {
                                                                                                                  return showDialog(
                                                                                                                    context: context,
                                                                                                                    barrierDismissible: false, // user must tap button!
                                                                                                                    builder: (BuildContext context) {
                                                                                                                      return AlertDialog(
                                                                                                                        title: const Text('Update Attendance'),
                                                                                                                        content: SingleChildScrollView(
                                                                                                                          child: ListBody(
                                                                                                                            children: <Widget>[
                                                                                                                              Row(
                                                                                                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                                                                children: [
                                                                                                                                  GestureDetector(
                                                                                                                                    onTap: () async {
                                                                                                                                      log('index${snapshot.data!.docs[index]}');
                                                                                                                                      log('Studentname?????${snapsh.data!.docs[index2]['studentName']}');

                                                                                                                                      await FirebaseFirestore.instance.collection("SchoolListCollection").doc(schoolId).collection(batchId).doc(batchId).collection("classes").doc(classID).collection("Attendence").doc(month).collection(month).doc(date).collection("Subjects").doc(snapshot.data!.docs[index]['docid']).collection("PresentList").doc(snapsh.data!.docs[index2]['uid']).update({'present': true}).then((value) {
                                                                                                                                        showToast(msg: 'Changed');
                                                                                                                                        Get.back();
                                                                                                                                      });
                                                                                                                                    },
                                                                                                                                    child: Container(
                                                                                                                                      color: Colors.green.withOpacity(0.4),
                                                                                                                                      height: 40,
                                                                                                                                      width: 120,
                                                                                                                                      child: const Center(
                                                                                                                                        child: Text('Present'),
                                                                                                                                      ),
                                                                                                                                    ),
                                                                                                                                  ),
                                                                                                                                  GestureDetector(
                                                                                                                                    onTap: () async {
                                                                                                                                      log('Studentname${snapsh.data!.docs[index2]['studentName']}');

                                                                                                                                      FirebaseFirestore.instance.collection("SchoolListCollection").doc(schoolId).collection(batchId).doc(batchId).collection("classes").doc(classID).collection("Attendence").doc(month).collection(month).doc(date).collection("Subjects").doc(snapshot.data!.docs[index]['docid']).collection("PresentList").doc(snapsh.data!.docs[index2]['uid']).update({'present': false}).then((value) {
                                                                                                                                        showToast(msg: 'Changed');
                                                                                                                                        Get.back();
                                                                                                                                      });
                                                                                                                                    },
                                                                                                                                    child: Container(
                                                                                                                                      color: Colors.red.withOpacity(0.4),
                                                                                                                                      height: 40,
                                                                                                                                      width: 120,
                                                                                                                                      child: const Center(
                                                                                                                                        child: Text("Absent"),
                                                                                                                                      ),
                                                                                                                                    ),
                                                                                                                                  )
                                                                                                                                ],
                                                                                                                              )
                                                                                                                            ],
                                                                                                                          ),
                                                                                                                        ),
                                                                                                                        actions: <Widget>[
                                                                                                                          TextButton(
                                                                                                                            child: const Text('Ok'),
                                                                                                                            onPressed: () {
                                                                                                                              Navigator.of(context).pop();
                                                                                                                            },
                                                                                                                          ),
                                                                                                                        ],
                                                                                                                      );
                                                                                                                    },
                                                                                                                  );
                                                                                                                },
                                                                                                                icon: const Icon(Icons.edit))
                                                                                                          ],
                                                                                                        ),
                                                                                                      );
                                                                                                    }
                                                                                                  },
                                                                                                  separatorBuilder: (context, index2) {
                                                                                                    return const Divider();
                                                                                                  },
                                                                                                  itemCount: snapsh.data!.docs.length);
                                                                                            } else {
                                                                                              return const Center();
                                                                                            }
                                                                                          }),
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                              actions: <Widget>[
                                                                                TextButton(
                                                                                  child: const Text('Ok'),
                                                                                  onPressed: () {
                                                                                    Navigator.of(context).pop();
                                                                                  },
                                                                                ),
                                                                              ],
                                                                            );
                                                                          },
                                                                        );
                                                                      },
                                                                      icon: const Icon(
                                                                        Icons
                                                                            .edit,
                                                                        size:
                                                                            11,
                                                                      ))),
                                                            );
                                                          }
                                                        } else {
                                                          return const Text('');
                                                        }
                                                      })
                                                ],
                                              );
                                            }
                                          } else {
                                            return const Text('');
                                          }
                                        }),
                                    Text(
                                      ' ${index + 1}. ${snapshot.data!.docs[index]['subject']} ',
                                      style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    kHeight10,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          'T:  ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                        ),
                                        Text(
                                          formatted,
                                          style: const TextStyle(fontSize: 12),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
        },
      )),
    );
  }
}

pageTimeexprided() async {
  await Future.delayed(const Duration(minutes: 1));
  Get.back();
  Get.back();
  Get.back();
}
