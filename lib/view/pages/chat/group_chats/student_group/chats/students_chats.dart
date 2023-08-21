import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:dujo_kerala_application/utils/utils.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:dujo_kerala_application/view/pages/chat/group_chats/student_group/chats/chat_appBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../controllers/group_chat_controller/group_StudentsTeacher_chat_controller.dart';
import '../../group_chat.dart';

class StudentsGroupChats extends StatefulWidget {
  String groupName;
  String groupId;

  StudentsGroupChats(
      {required this.groupId, required this.groupName, super.key});

  @override
  State<StudentsGroupChats> createState() => _StudentsGroupChatsState();
}

class _StudentsGroupChatsState extends State<StudentsGroupChats> {
  TeacherGroupChatController teacherGroupChatController =
      Get.put(TeacherGroupChatController());

  int currentStudentMessageIndex = 0;

  int currentStudentMessageIndex2 = 0;

  int teacherIndex = 0;

  @override
  void initState() {
    userIndexBecomeZero(widget.groupId,'Students',teacherParameter: 'studentName');
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 242, 224),
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Row(
          children: [
            GestureDetector(
                onTap: () {
                  showStudentsGroupAppBar(widget.groupName, '10', widget.groupId, context);
                },
                child: const CircleAvatar()),
            kWidth10,
            Text(widget.groupName),
          ],
        ),
        backgroundColor: adminePrimayColor,
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('SchoolListCollection')
              .doc(UserCredentialsController.schoolId)
              .collection(UserCredentialsController.batchId!)
              .doc(UserCredentialsController.batchId!)
              .collection('classes')
              .doc(UserCredentialsController.classId!)
              .collection('ChatGroups')
              .doc('ChatGroups')
              .collection("Students")
              .doc(widget.groupId)
              .collection('Participants')
              .snapshots(),
          builder: (context, checkingParticipantssnaps) {
            if (checkingParticipantssnaps.hasData) {
              if (checkingParticipantssnaps.data!.docs.isEmpty) {
                return Center(
                  child: TextButton.icon(
                      onPressed: () async {
                        teacherGroupChatController.addParticipants(widget.groupId);
                      },
                      icon: const Icon(Icons.add),
                      label: const Text("Add Participants")),
                );
              } else {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height / 1.20,
                        width: size.width,
                        child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('SchoolListCollection')
                                .doc(UserCredentialsController.schoolId)
                                .collection(UserCredentialsController.batchId!)
                                .doc(UserCredentialsController.batchId!)
                                .collection('classes')
                                .doc(UserCredentialsController.classId!)
                                .collection('ChatGroups')
                                .doc('ChatGroups')
                                .collection("Students")
                                .doc(widget.groupId)
                                .collection('chats')
                                .orderBy('sendTime', descending: true)
                                .snapshots(),
                            builder: (context, snaps) {
                              if (snaps.hasData) {
                                if (snaps.data!.docs.isEmpty) {
                                  return const Center(
                                    child: Text(""),
                                  );
                                } else {
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    controller: ScrollController(),
                                    reverse: true,
                                    itemCount: snaps.data!.docs.length,
                                    itemBuilder: (context, index) {
                                      ///////////////////////////////////
                                      return teacherGroupChatController
                                          .messageTitles(
                                              size,
                                              snaps.data!.docs[index]['chatid'],
                                              snaps.data!.docs[index]
                                                  ['message'],
                                              snaps.data!.docs[index]['docid'],
                                              snaps.data!.docs[index]
                                                  ['sendTime'],
                                              context,
                                              widget.groupId,
                                              snaps.data!.docs[index]['username']
                                              
                                              );
                                      ///////////////////////////////
                                    },
                                  );
                                }
                              } else {
                                return const Center(
                                    child:
                                        CircularProgressIndicator.adaptive());
                              }
                            }),
                      ),
                      StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('SchoolListCollection')
                              .doc(UserCredentialsController.schoolId)
                              .collection(UserCredentialsController.batchId!)
                              .doc(UserCredentialsController.batchId!)
                              .collection('classes')
                              .doc(UserCredentialsController.classId)
                              .collection('ChatGroups')
                              .doc('ChatGroups')
                              .collection('Students')
                              .doc(widget.groupId)
                              .snapshots(),
                          builder: (context, checkingblock) {
                            if (checkingblock.hasData) {
                              if (checkingblock.data?.data()?['activate'] ==
                                  false) {
                                return GestureDetector(
                                  onTap: () async {},
                                  child: SizedBox(
                                    height: size.height / 15,
                                    width: size.width,
                                    child: Column(
                                      children: const [
                                        Text(
                                            'Sorry!! This group is not active now.'),
                                        SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              } else {
                                return SizedBox(
                                  height: size.height / 15,
                                  width: size.width,
                                  // alignment: Alignment.center,
                                  child: SizedBox(
                                    height: size.height / 12,
                                    width: size.width / 1.1,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        SizedBox(
                                          height: size.height / 17,
                                          width: size.width / 1.3,
                                          child: TextField(
                                            controller:
                                                teacherGroupChatController
                                                    .messageController,
                                            decoration: InputDecoration(
                                                hintText: "Send Message",
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                )),
                                          ),
                                        ),
                                        FutureBuilder(
                                            future: FirebaseFirestore.instance
                                                .collection(
                                                    'SchoolListCollection')
                                                .doc(UserCredentialsController
                                                    .schoolId)
                                                .collection('Teachers')
                                                .doc(FirebaseAuth
                                                    .instance.currentUser!.uid)
                                                .get(),
                                            builder: (context, userName) {
                                              if (userName.hasData) {
                                                return CircleAvatar(
                                                  radius: 28,
                                                  backgroundColor:
                                                      adminePrimayColor,
                                                  child: Center(
                                                    child: IconButton(
                                                        icon: const Icon(
                                                          Icons.send,
                                                          color: Colors.white,
                                                        ),
                                                        onPressed: () async {
                                                          ///////////////////////////
                                                          ///
                                                          teacherGroupChatController
                                                              .sendMessage(
                                                                  widget.groupId,
                                                                  userName.data!
                                                                          .data()![
                                                                      'teacherName']);
                                                          /////////////////////////
                                                        }),
                                                  ),
                                                );
                                              } else {
                                                return const Center();
                                              }
                                            }),
                                      ],
                                    ),
                                  ),
                                );
                              }
                            } else if (checkingblock.data?.data() == null) {
                              return const Text("data");
                            } else {
                              return const Center(
                                child: CircularProgressIndicator.adaptive(),
                              );
                            }
                          }),
                    ],
                  ),
                );
              }
            } else {
              return const Center(
                child: circularProgressIndicatotWidget,
              );
            }
          }),
    );
  }
}
