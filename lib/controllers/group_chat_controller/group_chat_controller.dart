import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/utils.dart';
import '../../view/constant/sizes/constant.dart';
import '../userCredentials/user_credentials.dart';
import 'model/create_group_chat_model.dart';

class TeacherGroupChatController extends GetxController {
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
                            createChatGroups(context, 'Students');
                          },
                          child: Container(
                              height: 60,
                              width: 100,
                              color: Colors.green.withOpacity(0.4),
                              child: const Center(child: Text('Students')))),
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
