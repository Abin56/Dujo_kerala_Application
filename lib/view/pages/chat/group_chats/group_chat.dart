import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/pages/chat/group_chats/student_group/student_groups.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../controllers/group_chat_controller/group_chat_controller.dart';
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
                          Tab(text: 'Students'),
                          Tab(text: "Parents")
                        ],
                      ),
                    ),
                  ),
                  body: const TabBarView(
                    children: [
                      StudentsGroupsMessagesScreen(),
                      ParentMessagesScreen(),
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
