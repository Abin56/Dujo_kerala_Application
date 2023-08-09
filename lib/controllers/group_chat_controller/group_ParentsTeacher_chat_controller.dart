import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/home/events/event_display_school_level.dart';
import 'package:dujo_kerala_application/view/pages/chat/group_chats/group_chat.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../model/chat_model/chat_model.dart';
import '../../model/parent_model/parent_model.dart';
import '../../utils/utils.dart';
import '../../view/constant/sizes/constant.dart';
import '../userCredentials/user_credentials.dart';
import 'model/create_group_chat_model.dart';

class TeacherParentGroupChatController extends GetxController {
  final TextEditingController messageController = TextEditingController();
  RxBool isLoading = false.obs;
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
                      log(docid);
                      await FirebaseFirestore.instance
                          .collection("SchoolListCollection")
                          .doc(UserCredentialsController.schoolId)
                          .collection(UserCredentialsController.batchId!)
                          .doc(UserCredentialsController.batchId!)
                          .collection('classes')
                          .doc(UserCredentialsController.classId)
                          .collection('ChatGroups')
                          .doc('ChatGroups')
                          .collection('Parents')
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

  sendMessage(String groupID, String userName) async {
    final id = uuid.v1();
    final sendMessage = OnlineChatModel(
        message: messageController.text,
        messageindex: 1,
        chatid: FirebaseAuth.instance.currentUser!.uid,
        docid: id,
        sendTime: DateTime.now().toString(),
        username: '$userName T r');
    await FirebaseFirestore.instance
        .collection("SchoolListCollection")
        .doc(UserCredentialsController.schoolId)
        .collection(UserCredentialsController.batchId!)
        .doc(UserCredentialsController.batchId!)
        .collection('classes')
        .doc(UserCredentialsController.classId)
        .collection('ChatGroups')
        .doc('ChatGroups')
        .collection('Parents')
        .doc(groupID)
        .collection('chats')
        .doc(id)
        .set(sendMessage.toMap())
        .then((value) async {
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
        .collection('Parents')
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
          .collection('Parents')
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
        .collection('Parents')
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

  Future<void> addAllParents(
    String groupID,
  ) async {
    isLoading.value = true;
    final firabase = await FirebaseFirestore.instance
        .collection("SchoolListCollection")
        .doc(UserCredentialsController.schoolId)
        .collection(UserCredentialsController.batchId!)
        .doc(UserCredentialsController.batchId!)
        .collection('classes')
        .doc(UserCredentialsController.classId)
        .collection('ParentCollection')
        .get();

    for (var i = 0; i < firabase.docs.length; i++) {
      final parentDetails = ParentModel.fromMap(firabase.docs[i].data());

      await FirebaseFirestore.instance
          .collection("SchoolListCollection")
          .doc(UserCredentialsController.schoolId)
          .collection(UserCredentialsController.batchId!)
          .doc(UserCredentialsController.batchId!)
          .collection('classes')
          .doc(UserCredentialsController.classId)
          .collection('ChatGroups')
          .doc('ChatGroups')
          .collection('Parents')
          .doc(groupID)
          .collection('Participants')
          .doc(parentDetails.docid)
          .set(parentDetails.toMap());
    }
    userIndexBecomeZero(groupID, 'Parents',teacherParameter: 'parentName');
    isLoading.value = false;
  }

  customAddParentsInGroup(groupID) {
    userIndexBecomeZero(groupID, 'Parents',teacherParameter: 'parentName');
    RxMap<String, bool?> addParentList = <String, bool?>{}.obs;

    List<ParentModel> featchingParentlList = [];

    Get.bottomSheet(Container(
      height: 1000.h,
      color: Colors.white,
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GooglePoppinsEventsWidgets(
                  text: "Add parent in custom",
                  fontsize: 17,
                  fontWeight: FontWeight.w600,
                )
              ],
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          SizedBox(
            height: 900.h,
            child: FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection("SchoolListCollection")
                    .doc(UserCredentialsController.schoolId)
                    .collection(UserCredentialsController.batchId!)
                    .doc(UserCredentialsController.batchId!)
                    .collection('classes')
                    .doc(UserCredentialsController.classId)
                    .collection('ParentCollection')
                    .get(),
                builder: (context, parentsSnaps) {
                  if (parentsSnaps.hasData) {
                    return ListView.separated(
                        itemBuilder: (context, index) {
                          final parentDetails = ParentModel.fromMap(
                              parentsSnaps.data!.docs[index].data());
                          featchingParentlList.add(parentDetails);
                          return Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Row(
                              children: [
                                Obx(() => Container(
                                      color: addParentList[parentsSnaps.data!
                                                  .docs[index]['parentName']] ==
                                              null
                                          ? Colors.transparent
                                          : addParentList[parentsSnaps
                                                          .data!.docs[index]
                                                      ['parentName']] ==
                                                  true
                                              ? Colors.green.withOpacity(0.4)
                                              : Colors.red.withOpacity(0.4),
                                      height: 60.h,
                                      child: Row(
                                        children: [
                                          Text("${index + 1}"),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          SizedBox(
                                              width: 200.w,
                                              child: SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child:
                                                      GooglePoppinsEventsWidgets(
                                                    text: parentDetails
                                                        .parentName!,
                                                    fontsize: 11,
                                                    fontWeight: FontWeight.w600,
                                                  ))),
                                        ],
                                      ),
                                    )),
                                const Spacer(),
                                IconButton(
                                    onPressed: () async {
                                      addParentToGroup(parentDetails.docid!,
                                              groupID, parentDetails)
                                          .then((value) {
                                        showToast(msg: 'Added');
                                        addParentList[parentsSnaps.data!
                                            .docs[index]['parentName']] = true;
                                      });
                                    },
                                    icon: const Icon(Icons.add)),
                                const SizedBox(
                                  width: 20,
                                ),
                                IconButton(
                                    onPressed: () async {
                                      await removeParentToGroup(
                                              parentDetails.docid!,
                                              groupID,
                                              context)
                                          .then((value) {
                                        showToast(msg: "Removed");
                                        addParentList[
                                            parentsSnaps.data?.docs[index]
                                                ['parentName']] = false;
                                      });
                                    },
                                    icon: const Icon(Icons.remove))
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Divider();
                        },
                        itemCount: parentsSnaps.data!.docs.length);
                  } else {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }
                }),
          ),
        ],
      ),
    ));
  }

