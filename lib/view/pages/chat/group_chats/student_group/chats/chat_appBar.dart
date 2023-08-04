import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:dujo_kerala_application/view/home/events/event_display_school_level.dart';
import 'package:dujo_kerala_application/view/pages/Notice/notice_school_display_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../controllers/group_chat_controller/group_chat_controller.dart';

showStudentsGroupAppBar(  String groupName,
  String totalStudents,
  String groupID,)async{
      TeacherGroupChatController teacherGroupChatController =
      Get.put(TeacherGroupChatController());
  Get.bottomSheet(
    ListView(
          children: [
            Container(
              height: 300,
              decoration: const BoxDecoration(color: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const CircleAvatar(
                    radius: 40,
                  ),
                  GooglePoppinsWidgetsNotice(
                    text: groupName,
                    fontsize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  Text("Group $totalStudents participants")
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 500,
              decoration: const BoxDecoration(color: Colors.white),
              child: Column(
                children: [
                  SizedBox(
                    height: 60,
                    child: Row(
                      children: [
                        GooglePoppinsWidgetsNotice(
                          text: '10  participants',
                          fontsize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                        const SizedBox(width: 30,),
                        IconButton(
                            onPressed: () async {
                              teacherGroupChatController
                                  .customAddStudentInGroup(groupID);
                            },
                            icon: const Icon(Icons.person_add)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 380,
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('SchoolListCollection')
                          .doc(UserCredentialsController.schoolId)
                          .collection(UserCredentialsController.batchId!)
                          .doc(UserCredentialsController.batchId)
                          .collection('classes')
                          .doc(UserCredentialsController.classId)
                          .collection('ChatGroups')
                          .doc('ChatGroups')
                          .collection('Students')
                          .doc(groupID)
                          .collection('Participants')
                          .snapshots(),
                      builder: (context, studentssnapshots) {
if (studentssnapshots.hasData) {
                          return ListView.separated(
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onLongPress: () async {
                                  await teacherGroupChatController
                                      .removeStudentToGroup(
                                    studentssnapshots.data!.docs[index]
                                        ['docid'],
                                    groupID,
                                  );
                                },
                                child: Container(
                                  height: 60,
                                  color: Colors.blue.withOpacity(0.1),
                                  child: Row(
                                    children: [
                                      Text("  ${index + 1}"),
                                      const SizedBox(
                                        width: 07,
                                      ),
                                      const CircleAvatar(),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      GooglePoppinsEventsWidgets(
                                          text: studentssnapshots
                                              .data!.docs[index]['studentName'],
                                          fontsize: 12)
                                    ],
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 10,
                              );
                            },
                            itemCount: studentssnapshots.data!.docs.length);
}else{
  return const Center(
    child: CircularProgressIndicator.adaptive(),
  )
  ;
}
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
  );
}