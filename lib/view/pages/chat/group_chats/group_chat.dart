import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/group_chat_controller/group_chat_controller.dart';
import '../teacher_section/parents_message/parents_messages.dart';
import '../teacher_section/student_message/students_messages.dart';

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
                length: 3,
                child: Scaffold(
                  appBar: AppBar(
                    bottom: const TabBar(tabs: [
                      Tab(
                        icon: Icon(Icons.abc),
                      ),
                      Tab(
                        icon: Icon(Icons.abc),
                      ),
                      Tab(
                        icon: Icon(Icons.abc),
                      )
                    ]),
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
          } else {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
        });
  }
}
