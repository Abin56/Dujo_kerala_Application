import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:dujo_kerala_application/view/widgets/fonts/google_poppins.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../search_parents/search_parents.dart';
import 'chats/parent_chats.dart';
// import 'chats/students_chats.dart';

class ParentMessagesScreen extends StatelessWidget {
  const ParentMessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> _showSearch() async {
      await showSearch(context: context, delegate: SearchParentsForChat());
    }

    final size = MediaQuery.of(context).size;
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('SchoolListCollection')
            .doc(UserCredentialsController.schoolId)
            .collection('Teachers')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("ParentChats")
            .snapshots(),
        builder: (context, snapshots) {
          if (snapshots.hasData) {
            return ListView(
              children: [
                SizedBox(
                  height: size.height * 0.72,
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        return SizedBox(
                          height: 70.h,
                          child: ListTile(
                            onTap: () {
                              Get.to(() => ParentsChatsScreen(
                                    parentDocID: snapshots.data!.docs[index]
                                        ['docid'],
                                    parentName: snapshots.data!.docs[index]
                                        ['parentname'],
                                  ));
                            },
                            leading: const CircleAvatar(
                              radius: 30,
                            ),
                            title: FutureBuilder(
                                future: FirebaseFirestore.instance
                                    .collection('SchoolListCollection')
                                    .doc(UserCredentialsController.schoolId)
                                    .collection(
                                        UserCredentialsController.batchId!)
                                    .doc(UserCredentialsController.batchId)
                                    .collection('classes')
                                    .doc(snapshots.data?.docs[index]['classID'])
                                    .collection('ParentCollection')
                                    .doc(snapshots.data?.docs[index]['docid'])
                                    .get(),
                                builder: (context, parentsnaps) {
                                  log("school Id ${UserCredentialsController.schoolId}");
                                  log("school Id ${UserCredentialsController.batchId}");
                                  log("school Id ${snapshots.data?.docs[index]['classID']}");
                                  log("school Id ${snapshots.data?.docs[index]['docid']}");

                                  log('Getting parent name --->>>  ${parentsnaps.data?.get('parentName')}');
                                  // log('Getting class ID--->>>  ${snapshots.data?.docs[index]['classID']}');
                                  if (parentsnaps.hasData) {
                                    return Text(
                                        parentsnaps.data?.data()?['parentName'],
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 17.sp));
                                  } else {
                                    return const Center(
                                      child: Text(''),
                                    );
                                  }
                                }),
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
                                        Text(
                                          'class : ',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15.sp),
                                        ),
                                        Text(
                                          futuredata.data?.data()?['className'],
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15.sp),
                                        ),
                                      ],
                                    );
                                  } else {
                                    return const Center();
                                  }
                                }),
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
                      padding: EdgeInsets.only(right: 8.sp),
                      child: GestureDetector(
                        onTap: () {
                          _showSearch();
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                              color: Color.fromARGB(255, 232, 224, 224)),
                          height: 50.h,
                          width: 200.w,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Icon(Icons.search),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: GooglePoppinsWidgets(
                                    text: 'Search Parents',
                                    fontsize: 15.sp,
                                  ),
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



// FutureBuilder(
//               future: FirebaseFirestore.instance
//                   .collection('SchoolListCollection')
//                   .doc(UserCredentialsController.schoolId)
//                   .collection(UserCredentialsController.batchId!)
//                   .doc(UserCredentialsController.batchId)
//                   .collection('classes')
//                   .doc(UserCredentialsController.classId)
//                   .collection('ParentCollection')
//                   .doc(napshots.data!.docs[index]['docid'])
//                   .get()