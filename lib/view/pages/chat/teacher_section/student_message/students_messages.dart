import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'chats/students_chats.dart';

class StudentsMessagesScreen extends StatelessWidget {

  StudentsMessagesScreen({ super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('SchoolListCollection')
            .doc(UserCredentialsController.schoolId)
            .collection('Teachers')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("StudentChats")
            .snapshots(),
        builder: (context, snapshots) {
          if (snapshots.hasData) {
            return ListView.separated(
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: 70,
                    child: ListTile(
                      onTap: () {
                        Get.to(() => StudentsChatsScreen(
                              
                              studentName: snapshots.data!.docs[index]
                                  ['studentname'],
                              studentDocID: snapshots.data!.docs[index]
                                  ['docid'],
                            ));
                      },
                      leading: const CircleAvatar(
                        radius: 30,
                      ),
                      title: Text(snapshots.data!.docs[index]['studentname'],
                          style: const TextStyle(color: Colors.black)),
                      contentPadding: const EdgeInsetsDirectional.all(1),
                      subtitle: const Text(
                        'class',
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
