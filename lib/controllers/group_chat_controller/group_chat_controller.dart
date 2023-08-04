import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/home/events/event_display_school_level.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../model/student_model/data_base_model.dart';
import '../../utils/utils.dart';
import '../../view/constant/sizes/constant.dart';
import '../userCredentials/user_credentials.dart';
import 'model/create_group_chat_model.dart';

class TeacherGroupChatController extends GetxController {
  RxBool isLoading = false.obs;

  Future<void> addAllStudents(
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
        .collection('Students')
        .get();

    for (var i = 0; i < firabase.docs.length; i++) {
      final studentDetails = AddStudentModel.fromMap(firabase.docs[i].data());

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
          .doc(studentDetails.docid)
          .set(studentDetails.toMap());
    }
    isLoading.value = false;
  }

  customAddStudentInGroup(groupID) {
    RxMap<String, bool?> addStudentList = <String, bool?>{}.obs;

    List<AddStudentModel> featchingStudentlList = [];

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
                  text: "Add students in custom",
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
                    .collection('Students')
                    .get(),
                builder: (context, studentsSnaps) {
                  if (studentsSnaps.hasData) {
                    return ListView.separated(
                        itemBuilder: (context, index) {
                          final studentDetails = AddStudentModel.fromMap(
                              studentsSnaps.data!.docs[index].data());
                          featchingStudentlList.add(studentDetails);
                          return Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Row(
                              children: [
                                Container(
                                  color: addStudentList[studentsSnaps.data!
                                              .docs[index]['studentName']] ==
                                          null
                                      ? Colors.transparent
                                      : addStudentList[studentsSnaps
                                                      .data!.docs[index]
                                                  ['studentName']] ==
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
                                              scrollDirection: Axis.horizontal,
                                              child: GooglePoppinsEventsWidgets(
                                                text:
                                                    studentDetails.studentName!,
                                                fontsize: 11,
                                                fontWeight: FontWeight.w600,
                                              ))),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                IconButton(
                                    onPressed: () async {
                                      addStudentToGroup(studentDetails.docid!,
                                              groupID, studentDetails)
                                          .then((value) {
                                        showToast(msg: 'Added');
                                        addStudentList[studentsSnaps.data!
                                            .docs[index]['studentName']] = true;
                                      });
                                    },
                                    icon: const Icon(Icons.add)),
                                const SizedBox(
                                  width: 20,
                                ),
                                IconButton(
                                    onPressed: () async {
                                      removeStudentToGroup(
                                              studentDetails.docid!,
                                              groupID,
                                              studentDetails)
                                          .then((value) {
                                        showToast(msg: "Removed");
                                        addStudentList[
                                            studentsSnaps.data?.docs[index]
                                                ['studentName']] = false;
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
                        itemCount: studentsSnaps.data!.docs.length);
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

  Future<void> addStudentToGroup(String studentDocID, String groupID,
      AddStudentModel studentDetails) async {
    FirebaseFirestore.instance
        .collection("SchoolListCollection")
        .doc(UserCredentialsController.schoolId)
        .collection(UserCredentialsController.batchId!)
        .doc(UserCredentialsController.batchId)
        .collection('classes')
        .doc(UserCredentialsController.classId)
        .collection('ChatGroups')
        .doc('ChatGroups')
        .collection('Students')
        .doc(groupID)
        .collection('Participants')
        .doc(studentDocID)
        .set(studentDetails.toMap());
  }

  Future<void> removeStudentToGroup(String studentDocID, String groupID,
      AddStudentModel studentDetails) async {
    FirebaseFirestore.instance
        .collection("SchoolListCollection")
        .doc(UserCredentialsController.schoolId)
        .collection(UserCredentialsController.batchId!)
        .doc(UserCredentialsController.batchId)
        .collection('classes')
        .doc(UserCredentialsController.classId)
        .collection('ChatGroups')
        .doc('ChatGroups')
        .collection('Students')
        .doc(groupID)
        .collection('Participants')
        .doc(studentDocID)
        .delete();
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
              await customAddStudentInGroup(groupID);
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
            () => isLoading.value?circularProgressIndicatotWidget:GestureDetector(
              onTap: () async {
                await addAllStudents(
                  groupID,
                ).then((value) => showToast(msg: "All students added in this groups"));
              },
              child: Container(
                decoration:
                    BoxDecoration(color: adminePrimayColor.withOpacity(0.3)),
                height: 60.h,
                width: 150.w,
                child: Center(
                  child: GooglePoppinsEventsWidgets(
                      text: 'Add All Students',
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
