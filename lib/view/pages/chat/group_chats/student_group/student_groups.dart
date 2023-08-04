import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';

import 'chats/students_chats.dart';

class StudentsGroupsMessagesScreen extends StatelessWidget {
  const StudentsGroupsMessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('SchoolListCollection')
            .doc(UserCredentialsController.schoolId)
            .collection(UserCredentialsController.batchId!)
            .doc(UserCredentialsController.batchId!)
            .collection('classes')
            .doc(UserCredentialsController.classId!)
            .collection('ChatGroups')
            .doc('ChatGroups')
            .collection("Students")
            .snapshots(),
        builder: (context, snapshots) {
          if (snapshots.hasData) {
            return ListView(
              children: [
                SizedBox(
                  height: size.height * 0.74,
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        return SizedBox(
                          height: 70,
                          child: ListTile(
                            onTap: () {
                              Get.to(() => StudentsGroupChats(
                                    groupId: snapshots.data!.docs[index]
                                        ['docid'],
                                    groupName: snapshots.data!.docs[index]
                                        ['groupName'],
                                  ));
                            },
                            leading: const CircleAvatar(
                              radius: 30,
                            ),
                            title: Text(
                                snapshots.data!.docs[index]['groupName'],
                                style: const TextStyle(color: Colors.black)),
                            contentPadding: const EdgeInsetsDirectional.all(1),
                            subtitle: FutureBuilder(
                                future: FirebaseFirestore.instance
                                    .collection('SchoolListCollection')
                                    .doc(UserCredentialsController.schoolId)
                                    .collection(
                                        UserCredentialsController.batchId!)
                                    .doc(UserCredentialsController.batchId!)
                                    .collection('classes')
                                    .doc(UserCredentialsController.classId!)
                                    .get(),
                                builder: (context, futuredata) {
                                  if (futuredata.hasData) {
                                    return Row(
                                      children: [
                                        const Text(
                                          'class : ',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        Text(
                                          futuredata.data?.data()?['className'],
                                          style: const TextStyle(
                                              color: Colors.black),
                                        ),
                                      ],
                                    );
                                  } else {
                                    return const Center();
                                  }
                                }),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider();
                      },
                      itemCount: snapshots.data!.docs.length),
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
        });
  }
}
