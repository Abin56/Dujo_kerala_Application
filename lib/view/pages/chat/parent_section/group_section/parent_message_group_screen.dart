import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'chats/parents_group-chats.dart';


class ParentsGroupMessagesScreen extends StatelessWidget {
  const ParentsGroupMessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('SchoolListCollection')
            .doc(UserCredentialsController.schoolId)
            .collection(UserCredentialsController.batchId!)
            .doc(UserCredentialsController.batchId)
            .collection('classes')
            .doc(UserCredentialsController.classId)
            .collection('ChatGroups')
            .doc('ChatGroups')
            .collection("Parents")
            .snapshots(),
        builder: (context, snapshots) {
          if (snapshots.hasData) {
            return ListView.separated(
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: 70,
                    child: ListTile(
                      onTap: () async {
                        final firebase = await FirebaseFirestore.instance
                            .collection('SchoolListCollection')
                            .doc(UserCredentialsController.schoolId)
                            .collection(UserCredentialsController.batchId!)
                            .doc(UserCredentialsController.batchId)
                            .collection('classes')
                            .doc(UserCredentialsController.classId)
                            .collection('ChatGroups')
                            .doc('ChatGroups')
                            .collection("Parents")
                            .doc(snapshots.data?.docs[index]['docid'])
                            .collection('Participants')
                            .doc(FirebaseAuth.instance.currentUser?.uid)
                            .get();
                        if (firebase.data()?['docid'] ==
                            FirebaseAuth.instance.currentUser?.uid) {
                          Get.to(() => ParentGroupChatsScreen(
                                groupID: snapshots.data?.docs[index]['docid'],
                                groupName: snapshots.data?.docs[index]
                                    ['groupName'],
                              ));
                        } else {
                          // ignore: use_build_context_synchronously
                          showDialog(
                            context: context,
                            barrierDismissible: false, // user must tap button!
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Message'),
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: const <Widget>[
                                      Text('You have no access')
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('ok'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      leading: const CircleAvatar(
                        radius: 30,
                      ),
                      title: Text(snapshots.data!.docs[index]['groupName'],
                          style: const TextStyle(color: Colors.black)),
                      contentPadding: const EdgeInsetsDirectional.all(1),
                      trailing: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('SchoolListCollection')
                              .doc(UserCredentialsController.schoolId)
                              .collection(UserCredentialsController.batchId!)
                              .doc(UserCredentialsController.batchId)
                              .collection('classes')
                              .doc(UserCredentialsController.classId)
                              .collection('ChatGroups')
                              .doc('ChatGroups')
                              .collection("Parents")
                              .doc(snapshots.data?.docs[index]['docid'])
                              .collection('Participants')
                              .doc(FirebaseAuth.instance.currentUser?.uid)
                              .snapshots(),
                          builder: (context, messagesnaps) {
                            if (messagesnaps.hasData) {
                              if (messagesnaps.data?.data()?['messageIndex'] ==
                                  null) {
                                return const Text('');
                              } else {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: messagesnaps.data!
                                              .data()!['messageIndex'] ==
                                          0
                                      ? const Text('')
                                      : CircleAvatar(
                                          radius: 14,
                                          backgroundColor: const Color.fromARGB(
                                              255, 118, 229, 121),
                                          child: Text(
                                            messagesnaps.data!
                                                .data()!['messageIndex']
                                                .toString(),
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                );
                              }
                            } else {
                              return const Text('');
                            }
                          }),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemCount: snapshots.data!.docs.length);
          } else {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
        });
  }
}
