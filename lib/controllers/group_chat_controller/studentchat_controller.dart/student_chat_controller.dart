import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/model/chat_model/chat_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../view/colors/colors.dart';
import '../../../view/constant/sizes/constant.dart';
import '../../../view/home/events/event_display_school_level.dart';
import '../../userCredentials/user_credentials.dart';

class StudentGroupChatMessageController extends GetxController {
  final TextEditingController messageController = TextEditingController();
  messageTitles(Size size, String chatId, String message, String docid,
      String time, BuildContext context, String groupID, String username) {
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
                      await FirebaseFirestore.instance
                          .collection("SchoolListCollection")
                          .doc(UserCredentialsController.schoolId)
                          .collection(UserCredentialsController.batchId!)
                          .doc(UserCredentialsController.batchId!)
                          .collection('classes')
                          .doc(UserCredentialsController.classId)
                          .collection('ChatGroups')
                          .doc('ChatGroups')
                          .collection('Students')
                          .doc(groupID)
                          .collection('chats')
                          .doc(docid)
                          .delete()
                          .then((value) => Navigator.pop(context));
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
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Container(
            width: size.width,
            alignment: Alignment.centerRight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: GooglePoppinsEventsWidgets(
                    text: 'You',
                    fontsize: 12,
                    color: adminePrimayColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
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
                            color: Color.fromARGB(255, 90, 90, 90),
                            fontSize: 10),
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
      return Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Container(
          width: size.width,
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child:
                      GooglePoppinsEventsWidgets(text: username, fontsize: 10)),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
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
        ),
      );
    }
  }

  sendMessage(String groupID, String userName, ) async {
    final id = uuid.v1();
    final sendMessage = OnlineChatModel(
        message: messageController.text,
        messageindex: 0,
        chatid: FirebaseAuth.instance.currentUser!.uid,
        docid: id,
        sendTime: DateTime.now().toString(),
        username: userName);
    await FirebaseFirestore.instance
        .collection("SchoolListCollection")
        .doc(UserCredentialsController.schoolId)
        .collection(UserCredentialsController.batchId!)
        .doc(UserCredentialsController.batchId!)
        .collection('classes')
        .doc(UserCredentialsController.classId)
        .collection('ChatGroups')
        .doc('ChatGroups')
        .collection('Students')
        .doc(groupID)
        .collection('chats')
        .doc(id)
        .set(sendMessage.toMap())
        .then((value)async {
      await sendMessageIndexToAllUsers(groupID);
      messageController.clear();
    });
  }

  Future<void> sendMessageIndexToAllUsers(String groupID) async {
    final firebase = await FirebaseFirestore.instance
        .collection("SchoolListCollection")
        .doc(UserCredentialsController.schoolId)
        .collection(UserCredentialsController.batchId!)
        .doc(UserCredentialsController.batchId!)
        .collection('classes')
        .doc(UserCredentialsController.classId)
        .collection('ChatGroups')
        .doc('ChatGroups')
        .collection('Students')
        .doc(groupID)
        .collection('Participants')
        .get();

    for (var i = 0; i < firebase.docs.length; i++) {
      await FirebaseFirestore.instance
          .collection("SchoolListCollection")
          .doc(UserCredentialsController.schoolId)
          .collection(UserCredentialsController.batchId!)
          .doc(UserCredentialsController.batchId!)
          .collection('classes')
          .doc(UserCredentialsController.classId)
          .collection('ChatGroups')
          .doc('ChatGroups')
          .collection('Students')
          .doc(groupID)
          .collection('Participants')
          .doc(firebase.docs[i].data()['docid'])
          .set({
        'messageIndex': await fetchCurrentIndexByUser(
                groupID, firebase.docs[i].data()['docid']) +
            1
      }, SetOptions(merge: true));
    }
  }

  Future<int> fetchCurrentIndexByUser(String groupID, String userDocid) async {
    final firebase = await FirebaseFirestore.instance
        .collection("SchoolListCollection")
        .doc(UserCredentialsController.schoolId)
        .collection(UserCredentialsController.batchId!)
        .doc(UserCredentialsController.batchId!)
        .collection('classes')
        .doc(UserCredentialsController.classId)
        .collection('ChatGroups')
        .doc('ChatGroups')
        .collection('Students')
        .doc(groupID)
        .collection('Participants')
        .doc(userDocid)
        .get();

    if (firebase.data()!['messageIndex'] == null) {
      return 0;
    } else {
      return firebase.data()!['messageIndex'];
    }
  }
}
