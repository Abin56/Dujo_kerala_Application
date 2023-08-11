import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../model/chat_model/chat_model.dart';
import '../../../model/chat_model/send_chatModel.dart';
import '../../../model/parent_model/parent_model.dart';
import '../../../model/student_model/data_base_model.dart';
import '../../../utils/utils.dart';
import '../../../view/constant/sizes/constant.dart';
import '../../userCredentials/user_credentials.dart';

class TeacherParentChatController extends GetxController {
  int studentIndex = 0;
  final TextEditingController messageController = TextEditingController();

  messageTitles(String parentDocID, Size size, String chatId, String message,
      String docid, String time, BuildContext context) {
    if (FirebaseAuth.instance.currentUser!.uid == chatId) {
      //to get which <<<< DD//Month//Year   >>>>>
      DateTime parseDatee = DateTime.parse(time.toString());
      final DateFormat dayformatterr = DateFormat('dd MMMM yyy');
      String dayformattedd = dayformatterr.format(parseDatee);
      ///////////////////////
      DateTime parseTime = DateTime.parse(time.toString());
      final DateFormat timeformatterr = DateFormat('h:mm a');
      String timeformattedd = timeformatterr.format(parseTime);
////
      return GestureDetector(
        onLongPress: () async {
          return showDialog(
            context: context,
            barrierDismissible: false, // user must tap button!
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Alert'),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: const <Widget>[
                      Text('Do you want Delete this message ?')
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Ok'),
                    onPressed: () async {
                      log(docid);
                      await FirebaseFirestore.instance
                          .collection('SchoolListCollection')
                          .doc(UserCredentialsController.schoolId)
                          .collection("Teachers")
                          .doc(UserCredentialsController.teacherModel!.docid)
                          .collection('ParentChats')
                          .doc(parentDocID)
                          .collection('messages')
                          .doc(docid)
                          .delete()
                          .then((value) async {
                        await FirebaseFirestore.instance
                            .collection('SchoolListCollection')
                            .doc(UserCredentialsController.schoolId)
                            .collection(UserCredentialsController.batchId!)
                            .doc(UserCredentialsController.batchId)
                            .collection('classes')
                            .doc(UserCredentialsController.classId)
                            .collection('ParentCollection')
                            .doc(parentDocID)
                            .collection('TeacherChats')
                            .doc(UserCredentialsController.teacherModel!.docid)
                            .collection('messages')
                            .doc(docid)
                            .delete()
                            .then((value) => Get.back());
                      });
                    },
                  ),
                  TextButton(
                    child: const Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
        child: Container(
          width: size.width,
          alignment: Alignment.centerRight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color.fromARGB(255, 194, 243, 189),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '$message              ',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                    Text(
                      timeformattedd,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 90, 90, 90), fontSize: 10),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 05,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Text(
                  dayformattedd,
                  style: const TextStyle(
                      color: Color.fromARGB(255, 90, 90, 90), fontSize: 10),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      //to get which <<<< DD//Month//Year   >>>>>
      DateTime parseDatee = DateTime.parse(time.toString());
      final DateFormat dayformatterr = DateFormat('dd MMMM yyy');
      String dayformattedd = dayformatterr.format(parseDatee);
      ///////////////////////
      DateTime parseTime = DateTime.parse(time.toString());
      final DateFormat timeformatterr = DateFormat('h:mm a');
      String timeformattedd = timeformatterr.format(parseTime);
////
      return Container(
        width: size.width,
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '$message              ',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  Text(
                    timeformattedd,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 90, 90, 90), fontSize: 10),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 05,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Text(
                dayformattedd,
                style: const TextStyle(
                    color: Color.fromARGB(255, 90, 90, 90), fontSize: 10),
              ),
            ),
          ],
        ),
      );
    }
  }

