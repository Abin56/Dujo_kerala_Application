import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../controllers/char_controller/teacher_controller/teacher_controller.dart';


class StudentsChatsScreen extends StatefulWidget {
  int studentMessageCounter;
  String studentDocID;
  String studentName;

  StudentsChatsScreen(
      {required this.studentMessageCounter,
      required this.studentDocID,
      required this.studentName,
      super.key});

  @override
  State<StudentsChatsScreen> createState() => _StudentsChatsScreenState();
}

class _StudentsChatsScreenState extends State<StudentsChatsScreen> {
  final teacherChatController = Get.put(TeacherChatController());

  int currentStudentMessageIndex = 0;
  @override
  void initState() {
    getCurrentStudentMessageIndex().then((value) => resetUserMessageIndex());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    log('studentName${widget.studentName}');
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 242, 224),
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Row(
          children: [
            const CircleAvatar(),
            kWidth10,
            Text(widget.studentName),
          ],
        ),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                onTap: () async {
                  log("PopUp Blocked button");
                  await FirebaseFirestore.instance
                      .collection('SchoolListCollection')
                      .doc(UserCredentialsController.schoolId)
                      .collection("Teachers")
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection('StudentChats')
                      .doc(widget.studentDocID)
                      .set({'block': true}, SetOptions(merge: true));
                },
                child: const Center(child: Text('Block')),
              ),
            ],
          )
        ],
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
                      .collection("Teachers")
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection('StudentChats')
                      .doc(widget.studentDocID)
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
                          return teacherChatController.messageTitles(
                              widget.studentDocID,
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
                    .collection("Teachers")
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection('StudentChats')
                    .doc(widget.studentDocID)
                    .snapshots(),
                builder: (context, checkingblock) {
                  if (checkingblock.hasData) {
                    if (checkingblock.data!.data()!['block'] == true) {
                      return GestureDetector(
                        onTap: () async {
                          await teacherChatController.unBlockuser(
                              widget.studentDocID, context);
                        },
                        child: SizedBox(
                          height: size.height / 15,
                          width: size.width,
                          child: Column(
                            children: const [
                              Text('You Blocked this user'),
                              SizedBox(
                                height: 10,
                              ),
                              Text('Tap to unblock '),
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
                                      teacherChatController.messageController,
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
                                        teacherChatController
                                            .sentMessage(widget.studentDocID);
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
        .doc(widget.studentDocID)
        .get();

    currentStudentMessageIndex = vari.data()!['messageindex'];
  }

  resetUserMessageIndex() async {
    final messageIndexNotify =
        widget.studentMessageCounter - currentStudentMessageIndex;
    await FirebaseFirestore.instance
        .collection('SchoolListCollection')
        .doc(UserCredentialsController.schoolId)
        .collection('Teachers')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('StudentChatCounter')
        .doc('F0Ikn1UouYIkqmRFKIpg')
        .update({'chatIndex': messageIndexNotify}).then((value) async {
      await FirebaseFirestore.instance
          .collection('SchoolListCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('Teachers')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('StudentChats')
          .doc(widget.studentDocID)
          .update({'messageindex': 0});
    });
  }
}
