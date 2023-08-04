import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:dujo_kerala_application/utils/utils.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:dujo_kerala_application/view/pages/chat/group_chats/student_group/chats/chat_appBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../controllers/chat_controller/student_controller/student_controller.dart';
import '../../../../../../controllers/group_chat_controller/group_chat_controller.dart';

class StudentsGroupChats extends StatefulWidget {
  TeacherGroupChatController teacherGroupChatController =
      Get.put(TeacherGroupChatController());
  String groupName;
  String groupId;

  StudentsGroupChats(
      {required this.groupId, required this.groupName, super.key});

  @override
  State<StudentsGroupChats> createState() => _StudentsGroupChatsState();
}

class _StudentsGroupChatsState extends State<StudentsGroupChats> {
  final studentChatController = Get.put(StudentChatController());

  int currentStudentMessageIndex = 0;
  int currentStudentMessageIndex2 = 0;
  int teacherIndex = 0;

  @override
  void initState() {
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
                  showStudentsGroupAppBar(widget.groupName, '10', widget.groupId);

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
                        widget.teacherGroupChatController
                            .addParticipants(widget.groupId);
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
                                .collection('Participants')
                                .snapshots(),
                            builder: (context, snaps) {
                              if (snaps.hasData) {
                                if (snaps.data!.docs.isEmpty) {
                                  return const Center(
                                    child: Text("data"),
                                  );
                                } else {
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    controller: ScrollController(),
                                    reverse: true,
                                    itemCount: snaps.data!.docs.length,
                                    itemBuilder: (context, index) {
                                      return const Text('data');
                                      ///////////////////////////////////
                                      // return studentChatController.messageTitles(
                                      //     widget.teacherDocID,
                                      //     size,
                                      //     snaps.data!.docs[index]['chatid'],
                                      //     snaps.data!.docs[index]['message'],
                                      //     snaps.data!.docs[index]['docid'],
                                      //     snaps.data!.docs[index]['sendTime'],
                                      //     context);
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
                      SizedBox(
                        height: size.height / 15,
                        width: size.width,
                        // alignment: Alignment.center,
                        child: SizedBox(
                          height: size.height / 12,
                          width: size.width / 1.1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                height: size.height / 17,
                                width: size.width / 1.3,
                                child: TextField(
                                  controller:
                                      studentChatController.messageController,
                                  decoration: InputDecoration(
                                      hintText: "Send Message",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      )),
                                ),
                              ),
                              CircleAvatar(
                                radius: 28,
                                backgroundColor: adminePrimayColor,
                                child: Center(
                                  child: IconButton(
                                      icon: const Icon(
                                        Icons.send,
                                        color: Colors.white,
                                      ),
                                      onPressed: () async {
                                        // log('teacherName >>>>  ${widget.teacherDocID}');
                                        // ///////////////////////////
                                        // ///
                                        // studentChatController.sentMessage(
                                        //   widget.teacherDocID,
                                        //   await getCurrentTeacherMessageIndex(),
                                        //   await getTeacherChatCounterIndex(),
                                        // );
                                        /////////////////////////
                                      }),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
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

  // }
}
