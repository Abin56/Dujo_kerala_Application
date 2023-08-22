import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../controllers/chat_controller/parent_controller/parent_controller.dart';
import '../../../../../constant/sizes/constant.dart';

class ParentTeachersChatsScreen extends StatefulWidget {
  String teacherDocID;
  String teacherName;

  ParentTeachersChatsScreen(
      {required this.teacherDocID, required this.teacherName, super.key});

  @override
  State<ParentTeachersChatsScreen> createState() =>
      Parent_TeachersChatsScreenState();
}

class Parent_TeachersChatsScreenState extends State<ParentTeachersChatsScreen> {
  final parentChatController = Get.put(ParentChatController());

  int currentStudentMessageIndex = 0;
  int currentStudentMessageIndex2 = 0;
  int teacherIndex = 0;

  @override
  void initState() {
    fectingTeacherChatStatus();
    connectingParentToteacher();
    connectingCurrentParentToteacher();
    getParentTeacherChatIndex();
    getCurrentTeacherMessageIndex().then((value) => resetUserMessageIndex());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log("getParentTeacherChatIndex().toString()$teacherIndex");
    final Size size = MediaQuery.of(context).size;

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
                      .collection('ParentCollection')
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
                          return parentChatController.messageTitles(
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
                    .collection('ParentChats')
                    .doc(FirebaseAuth.instance.currentUser?.uid)
                    .snapshots(),
                builder: (context, checkingblock) {
                  if (checkingblock.hasData) {
                    if (checkingblock.data?.data()?['block'] == true) {
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
                                      parentChatController.messageController,
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
                                        log('teacherName >>>>  ${widget.teacherDocID}');
                                        ///////////////////////////
                                        ///
                                        parentChatController.sentMessages(
                                          widget.teacherDocID,
                                          await getCurrentTeacherMessageIndex(),
                                          await getTeacherChatCounterIndex(),
                                        );
                                        /////////////////////////
                                      }),
                                ),
                              ),
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

  Future<int> getParentTeacherChatIndex() async {
    var vari = await FirebaseFirestore.instance
        .collection('SchoolListCollection')
        .doc(UserCredentialsController.schoolId)
        .collection(UserCredentialsController.batchId!)
        .doc(UserCredentialsController.batchId!)
        .collection('classes')
        .doc(UserCredentialsController.classId)
        .collection('ParentCollection')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('TeacherChats')
        .doc(widget.teacherDocID)
        .get();
    teacherIndex = vari.data()?['messageindex'] ?? 0;
    // log("message>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>${vari.data()?['messageindex']}");
    if (teacherIndex < 0) {
      return 0;
    } else {
      return teacherIndex;
    }
  }

  Future<int> getCurrentTeacherMessageIndex() async {
    var vari = await FirebaseFirestore.instance
        .collection('SchoolListCollection')
        .doc(UserCredentialsController.schoolId)
        .collection('Teachers')
        .doc(widget.teacherDocID)
        .collection('ParentChats')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    currentStudentMessageIndex = vari.data()?['messageindex'] ?? 0;

    log("currentStudentMessageIndex.toString()${currentStudentMessageIndex.toString()}");
    if (currentStudentMessageIndex == 0) {
      return 0;
    } else {
      return currentStudentMessageIndex;
    }
  }

  resetUserMessageIndex() async {
    int zero = 0;
    final int messageIndexNotify = MessageCounter.teacherMessageCounter -
        await getParentTeacherChatIndex();
    MessageCounter.teacherMessageCounter = messageIndexNotify;

    log("StudentCounter${MessageCounter.teacherMessageCounter}");
    log("StudentIndex $currentStudentMessageIndex");
    log("messageIndexNotify $messageIndexNotify");
    await FirebaseFirestore.instance
        .collection('SchoolListCollection')
        .doc(UserCredentialsController.schoolId)
        .collection(UserCredentialsController.batchId!)
        .doc(UserCredentialsController.batchId!)
        .collection('classes')
        .doc(UserCredentialsController.classId)
        .collection('ParentCollection')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('TeachersChatCounter')
        .doc('c3cDX5ymHfITQ3AXcwSp')
        .update({
      'chatIndex': messageIndexNotify == 0 ? zero : messageIndexNotify
    }).then((value) async {
      await FirebaseFirestore.instance
          .collection('SchoolListCollection')
          .doc(UserCredentialsController.schoolId)
          .collection(UserCredentialsController.batchId!)
          .doc(UserCredentialsController.batchId!)
          .collection('classes')
          .doc(UserCredentialsController.classId)
          .collection('ParentCollection')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('TeacherChats')
          .doc(widget.teacherDocID)
          .update({'messageindex': 0});
    });
  }

  Future<int> getTeacherChatCounterIndex() async {
    var vari = await FirebaseFirestore.instance
        .collection('SchoolListCollection')
        .doc(UserCredentialsController.schoolId)
        .collection(UserCredentialsController.batchId!)
        .doc(UserCredentialsController.batchId!)
        .collection('classes')
        .doc(UserCredentialsController.classId)
        .collection('ParentCollection')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('TeachersChatCounter')
        .doc('c3cDX5ymHfITQ3AXcwSp')
        .get();
    return currentStudentMessageIndex2 = vari.data()?['chatIndex'] ?? 0;
  }

  Future connectingCurrentParentToteacher() async {
    final checkuser = await FirebaseFirestore.instance
        .collection('SchoolListCollection')
        .doc(UserCredentialsController.schoolId)
        .collection('Teachers')
        .doc(widget.teacherDocID)
        .collection('ParentChats')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();
    if (checkuser.data() == null) {
      await FirebaseFirestore.instance
          .collection('SchoolListCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('Teachers')
          .doc(widget.teacherDocID)
          .collection('ParentChats')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .set({
        'block': false,
        'docid': FirebaseAuth.instance.currentUser?.uid,
        'classID': UserCredentialsController.classId,
        'messageindex': 0,
        'parentname': UserCredentialsController.parentModel?.parentName,
      });
    }
  }

  Future connectingParentToteacher() async {
    final checkuser = await FirebaseFirestore.instance
        .collection('SchoolListCollection')
        .doc(UserCredentialsController.schoolId)
        .collection('Teachers')
        .doc(widget.teacherDocID)
        .collection('ParentChats')
        .get();
    if (checkuser.docs.isEmpty) {
      await FirebaseFirestore.instance
          .collection('SchoolListCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('Teachers')
          .doc(widget.teacherDocID)
          .collection('ParentChats')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .set({
        'block': false,
        'docid': FirebaseAuth.instance.currentUser?.uid,
        'classID': UserCredentialsController.classId,
        'messageindex': 0,
        'parentname': UserCredentialsController.parentModel?.parentName,
      }).then((value) async {
        await FirebaseFirestore.instance
            .collection('SchoolListCollection')
            .doc(UserCredentialsController.schoolId)
            .collection(UserCredentialsController.batchId!)
            .doc(UserCredentialsController.batchId!)
            .collection('classes')
            .doc(UserCredentialsController.classId)
            .collection('ParentCollection')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('TeacherChats')
            .doc(widget.teacherDocID)
            .set({
          'block': false,
          'docid': widget.teacherDocID,
          'messageindex': 0,
          'teacherName': widget.teacherName,
        });
      });
    }
  }

  Future fectingTeacherChatStatus() async {
    final firebasecollection = await FirebaseFirestore.instance
        .collection('SchoolListCollection')
        .doc(UserCredentialsController.schoolId)
        .collection('Teachers')
        .doc(widget.teacherDocID)
        .collection('ParentChatCounter')
        .get();

    if (firebasecollection.docs.isEmpty) {
      log('firebasecollection.docs.isEmpty');
      await FirebaseFirestore.instance
          .collection('SchoolListCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('Teachers')
          .doc(widget.teacherDocID)
          .collection('ParentChatCounter')
          .doc('F0Ikn1UouYIkqmRFKIpg')
          .set({'chatIndex': 0, 'docid': "F0Ikn1UouYIkqmRFKIpg"});
    } else {
      log('NMNnnnnnnnnnnnnnnnnnnnnnnn');
      return;
    }
  }
  // resetUserMessageIndex() async {
  //   final messageIndexNotify =
  //       widget.teacherMessageCounter - currentStudentMessageIndex;
  //   await FirebaseFirestore.instance
  //       .collection('SchoolListCollection')
  //       .doc(UserCredentialsController.schoolId)
  //       .collection('Teachers')
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .collection('ParentChatCounter')
  //       .doc('F0Ikn1UouYIkqmRFKIpg')
  //       .update({'chatIndex': messageIndexNotify}).then((value) async {
  //     await FirebaseFirestore.instance
  //         .collection('SchoolListCollection')
  //         .doc(UserCredentialsController.schoolId)
  //         .collection('Teachers')
  //         .doc(FirebaseAuth.instance.currentUser!.uid)
  //         .collection('ParentChats')
  //         .doc(widget.teacherDocID)
  //         .update({'messageindex': 0});
  //   });
  // }
}
