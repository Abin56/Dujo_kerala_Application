import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/pages/chat/teacher_section/student_message/students_messages.dart';
import 'package:flutter/material.dart';

import '../../../../controllers/userCredentials/user_credentials.dart';
import '../../../constant/sizes/constant.dart';

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
                                .collection("Teachers")
                                .doc(UserCredentialsController
                                    .teacherModel!.docid)
                                .collection('StudentChatCounter')
                                .doc('F0Ikn1UouYIkqmRFKIpg')
                                .snapshots(),
                            builder: (context, messageIndex) {
                              if (messageIndex.hasData) {
                                MessageCounter.studentMessageCounter =
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
            StudentsMessagesScreen(
                studentMessageCounter: MessageCounter.studentMessageCounter),
            const Icon(Icons.directions_transit, size: 350),
            const Icon(Icons.directions_car, size: 350),
          ],
        ),
      ),
    );
  }
}
