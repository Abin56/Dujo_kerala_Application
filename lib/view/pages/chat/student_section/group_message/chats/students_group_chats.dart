import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../controllers/group_chat_controller/studentchat_controller/student_chat_controller.dart';
import '../../../group_chats/group_chat.dart';

class StudenstGroupChatsScreen extends StatefulWidget {
  String groupID;
  String groupName;

  StudenstGroupChatsScreen(
      {required this.groupID, required this.groupName, super.key});

  @override
  State<StudenstGroupChatsScreen> createState() =>
      _StudenstGroupChatsScreenState();
}

class _StudenstGroupChatsScreenState extends State<StudenstGroupChatsScreen> {
  final studentGroupChatMessageController =
      Get.put(StudentGroupChatMessageController());

  int currentStudentMessageIndex = 0;

  int currentStudentMessageIndex2 = 0;

  int teacherIndex = 0;

  @override
  void initState() {
    userIndexBecomeZero(widget.groupID, 'Students',teacherParameter: 'studentName');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log("getStudentTeacherChatIndex().toString()$teacherIndex");
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 242, 224),
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Row(
          children: [
            const CircleAvatar(),
            kWidth10,
            Text(widget.groupName),
          ],
        ),
        backgroundColor: adminePrimayColor,
      ),
      body: SingleChildScrollView(
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
                      .doc(UserCredentialsController.classId)
                      .collection('ChatGroups')
                      .doc('ChatGroups')
                      .collection('Students')
                      .doc(widget.groupID)
                      .collection('chats')
                      .orderBy('sendTime', descending: true)
                      .snapshots(),
                  builder: (context, snaps) {
                    if (snaps.hasData) {
                      return ListView.builder(
                        shrinkWrap: true,
                        controller: ScrollController(),
                        reverse: true,
                        itemCount: snaps.data!.docs.length,
                        itemBuilder: (context, index) {
                          ///////////////////////////////////
                          return studentGroupChatMessageController
                              .messageTitles(
                                  size,
                                  snaps.data!.docs[index]['chatid'],
                                  snaps.data!.docs[index]['message'],
                                  snaps.data!.docs[index]['docid'],
                                  snaps.data!.docs[index]['sendTime'],
                                  context,
                                  widget.groupID,
                                  snaps.data!.docs[index]['username']);
                          ///////////////////////////////
                        },
                      );
                    } else {
                      return const Center(
                          child: CircularProgressIndicator.adaptive());
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
                    .doc(widget.groupID)
                    .snapshots(),
                builder: (context, checkingblock) {
                  if (checkingblock.hasData) {
                    if (checkingblock.data?.data()?['activate'] == false) {
                      return GestureDetector(
                        onTap: () async {},
                        child: SizedBox(
                          height: size.height / 15,
                          width: size.width,
                          child: Column(
                            children: const [
                              Text('Sorry!! This group is not active now.'),
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
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                height: size.height / 17,
                                width: size.width / 1.3,
                                child: TextField(
                                  controller: studentGroupChatMessageController
                                      .messageController,
                                  decoration: InputDecoration(
                                      hintText: "Send Message",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      )),
                                ),
                              ),
                              FutureBuilder(
                                  future: FirebaseFirestore.instance
                                      .collection('SchoolListCollection')
                                      .doc(UserCredentialsController.schoolId)
                                      .collection('AllStudents')
                                      .doc(FirebaseAuth
                                          .instance.currentUser!.uid)
                                      .get(),
                                  builder: (context, userName) {
                                    if (userName.hasData) {
                                      return CircleAvatar(
                                        radius: 28,
                                        backgroundColor: adminePrimayColor,
                                        child: Center(
                                          child: IconButton(
                                              icon: const Icon(
                                                Icons.send,
                                                color: Colors.white,
                                              ),
                                              onPressed: () async {
                                                ///////////////////////////
                                                ///
                                                studentGroupChatMessageController
                                                    .sendMessage(
                                                        widget.groupID,
                                                        userName.data!.data()![
                                                            'studentName']);
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
      ),
    );
  }
}
