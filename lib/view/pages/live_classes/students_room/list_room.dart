import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:dujo_kerala_application/model/live_room_model/live_room_model.dart';
import 'package:dujo_kerala_application/utils/utils.dart';
import 'package:dujo_kerala_application/view/pages/live_classes/students_room/join_meet.dart';
import 'package:dujo_kerala_application/view/widgets/fonts/google_monstre.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StudentsRoomListScreen extends StatelessWidget {
  const StudentsRoomListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('SchoolListCollection')
            .doc(UserCredentialsController.schoolId)
            .collection(UserCredentialsController.batchId!)
            .doc(UserCredentialsController.batchId)
            .collection('Classes')
            .doc(UserCredentialsController.classId)
            .collection('LiveRooms')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: GoogleMonstserratWidgets(
                    text: 'No Live Rooms', fontsize: 20),
              );
            } else {
              return ListView.separated(
                  itemBuilder: (context, index) {
                    final data = LiveRoomModel.fromJson(
                        snapshot.data!.docs[index].data());
                    return SizedBox(
                        height: 100,
                        child: data.activateLive == true
                            ? IconButton(
                                onPressed: () async {
                                  Get.to(StudentLiveClassRoom(
                                      studentName: UserCredentialsController
                                          .studentModel!.studentName,
                                      docId: data.docid,
                                      roomID: data.roomID));
                                },
                                icon: const Icon(Icons.join_full))
                            : const Text(''));
                  },
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                  itemCount: snapshot.data!.docs.length);
            }
          } else {
            return const Center(
              child: circularProgressIndicatotWidget,
            );
          }
        },
      )),
    );
  }
}