  Future<void> addParentToGroup(
      String parentDocID, String groupID, ParentModel parentDetails) async {
    await FirebaseFirestore.instance
        .collection("SchoolListCollection")
        .doc(UserCredentialsController.schoolId)
        .collection(UserCredentialsController.batchId!)
        .doc(UserCredentialsController.batchId)
        .collection('classes')
        .doc(UserCredentialsController.classId)
        .collection('ChatGroups')
        .doc('ChatGroups')
        .collection('Parents')
        .doc(groupID)
        .collection('Participants')
        .doc(parentDocID)
        .set(parentDetails.toMap());
  }

  Future<void> removeParentToGroup(
      String parentDocID, String groupID, BuildContext context) async {
    await FirebaseFirestore.instance
        .collection("SchoolListCollection")
        .doc(UserCredentialsController.schoolId)
        .collection(UserCredentialsController.batchId!)
        .doc(UserCredentialsController.batchId)
        .collection('classes')
        .doc(UserCredentialsController.classId)
        .collection('ChatGroups')
        .doc('ChatGroups')
        .collection('Parents')
        .doc(groupID)
        .collection('Participants')
        .doc(parentDocID)
        .delete()
        .then((value) => Navigator.pop(context));
  }

  addParticipants(String groupID) async {
    Get.bottomSheet(Container(
      color: Colors.white,
      height: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () async {
              await customAddParentsInGroup(groupID);
            },
            child: Container(
              decoration:
                  BoxDecoration(color: adminePrimayColor.withOpacity(0.3)),
              height: 60.h,
              width: 150.w,
              child: Center(
                child: GooglePoppinsEventsWidgets(
                    text: 'Custom', fontsize: 15, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Obx(
            () => isLoading.value
                ? circularProgressIndicatotWidget
                : GestureDetector(
                    onTap: () async {
                      await addAllParents(
                        groupID,
                      ).then((value) =>
                          showToast(msg: "All parents added in this groups"));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: adminePrimayColor.withOpacity(0.3)),
                      height: 60.h,
                      width: 150.w,
                      child: Center(
                        child: GooglePoppinsEventsWidgets(
                            text: 'Add All Parents',
                            fontsize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
          )
        ],
      ),
    ));
  }

  createGroupChatForWho(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Groups For ?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                          onTap: () {
                            createChatGroups(context, 'Parents');
                          },
                          child: Container(
                              height: 60,
                              width: 100,
                              color: Colors.green.withOpacity(0.4),
                              child: const Center(child: Text('Parents')))),
                      GestureDetector(
                          onTap: () {
                            createChatGroups(context, 'Parents');
                          },
                          child: Container(
                              height: 60,
                              width: 100,
                              color: Colors.green.withOpacity(0.4),
                              child: const Center(child: Text('Parents')))),
                    ],
                  ),
                )
              ],
            ),
          ),
          actions: <Widget>[
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
}

