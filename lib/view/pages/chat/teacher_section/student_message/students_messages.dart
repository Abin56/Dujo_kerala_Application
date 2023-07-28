import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:dujo_kerala_application/view/widgets/fonts/google_poppins.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../search_students/search_students.dart';
import 'chats/students_chats.dart';

class StudentsMessagesScreen extends StatelessWidget {
  const StudentsMessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
                Future<void> _showSearch() async {
    await showSearch(context: context, delegate: SearchStudentsForChat());
  }
    final size = MediaQuery.of(context).size;
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
                            title: Text(
                                snapshots.data!.docs[index]['studentname'],
                                style: const TextStyle(color: Colors.black)),
                            contentPadding: const EdgeInsetsDirectional.all(1),
                            subtitle: const Text(
                              'class',
                              style: TextStyle(color: Colors.black),
                            ),
                            trailing: snapshots.data!.docs[index]
                                        ['messageindex'] ==
                                    0
                                ? const Text('')
                                : Padding(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: CircleAvatar(
                                      radius: 14,
                                      backgroundColor: const Color.fromARGB(
                                          255, 118, 229, 121),
                                      child: Text(
                                        snapshots
                                            .data!.docs[index]['messageindex']
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
                      itemCount: snapshots.data!.docs.length),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: GestureDetector(
                        onTap: () {
                          _showSearch();
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius:BorderRadius.all(Radius.circular(30)),
                              color: Color.fromARGB(255, 232, 224, 224)),
                          height: 50,
                          width: 200,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children:  [
                                const Icon(Icons.search),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: GooglePoppinsWidgets(text: 'Search Students', fontsize: 15,),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
        });
  }
}
