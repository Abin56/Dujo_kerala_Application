import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'chats/teachers_chats.dart';

class TeachersMessagesScreen extends StatelessWidget {

  TeachersMessagesScreen({ super.key});

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
            .collection('Students')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("TeacherChats")
            .snapshots(),
        builder: (context, snapshots) {
          if (snapshots.hasData) {
            return ListView.separated(
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: 70,
                    child: ListTile(
                      onTap: () {
                        Get.to(() => TeachersChatsScreen(
                              
                              teacherName: snapshots.data!.docs[index]
                                  ['teacherName'],
                              teacherDocID: snapshots.data!.docs[index]
                                  ['docid'],
                            ));
                      },
                      leading: const CircleAvatar(
                        radius: 30,
                      ),
                      title: Text(snapshots.data!.docs[index]['teacherName'],
                          style: const TextStyle(color: Colors.black)),
                      contentPadding: const EdgeInsetsDirectional.all(1),
                        subtitle: const Text(
                        'Teacher',
                        style: TextStyle(color: Colors.black),
                      ),
                      trailing: snapshots.data!.docs[index]['messageindex'] == 0
                          ? const Text('')
                          : Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: CircleAvatar(
                                radius: 14,
                                backgroundColor:
                                    const Color.fromARGB(255, 118, 229, 121),
                                child: Text(
                                  snapshots.data!.docs[index]['messageindex']
                                      .toString(),
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
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
