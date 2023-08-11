import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/pages/chat/group_chats/parent_group/parent_groups.dart';
import 'package:dujo_kerala_application/view/pages/chat/group_chats/student_group/student_groups.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../controllers/group_chat_controller/group_StudentsTeacher_chat_controller.dart';
import '../teacher_section/parents_message/parents_messages.dart';

class GroupChatScreenForTeachers extends StatelessWidget {
  TeacherGroupChatController teacherGroupChatController =
      Get.put(TeacherGroupChatController());
  GroupChatScreenForTeachers({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('SchoolListCollection')
            .doc(UserCredentialsController.schoolId)
            .collection(UserCredentialsController.batchId!)
            .doc(UserCredentialsController.batchId)
            .collection('classes')
            .doc(UserCredentialsController.classId)
            .collection('ChatGroups')
            .snapshots(),
        builder: (context, snaps) {
          if (snaps.hasData) {
            if (snaps.data!.docs.isEmpty) {
              return Center(
                child: TextButton.icon(
                    onPressed: () async {
                      teacherGroupChatController.createGroupChatForWho(context);
                    },
                    icon: const Icon(Icons.add),
                    label: const Text("Create a group")),
              );
            } else {
              return DefaultTabController(
                length: 2,
                child: Scaffold(
                  appBar: PreferredSize(
                    preferredSize: const Size.fromHeight(50.0),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 7, right: 7, top: 7),
                      child: TabBar(
                        labelPadding:
                            EdgeInsetsDirectional.symmetric(horizontal: 80.w),
                        isScrollable: true,
                        unselectedLabelColor: Colors.black,
                        labelColor: Colors.white,
                        indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: adminePrimayColor),
                        tabs: const [
                          Tab(
                            text: 'Students',
                          ),
                          Tab(text: "Parents")
                        ],
                      ),
                    ),
                  ),
                  body: const TabBarView(
                    children: [
                      StudentsGroupsMessagesScreen(),
                      ParentssGroupsMessagesScreen(),
                    ],
                  ),
                  floatingActionButton: FutureBuilder(
                      future: FirebaseFirestore.instance
                          .collection('SchoolListCollection')
                          .doc(UserCredentialsController.schoolId)
                          .collection(UserCredentialsController.batchId!)
                          .doc(UserCredentialsController.batchId)
                          .collection('classes')
                          .doc(UserCredentialsController.classId)
                          .get(),
                      builder: (context, checkClassTeacher) {
                        if (checkClassTeacher.hasData) {
                          if (checkClassTeacher.data!
                                  .data()!['classTeacherdocid'] ==
                              FirebaseAuth.instance.currentUser!.uid) {
                            return FloatingActionButton(
                              child: const Icon(Icons.add),
                              onPressed: () async {
                                teacherGroupChatController
                                    .createGroupChatForWho(context);
                              },
                            );
                          } else {
                            return const Text('');
                          }
                        } else {
                          return const Text('');
                        }
                      }),
                ),
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
        });
  }
}

userIndexBecomeZero(String docid,String groupName,{required String teacherParameter}) async {
  log("message Caliingggggggggggggggggggggggggg");
  final firebase = await FirebaseFirestore.instance
      .collection('SchoolListCollection')
      .doc(UserCredentialsController.schoolId)
      .collection(UserCredentialsController.batchId!)
      .doc(UserCredentialsController.batchId)
      .collection('classes')
      .doc(UserCredentialsController.classId)
      .collection('ChatGroups')
      .doc('ChatGroups')
      .collection(groupName)
      .doc(docid)
      .collection('Participants')
      .get();
  if (firebase.docs.isNotEmpty) {
    addteacherTopaticipance(docid,groupName,teacherParameter:teacherParameter );
    await FirebaseFirestore.instance
        .collection('SchoolListCollection')
        .doc(UserCredentialsController.schoolId)
        .collection(UserCredentialsController.batchId!)
        .doc(UserCredentialsController.batchId)
        .collection('classes')
        .doc(UserCredentialsController.classId)
        .collection('ChatGroups')
        .doc('ChatGroups')
        .collection(groupName)
        .doc(docid)
        .collection('Participants')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .set({'messageIndex': 0}, SetOptions(merge: true));
  }
}
