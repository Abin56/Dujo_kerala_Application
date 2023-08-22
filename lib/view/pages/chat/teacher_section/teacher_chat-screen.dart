import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/pages/chat/teacher_section/parents_message/parents_messages.dart';
import 'package:dujo_kerala_application/view/pages/chat/teacher_section/student_message/students_messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/get_utils.dart';

import '../../../../controllers/userCredentials/user_credentials.dart';
import '../../../constant/sizes/constant.dart';
import '../group_chats/group_chat.dart';

class TeacherChatScreen extends StatelessWidget {
  const TeacherChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    log(DateTime.now().toString());
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: adminePrimayColor,
          title: Text('Dujo Chat'.tr),
          bottom: TabBar(
            tabs: [
              Tab(
                icon: ListView(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 0),
                      child: Icon(Icons.group),
                    ),
                    //////////////////////////////////////////////////////////////////////////////////////////////////
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Students".tr,
                          style: TextStyle(fontSize: 17.sp),
                        ),
                        StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('SchoolListCollection')
                              .doc(UserCredentialsController.schoolId)
                              .collection("Teachers")
                              .doc(
                                  UserCredentialsController.teacherModel?.docid)
                              .collection('StudentChatCounter')
                              .doc('F0Ikn1UouYIkqmRFKIpg')
                              .snapshots(),
                          builder: (context, messageIndex) {
                            if (messageIndex.hasData) {
                              if (messageIndex.data!.data() == null) {
                                return const Text('');
                              } else if (messageIndex.data!
                                      .data()!['chatIndex'] <=
                                  0) {
                                FirebaseFirestore.instance
                                    .collection('SchoolListCollection')
                                    .doc(UserCredentialsController.schoolId)
                                    .collection("Teachers")
                                    .doc(UserCredentialsController
                                        .teacherModel?.docid)
                                    .collection('StudentChatCounter')
                                    .doc('F0Ikn1UouYIkqmRFKIpg')
                                    .update({'chatIndex': 0});
                                return CircleAvatar(
                                  radius: 10.sp,
                                  backgroundColor: Colors.white,
                                  child: Center(
                                    child: Text(
                                      '0',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                );
                              } else {
                                MessageCounter.studentMessageCounter =
                                    messageIndex.data?.data()?['chatIndex'];
                                return Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: CircleAvatar(
                                    radius: 10,
                                    backgroundColor: Colors.white,
                                    child: Center(
                                      child: Text(
                                        messageIndex.data!
                                            .data()!['chatIndex']
                                            .toString(),
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                );
                              }
                            } else {
                              return const Center(
                                child: CircularProgressIndicator.adaptive(),
                              );
                            }
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Tab(
                icon: ListView(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 0),
                      child: Icon(Icons.group),
                    ),
                    //////////////////////////////////////////////////////////////////////////////////////////////////
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Parents".tr,
                          style: TextStyle(fontSize: 17.sp),
                        ),
                        StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('SchoolListCollection')
                              .doc(UserCredentialsController.schoolId)
                              .collection("Teachers")
                              .doc(
                                  UserCredentialsController.teacherModel?.docid)
                              .collection('ParentChatCounter')
                              .doc('F0Ikn1UouYIkqmRFKIpg')
                              .snapshots(),
                          builder: (context, messageIndex) {
                            if (messageIndex.hasData) {
                              if (messageIndex.data!.data() == null) {
                                return const Text('');
                              } else if (messageIndex.data!
                                      .data()!['chatIndex'] <=
                                  0) {
                                FirebaseFirestore.instance
                                    .collection('SchoolListCollection')
                                    .doc(UserCredentialsController.schoolId)
                                    .collection("Teachers")
                                    .doc(UserCredentialsController
                                        .teacherModel?.docid)
                                    .collection('ParentChatCounter')
                                    .doc('F0Ikn1UouYIkqmRFKIpg')
                                    .update({'chatIndex': 0});
                                return const CircleAvatar(
                                  radius: 10,
                                  backgroundColor: Colors.white,
                                  child: Center(
                                    child: Text(
                                      '0',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                );
                              } else {
                                MessageCounter.parentMessageCounter =
                                    messageIndex.data?.data()?['chatIndex'];
                                return Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: CircleAvatar(
                                    radius: 10.sp,
                                    backgroundColor: Colors.white,
                                    child: Center(
                                      child: Text(
                                        messageIndex.data!
                                            .data()!['chatIndex']
                                            .toString(),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                );
                              }
                            } else {
                              return const Center(
                                child: CircularProgressIndicator.adaptive(),
                              );
                            }
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Tab(
                  icon: const Icon(
                    Icons.class_,
                  ),
                  text: 'Group'.tr),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            const StudentsMessagesScreen(),
            const ParentMessagesScreen(),
            GroupChatScreenForTeachers(),
          ],
        ),
      ),
    );
  }
}
