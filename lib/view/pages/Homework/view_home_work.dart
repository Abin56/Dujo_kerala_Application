import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/utils/utils.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/constant/sizes/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controllers/userCredentials/user_credentials.dart';
import '../../constant/sizes/sizes.dart';
import '../../widgets/fonts/google_poppins.dart';

class ViewHomeWorks extends StatelessWidget {
  const ViewHomeWorks({super.key});

  @override
  Widget build(BuildContext context) {
    log("message");
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: Row(
          children: [
            kHeight20,
            GooglePoppinsWidgets(text: "HomeWorks".tr, fontsize: 20.h)
          ],
        ),
        backgroundColor: adminePrimayColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("SchoolListCollection")
                      .doc(UserCredentialsController.schoolId!)
                      .collection(UserCredentialsController.batchId!)
                      .doc(UserCredentialsController.batchId!)
                      .collection("classes")
                      .doc(UserCredentialsController.classId!)
                      .collection("HomeWorks")
                      .snapshots(),
                  builder: (context, snaps) {
                    if (snaps.hasData) {
                      return ListView.separated(
                          itemCount: snaps.data!.docs.length,
                          separatorBuilder: ((context, index) {
                            return kHeight10;
                          }),
                          itemBuilder: (BuildContext context, int index) {
                            final exdate = snaps.data!.docs[index]['endDate'];

                            final extime = DateTime.parse(exdate)
                                .difference(DateTime.now())
                                .inHours;

                            if (DateTime.parse(exdate)
                                .isBefore(DateTime.now())) {
                              FirebaseFirestore.instance
                                  .collection("SchoolListCollection")
                                  .doc(UserCredentialsController.schoolId!)
                                  .collection(
                                      UserCredentialsController.batchId!)
                                  .doc(UserCredentialsController.batchId!)
                                  .collection("classes")
                                  .doc(UserCredentialsController.classId!)
                                  .collection("HomeWorks")
                                  .doc(snaps.data!.docs[index]['docid'])
                                  .delete();
                            }
                            return Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 10.h, right: 10.h, top: 10.h),
                                  child: Card(
                                    color: const Color.fromARGB(236, 228, 244, 255),
                                    child: ListTile(
                                      
                                        shape: const BeveledRectangleBorder(
                                            side: BorderSide(
                                                color: Color.fromARGB(255, 125, 169, 225),
                                                width: 0.2)),
                                        leading: const Icon(Icons.paste_sharp),
                                        title: FutureBuilder(
                                            future: FirebaseFirestore.instance
                                                .collection(
                                                    "SchoolListCollection")
                                                .doc(UserCredentialsController
                                                    .schoolId!)
                                                .collection(
                                                    UserCredentialsController
                                                        .batchId!)
                                                .doc(UserCredentialsController
                                                    .batchId!)
                                                .collection("classes")
                                                .doc(UserCredentialsController
                                                    .classId!)
                                                .collection('subjects')
                                                .doc(snaps.data?.docs[index]
                                                    ['subjectid'])
                                                .get(),
                                            builder: (context, snapshot) {
                                              log("message${snaps.data?.docs[index]['subjectid']}");
                                              if (snapshot.hasData) {
                                                if (snapshot.data!.data() !=
                                                    null) {
                                                  return GooglePoppinsWidgets(
                                                    text: snapshot.data
                                                                ?.data()?[
                                                            'subjectName'] ??
                                                        '',
                                                    fontsize: 17.h,
                                                    fontWeight: FontWeight.w700,
                                                  );
                                                } else {
                                                  return const Text('');
                                                }
                                              } else {
                                                return const Text('');
                                              }
                                            }),
                                        subtitle: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(top: 10.h),
                                              child: FutureBuilder(
                                                  future: FirebaseFirestore
                                                      .instance
                                                      .collection(
                                                          "SchoolListCollection")
                                                      .doc(
                                                          UserCredentialsController
                                                              .schoolId!)
                                                      .collection(
                                                          UserCredentialsController
                                                              .batchId!)
                                                      .doc(
                                                          UserCredentialsController
                                                              .batchId!)
                                                      .collection("classes")
                                                      .doc(
                                                          UserCredentialsController
                                                              .classId!)
                                                      .collection('subjects')
                                                      .doc(snaps
                                                              .data?.docs[index]
                                                          ['subjectid'])
                                                      .get(),
                                                  builder: (context, snaps) {
                                                    return GooglePoppinsWidgets(
                                                        text:
                                                            "Subject : ${snaps.data?.data()?['subjectName'] ?? ''}",
                                                        fontsize: 15.h,
                                                        fontWeight:
                                                            FontWeight.bold);
                                                  }),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(top: 10.h),
                                              child: Row(
                                                children: [
                                                  GooglePoppinsWidgets(
                                                      text: "Task : ",
                                                      fontsize: 15.h,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  InkWell(
                                                    onTap: () async {
                                                      return showDialog(
                                                        context: context,
                                                        barrierDismissible:
                                                            false, // user must tap button!
                                                        builder: (BuildContext
                                                            context) {
                                                          return AlertDialog(
                                                            title: const Text(
                                                                'Task'),
                                                            content:
                                                                SingleChildScrollView(
                                                              child: ListBody(
                                                                children: <
                                                                    Widget>[
                                                                  Text(snaps.data
                                                                              ?.docs[
                                                                          index]
                                                                      ['tasks'])
                                                                ],
                                                              ),
                                                            ),
                                                            actions: <Widget>[
                                                              TextButton(
                                                                child:
                                                                    const Text(
                                                                        'Ok'),
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      );
                                                    },
                                                    child: GooglePoppinsWidgets(
                                                      text: "View",
                                                      fontsize: 16.h,
                                                      color: adminePrimayColor,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(top: 10.h),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  GooglePoppinsWidgets(
                                                      text:
                                                          "From : ${stringTimeToDateConvert(snaps.data!.docs[index]['uploadDate'])}",
                                                      fontsize: 15.h,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  Row(
                                                    children: [
                                                      GooglePoppinsWidgets(
                                                          text: "To : ",
                                                          fontsize: 15.h,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      GooglePoppinsWidgets(
                                                          text:
                                                              '$extime hr left ',
                                                          fontsize: 13.h,
                                                          color: cred,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(top: 10.h),
                                              child: FutureBuilder(
                                                  future: FirebaseFirestore
                                                      .instance
                                                      .collection(
                                                          "SchoolListCollection")
                                                      .doc(
                                                          UserCredentialsController
                                                                  .schoolId ??
                                                              "")
                                                      .collection('Teachers')
                                                      .doc(snaps.data
                                                                  ?.docs[index]
                                                              ['teacherid'] ??
                                                          '')
                                                      .get(),
                                                  builder: (context, snaps) {
                                                    if (snaps.hasData) {
                                                      return Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          GooglePoppinsWidgets(
                                                              text:
                                                                  "Assigned Teacher: ",
                                                              fontsize: 11.h),
                                                          Flexible(
                                                            child: GooglePoppinsWidgets(
                                                                text: snaps.data
                                                                        ?.data()?[
                                                                    'teacherName'],
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontsize: 12.h),
                                                          ),
                                                        ],
                                                      );
                                                    } else {
                                                      return const Center(
                                                        child:
                                                            CircularProgressIndicator(),
                                                      );
                                                    }
                                                  }),
                                            ),
                                          ],
                                        )),
                                  ),
                                ),
                              ],
                            );
                          });
                    } else {
                      return const Center(
                        child: circularProgressIndicatotWidget,
                      );
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