createChatGroups(BuildContext context, String chatValue) async {
  final formKey = GlobalKey<FormState>();
  TextEditingController groupNameController = TextEditingController();
  showDialog(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return Form(
        key: formKey,
        child: FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('SchoolListCollection')
                .doc(UserCredentialsController.schoolId)
                .collection(UserCredentialsController.batchId!)
                .doc(UserCredentialsController.batchId)
                .collection('classes')
                .doc(UserCredentialsController.classId)
                .get(),
            builder: (context, futureData) {
              return AlertDialog(
                title: const Text('Enter Group Name'),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Invalid';
                          }
                          return null;
                        },
                        controller: groupNameController,
                        decoration:
                            const InputDecoration(hintText: 'Enter Name'),
                      )
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('ok'),
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        if (futureData.data?.data()?['classTeacherdocid'] ==
                            FirebaseAuth.instance.currentUser!.uid) {
                          final docid = uuid.v1();
                          final groupInfoDetails = CreateGroupChatModel(
                              activate: true,
                              docid: docid,
                              admin: true,
                              groupName: groupNameController.text,
                              teacherId:
                                  FirebaseAuth.instance.currentUser!.uid);
                          await FirebaseFirestore.instance
                              .collection('SchoolListCollection')
                              .doc(UserCredentialsController.schoolId)
                              .collection(UserCredentialsController.batchId!)
                              .doc(UserCredentialsController.batchId)
                              .collection('classes')
                              .doc(UserCredentialsController.classId)
                              .collection('ChatGroups')
                              .doc('ChatGroups')
                              .set({'docid': "ChatGroups"}).then((value) async {
                            await FirebaseFirestore.instance
                                .collection('SchoolListCollection')
                                .doc(UserCredentialsController.schoolId)
                                .collection(UserCredentialsController.batchId!)
                                .doc(UserCredentialsController.batchId)
                                .collection('classes')
                                .doc(UserCredentialsController.classId)
                                .collection('ChatGroups')
                                .doc('ChatGroups')
                                .collection(chatValue)
                                .doc(docid)
                                .set(groupInfoDetails.toMap())
                                .then((value) async {
                              Navigator.pop(context);
                              Navigator.pop(context);

                              return showToast(
                                  msg: 'Group Created Successfully');
                            });
                          });
                        } else {
                          return showDialog(
                            context: context,
                            barrierDismissible: false, // user must tap button!
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Alert'),
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: const <Widget>[
                                      Text('Sorry you not a class teacher')
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('ok'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      }
                    },
                  ),
                  TextButton(
                    child: const Text('cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            }),
      );
    },
  );
}
