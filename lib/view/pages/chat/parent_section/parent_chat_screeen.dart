import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/pages/chat/parent_section/teacher_messages/teachers_messages.dart';
import 'package:dujo_kerala_application/view/pages/chat/student_section/search/search_teachers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../controllers/userCredentials/user_credentials.dart';
import '../../../constant/sizes/constant.dart';
import '../../../widgets/fonts/google_monstre.dart';

class ParentChatScreen extends StatelessWidget {
  const ParentChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> _showSearch() async {
      await showSearch(context: context, delegate: SearchTeachers());
    }

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: adminePrimayColor,
          title: const Text('Dujo Chat'),
          bottom: TabBar(
            tabs: [
              Tab(
                icon: ListView(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 0),
                      child: Icon(Icons.group),
                    ),
                    //////////////////////////////////////////////////////////////////////////////////////////////////
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Teachers"),
                        StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('SchoolListCollection')
                                .doc(UserCredentialsController.schoolId)
                                .collection(UserCredentialsController.batchId!)
                                .doc(UserCredentialsController.batchId)
                                .collection('classes')
                                .doc(UserCredentialsController.classId)
                                .collection('ParentCollection')
                                .doc(FirebaseAuth.instance.currentUser?.uid)
                                .collection("TeachersChatCounter")
                                .doc("c3cDX5ymHfITQ3AXcwSp")
                                .snapshots(),
                            builder: (context, messageIndex) {
                              if (messageIndex.hasData) {
                                if (messageIndex.data!.data() == null) {
                                  return const Text('');
                                } else {
                                  MessageCounter.teacherMessageCounter =
                                      messageIndex.data?.data()?['chatIndex'];
                                  return Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: CircleAvatar(
                                      radius: 10,
                                      backgroundColor: Colors.white,
                                      child: Center(
                                        child: Text(
                                          messageIndex.data!
                                              .data()!['chatIndex']
                                              .toString(),
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              } else {
                                return const Center(
                                  child: CircularProgressIndicator.adaptive(),
                                );
                              }
                            }),
                      ],
                    )
                  ],
                ),
              ),
              // const Tab(icon: Icon(Icons.groups_2), text: 'Parents'),
              const Tab(
                  icon: Icon(
                    Icons.class_,
                  ),
                  text: 'Group'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            const ParentTeachersMessagesScreen(),
            // const Icon(Icons.directions_transit, size: 350),
             Center(
                child: GoogleMonstserratWidgets(
                    text: 'Under maintenance', fontsize: 30,fontWeight: FontWeight.bold,)),
          ],
        ),
        floatingActionButton: CircleAvatar(
          backgroundColor: adminePrimayColor,
          radius: 25,
          child: Center(
            child: IconButton(
                onPressed: () async {
                  await _showSearch();
                },
                icon: const Icon(
                  Icons.search_rounded,
                  color: Colors.white,
                )),
          ),
        ),
      ),
    );
  }
}