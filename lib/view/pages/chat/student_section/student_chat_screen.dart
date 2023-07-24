import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/pages/chat/student_section/teachers_message/teacher_messages.dart';
import 'package:dujo_kerala_application/view/pages/chat/teacher_section/student_message/students_messages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../controllers/userCredentials/user_credentials.dart';
import '../../../constant/sizes/constant.dart';

class StudentChatScreen extends StatelessWidget {
  const StudentChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: adminePrimayColor,
          title: const Text('Dujo Chat'),
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 0),
                      child: Icon(Icons.group),
                    ),
                    //////////////////////////////////////////////////////////////////////////////////////////////////
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Students"),
                        StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('SchoolListCollection')
                                .doc(UserCredentialsController.schoolId)
                                .collection(UserCredentialsController.batchId!)
                                .doc(UserCredentialsController.batchId)
                                .collection('classes')
                                .doc(UserCredentialsController.classId)
                                .collection('Students')
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .collection("TeacherChatCounter")
                                .doc("c3cDX5ymHfITQ3AXcwSp")
                                .snapshots(),
                            builder: (context, messageIndex) {
                              if (messageIndex.hasData) {
                                MessageCounter.teacherMessageCounter =
                                    messageIndex.data!.data()!['chatIndex'];
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
                                      ))),
                                );
                              } else {
                                return const Center(
                                  child: CircularProgressIndicator.adaptive(),
                                );
                              }
                            }),
                      ],
                    )
                  ],
                ),
              ),
              const Tab(icon: Icon(Icons.groups_2), text: 'Parents'),
              const Tab(
                  icon: Icon(
                    Icons.class_,
                  ),
                  text: 'Group'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            TeachersMessagesScreen(
                taecherMessageCounter: MessageCounter.teacherMessageCounter),
            const Icon(Icons.directions_transit, size: 350),
            const Icon(Icons.directions_car, size: 350),
          ],
        ),
      ),
    );
  }
}
