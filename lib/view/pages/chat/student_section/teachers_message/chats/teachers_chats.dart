import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../controllers/char_controller/student_controller/student_controller.dart';

class TeachersChatsScreen extends StatefulWidget {
  int teacherMessageCounter;
  String teacherDocID;
  String teacherName;

  TeachersChatsScreen(
      {required this.teacherMessageCounter,
      required this.teacherDocID,
      required this.teacherName,
      super.key});

  @override
  State<TeachersChatsScreen> createState() => _TeachersChatsScreenState();
}

class _TeachersChatsScreenState extends State<TeachersChatsScreen> {
  final studentChatController = Get.put(StudentChatController());

  int currentStudentMessageIndex = 0;
  @override
  void initState() {
    // getCurrentStudentMessageIndex().then((value) => resetUserMessageIndex());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    log('teacherName${widget.teacherName}');
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 242, 224),
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Row(
          children: [
            const CircleAvatar(),
            kWidth10,
            Text(widget.teacherName),
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
                      .collection('Students')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection('TeacherChats')
                      .doc(widget.teacherDocID)
                      .collection('messages')
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
                          return studentChatController.messageTitles(
                              widget.teacherDocID,
                              size,
                              snaps.data!.docs[index]['chatid'],
                              snaps.data!.docs[index]['message'],
                              snaps.data!.docs[index]['docid'],
                              snaps.data!.docs[index]['sendTime'],
                              context);
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
                    .collection('Teachers')
                    .doc(widget.teacherDocID)
                    .collection('StudentChats')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .snapshots(),
                builder: (context, checkingblock) {
                  if (checkingblock.hasData) {
                    if (checkingblock.data!.data()!['block'] == true) {
                      return GestureDetector(
                        onTap: () async {},
                        child: SizedBox(
                          height: size.height / 15,
                          width: size.width,
                          child: Column(
                            children: const [
                              Text('You are Blocked '),
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
                                        ///////////////////////////
                                        studentChatController
                                            .sentMessage(widget.teacherDocID);
                                        /////////////////////////
                                      }),
                                ),
                              ),
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
                }),
          ],
        ),
      ),
    );
  }

  Future<void> getCurrentStudentMessageIndex() async {
    var vari = await FirebaseFirestore.instance
        .collection('SchoolListCollection')
        .doc(UserCredentialsController.schoolId)
        .collection('Teachers')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('StudentChats')
        .doc(widget.teacherDocID)
        .get();

    currentStudentMessageIndex = vari.data()!['messageindex'];
  }

  // resetUserMessageIndex() async {
  //   final messageIndexNotify =
  //       widget.teacherMessageCounter - currentStudentMessageIndex;
  //   await FirebaseFirestore.instance
  //       .collection('SchoolListCollection')
  //       .doc(UserCredentialsController.schoolId)
  //       .collection('Teachers')
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .collection('StudentChatCounter')
  //       .doc('F0Ikn1UouYIkqmRFKIpg')
  //       .update({'chatIndex': messageIndexNotify}).then((value) async {
  //     await FirebaseFirestore.instance
  //         .collection('SchoolListCollection')
  //         .doc(UserCredentialsController.schoolId)
  //         .collection('Teachers')
  //         .doc(FirebaseAuth.instance.currentUser!.uid)
  //         .collection('StudentChats')
  //         .doc(widget.teacherDocID)
  //         .update({'messageindex': 0});
  //   });
  // }
}
