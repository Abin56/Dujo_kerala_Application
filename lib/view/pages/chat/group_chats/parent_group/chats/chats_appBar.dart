import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:dujo_kerala_application/utils/utils.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/home/events/event_display_school_level.dart';
import 'package:dujo_kerala_application/view/pages/Notice/notice_school_display_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../../controllers/group_chat_controller/group_ParentsTeacher_chat_controller.dart';
import '../../../../../../widgets/drop_down/select_teachers.dart';

showParentsGroupAppBar(
  String groupName,
  String totalParents,
  String groupID,
  BuildContext context,
) async {
  Get.to(() => BootomSheet(
      groupID: groupID, groupName: groupName, totalParents: totalParents));
}

class BootomSheet extends StatelessWidget {
  TeacherParentGroupChatController teacherParentGroupChatController =
      Get.put(TeacherParentGroupChatController());
  String groupName;
  String totalParents;
  String groupID;
  BootomSheet(
      {required this.groupID,
      required this.groupName,
      required this.totalParents,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection('SchoolListCollection')
              .doc(UserCredentialsController.schoolId)
              .collection(UserCredentialsController.batchId!)
              .doc(UserCredentialsController.batchId!)
              .collection('classes')
              .doc(UserCredentialsController.classId!)
              .collection('ChatGroups')
              .doc('ChatGroups')
              .collection("Parents")
              .doc(groupID)
              .collection('Participants')
              .get(),
          builder: (context, snaps) {
            return ListView(
              children: [
                Container(
                  height: 300,
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const CircleAvatar(
                        radius: 40,
                      ),
                      GooglePoppinsWidgetsNotice(
                        text: groupName,
                        fontsize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      Text("Group ${snaps.data!.docs.length} participants"),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  barrierDismissible:
                                      false, // user must tap button!
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text(
                                          'Select teacher to Transfer group'),
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children: <Widget>[
                                            GetSchoolTeacherListDropDownButton()
                                          ],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text('Ok'),
                                          onPressed: () async {
                                            FirebaseFirestore.instance
                                                .collection(
                                                    'SchoolListCollection')
                                                .doc(UserCredentialsController
                                                    .schoolId)
                                                .collection(
                                                    UserCredentialsController
                                                        .batchId!)
                                                .doc(UserCredentialsController
                                                    .batchId!)
                                                .collection('classes')
                                                .doc(UserCredentialsController
                                                    .classId!)
                                                .collection('ChatGroups')
                                                .doc('ChatGroups')
                                                .collection("Parents")
                                                .doc(groupID)
                                                .update({
                                              'teacherId':
                                                  teacherNameListValue!['docid']
                                            }).then((value) {
                                              Navigator.of(context).pop();
                                              showToast(
                                                  msg:
                                                      "Transfer Group Successfully");
                                            });
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
                              child: Container(
                                decoration: BoxDecoration(
                                    color: adminePrimayColor.withOpacity(0.3),
                                    border:
                                        Border.all(color: adminePrimayColor),
                                    borderRadius: BorderRadius.circular(30)),
                                height: 40,
                                width: 140,
                                child: Center(
                                  child: GooglePoppinsEventsWidgets(
                                    text: 'Transfer Group',
                                    fontsize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                          StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('SchoolListCollection')
                                  .doc(UserCredentialsController.schoolId)
                                  .collection(
                                      UserCredentialsController.batchId!)
                                  .doc(UserCredentialsController.batchId!)
                                  .collection('classes')
                                  .doc(UserCredentialsController.classId!)
                                  .collection('ChatGroups')
                                  .doc('ChatGroups')
                                  .collection("Parents")
                                  .doc(groupID)
                                  .snapshots(),
                              builder: (context, groupSnapShot) {
                                if (groupSnapShot.hasData) {
                                  if (groupSnapShot.data!.data()!['activate'] ==
                                      true) {
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: GestureDetector(
                                        onTap: () async {
                                          showDialog(
                                              context: context,
                                              barrierDismissible:
                                                  false, // user must tap button!
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: const Text('Alert'),
                                                  content:
                                                      SingleChildScrollView(
                                                    child: ListBody(
                                                      children: const <Widget>[
                                                        Text(
                                                            'Do you want to Deactivate this group ?')
                                                      ],
                                                    ),
                                                  ),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      child: const Text('ok'),
                                                      onPressed: () async {
                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'SchoolListCollection')
                                                            .doc(
                                                                UserCredentialsController
                                                                    .schoolId)
                                                            .collection(
                                                                UserCredentialsController
                                                                    .batchId!)
                                                            .doc(
                                                                UserCredentialsController
                                                                    .batchId!)
                                                            .collection(
                                                                'classes')
                                                            .doc(
                                                                UserCredentialsController
                                                                    .classId!)
                                                            .collection(
                                                                'ChatGroups')
                                                            .doc('ChatGroups')
                                                            .collection(
                                                                "Parents")
                                                            .doc(groupID)
                                                            .update({
                                                          'activate': false
                                                        }).then((value) {
                                                          Navigator.pop(
                                                              context);
                                                          showToast(
                                                              msg:
                                                                  'Deactivated');
                                                        });
                                                      },
                                                    ),
                                                    TextButton(
                                                      child:
                                                          const Text('cancel'),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                  ],
                                                );
                                              });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.red.withOpacity(0.3),
                                              border:
                                                  Border.all(color: Colors.red),
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          height: 40,
                                          width: 140,
                                          child: Center(
                                            child: GooglePoppinsEventsWidgets(
                                              text: 'Deactivate',
                                              fontsize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  } else {
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: GestureDetector(
                                        onTap: () async {
                                          showDialog(
                                              context: context,
                                              barrierDismissible:
                                                  false, // user must tap button!
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: const Text('Alert'),
                                                  content:
                                                      SingleChildScrollView(
                                                    child: ListBody(
                                                      children: const <Widget>[
                                                        Text(
                                                            'Do you want to Activate this group ?')
                                                      ],
                                                    ),
                                                  ),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      child: const Text('ok'),
                                                      onPressed: () async {
                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'SchoolListCollection')
                                                            .doc(
                                                                UserCredentialsController
                                                                    .schoolId)
                                                            .collection(
                                                                UserCredentialsController
                                                                    .batchId!)
                                                            .doc(
                                                                UserCredentialsController
                                                                    .batchId!)
                                                            .collection(
                                                                'classes')
                                                            .doc(
                                                                UserCredentialsController
                                                                    .classId!)
                                                            .collection(
                                                                'ChatGroups')
                                                            .doc('ChatGroups')
                                                            .collection(
                                                                "Parents")
                                                            .doc(groupID)
                                                            .update({
                                                          'activate': true
                                                        }).then((value) {
                                                          Navigator.pop(
                                                              context);
                                                          showToast(
                                                              msg: 'Activated');
                                                        });
                                                      },
                                                    ),
                                                    TextButton(
                                                      child:
                                                          const Text('cancel'),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                  ],
                                                );
                                              });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.green.withOpacity(0.3),
                                              border: Border.all(
                                                  color: Colors.green),
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          height: 40,
                                          width: 140,
                                          child: Center(
                                            child: GooglePoppinsEventsWidgets(
                                              text: 'Activate',
                                              fontsize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                } else {
                                  return const Center(
                                    child: circularProgressIndicatotWidget,
                                  );
                                }
                              }),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 500,
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 60,
                        child: Row(
                          children: [
                            GooglePoppinsWidgetsNotice(
                              text: '${snaps.data!.docs.length}  participants',
                              fontsize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            IconButton(
                                onPressed: () async {
                                  teacherParentGroupChatController
                                      .customAddParentsInGroup(groupID);
                                },
                                icon: const Icon(Icons.person_add)),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 380,
                            child: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('SchoolListCollection')
                                  .doc(UserCredentialsController.schoolId)
                                  .collection(
                                      UserCredentialsController.batchId!)
                                  .doc(UserCredentialsController.batchId)
                                  .collection('classes')
                                  .doc(UserCredentialsController.classId)
                                  .collection('ChatGroups')
                                  .doc('ChatGroups')
                                  .collection('Parents')
                                  .doc(groupID)
                                  .collection('Participants')
                                  .snapshots(),
                              builder: (context, parentssnapshots) {
                                if (parentssnapshots.hasData) {
                                  return ListView.separated(
                                      itemBuilder: (context, index) {
                                        if (parentssnapshots
                                                .data!.docs.length ==
                                            index) {
                                          return SizedBox(
                                            height: 80.h,
                                          );
                                        }
                                        return GestureDetector(
                                          onLongPress: () async {
                                            showDialog(
                                              context: context,
                                              barrierDismissible:
                                                  false, // user must tap button!
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: const Text('Alert'),
                                                  content:
                                                      SingleChildScrollView(
                                                    child: ListBody(
                                                      children: const <Widget>[
                                                        Text(
                                                            'Do you want to remove this student ?')
                                                      ],
                                                    ),
                                                  ),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      child: const Text('ok'),
                                                      onPressed: () async {
                                                        await teacherParentGroupChatController
                                                            .removeParentToGroup(
                                                                parentssnapshots
                                                                        .data!
                                                                        .docs[index]
                                                                    ['docid'],
                                                                groupID,
                                                                context);
                                                      },
                                                    ),
                                                    TextButton(
                                                      child:
                                                          const Text('cancel'),
                                                      onPressed: () async {
                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            child: Container(
                                              height: 50,
                                              color:
                                                  Colors.blue.withOpacity(0.1),
                                              child: Row(
                                                children: [
                                                  Text("  ${index + 1}"),
                                                  const SizedBox(
                                                    width: 07,
                                                  ),
                                                  const CircleAvatar(),
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                  GooglePoppinsEventsWidgets(
                                                      text: parentssnapshots
                                                              .data!.docs[index]
                                                          ['parentName'],
                                                      fontsize: 12)
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      separatorBuilder: (context, index) {
                                        return const SizedBox(
                                          height: 10,
                                        );
                                      },
                                      itemCount:
                                          parentssnapshots.data!.docs.length +
                                              1);
                                } else {
                                  return const Center(
                                    child: CircularProgressIndicator.adaptive(),
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }
}