  sentMessage(String parentDocID) async {
    var countPlusone = await FirebaseFirestore.instance
        .collection('SchoolListCollection')
        .doc(UserCredentialsController.schoolId)
        .collection(UserCredentialsController.batchId!)
        .doc(UserCredentialsController.batchId)
        .collection('classes')
        .doc(UserCredentialsController.classId)
        .collection('ParentCollection')
        .doc(parentDocID)
        .collection('TeachersChatCounter')
        .doc('c3cDX5ymHfITQ3AXcwSp')
        .get();
            int sentStudentChatIndex = countPlusone.data()?['chatIndex'] + 1;

    final id = uuid.v1();
    final userDetails = SendUserStatusModel(
        block: false,
        docid: FirebaseAuth.instance.currentUser!.uid,
        messageindex: await fectchingStudentCurrentMessageIndex(parentDocID),
        teacherName: UserCredentialsController.teacherModel!.teacherName!);
    final sendMessage = OnlineChatModel(
      classID: UserCredentialsController.classId,
      message: messageController.text,
      messageindex: 1,
      chatid: FirebaseAuth.instance.currentUser!.uid,
      docid: id,
      sendTime: DateTime.now().toString(),
    );
    await FirebaseFirestore.instance
        .collection('SchoolListCollection')
        .doc(UserCredentialsController.schoolId)
        .collection("Teachers")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('ParentChats')
        .doc(parentDocID)
        .collection('messages')
        .doc(id)
        .set(sendMessage.toMap())
        .then((value) async {
      await FirebaseFirestore.instance
          .collection('SchoolListCollection')
          .doc(UserCredentialsController.schoolId)
          .collection(UserCredentialsController.batchId!)
          .doc(UserCredentialsController.batchId)
          .collection('classes')
          .doc(UserCredentialsController.classId)
          .collection('ParentCollection')
          .doc(parentDocID)
          .collection('TeacherChats')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(userDetails.toMap(), SetOptions(merge: true))
          .then((value) async {
        FirebaseFirestore.instance
            .collection('SchoolListCollection')
            .doc(UserCredentialsController.schoolId)
            .collection(UserCredentialsController.batchId!)
            .doc(UserCredentialsController.batchId)
            .collection('classes')
            .doc(UserCredentialsController.classId)
            .collection('ParentCollection')
            .doc(parentDocID)
            .collection('TeacherChats')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('messages')
            .doc(id)
            .set(sendMessage.toMap())
            .then((value) async {
          await FirebaseFirestore.instance
              .collection('SchoolListCollection')
              .doc(UserCredentialsController.schoolId)
              .collection(UserCredentialsController.batchId!)
              .doc(UserCredentialsController.batchId)
              .collection('classes')
              .doc(UserCredentialsController.classId)
              .collection('ParentCollection')
              .doc(parentDocID)
              .collection('TeachersChatCounter')
              .doc('c3cDX5ymHfITQ3AXcwSp')
              .update({
            'chatIndex': sentStudentChatIndex
          }).then((value) => messageController.clear());
        });
      });
    });
  }

  unBlockuser(String parentDocID, BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Alert'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[Text('Do you want to unblock this user ?')],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection('SchoolListCollection')
                    .doc(UserCredentialsController.schoolId)
                    .collection("Teachers")
                    .doc(UserCredentialsController.teacherModel!.docid)
                    .collection('ParentChats')
                    .doc(parentDocID)
                    .set({'block': false}, SetOptions(merge: true)).then(
                        (value) => Navigator.of(context).pop());
              },
            ),
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<int> fectchingStudentCurrentMessageIndex(String parentDocID) async {
    final studentData = await FirebaseFirestore.instance
        .collection('SchoolListCollection')
        .doc(UserCredentialsController.schoolId)
        .collection(UserCredentialsController.batchId!)
        .doc(UserCredentialsController.batchId)
        .collection('classes')
        .doc(UserCredentialsController.classId)
        .collection('ParentCollection')
        .doc(parentDocID)
        .collection('TeacherChats')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    if (studentData.data()?['messageindex'] == null) {
      return 1;
    } else {
      int currentIndex = studentData.data()!['messageindex'];
      studentIndex = currentIndex + 1;
      return studentIndex;
    }
  }

  List<AddStudentModel> searchParentCollection = [];
  Future<void> fetchStudent() async {
    searchParentCollection.clear();
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance
              .collection("SchoolListCollection")
              .doc(UserCredentialsController.schoolId)
              .collection(UserCredentialsController.batchId!)
              .doc(UserCredentialsController.batchId!)
              .collection("classes")
              .doc(UserCredentialsController.classId!)
              .collection('ParentCollection')
              .get();
      searchParentCollection =
          snapshot.docs.map((e) => AddStudentModel.fromMap(e.data())).toList();
    } catch (e) {
      showToast(msg: "Student Data Error");
    }
  }


  List<ParentModel> searchParents = [];
  Future<void> fetchParents() async {
    searchParents.clear();
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance
              .collection("SchoolListCollection")
              .doc(UserCredentialsController.schoolId)
              .collection(UserCredentialsController.batchId!)
              .doc(UserCredentialsController.batchId!)
              .collection("classes")
              .doc(UserCredentialsController.classId!)
              .collection('ParentCollection')
              .get();
      searchParents =
          snapshot.docs.map((e) => ParentModel.fromMap(e.data())).toList();
    } catch (e) {
      showToast(msg: "Student Data Error");
    }
  }
  @override
  void onInit() async {
    await fetchStudent();
    await fetchParents();
    super.onInit();
  }
}
