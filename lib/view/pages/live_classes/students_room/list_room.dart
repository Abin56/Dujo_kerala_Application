import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:dujo_kerala_application/model/live_room_model/live_room_model.dart';
import 'package:dujo_kerala_application/utils/utils.dart';
import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:dujo_kerala_application/view/pages/live_classes/students_room/join_meet.dart';
import 'package:dujo_kerala_application/view/widgets/fonts/google_monstre.dart';
import 'package:dujo_kerala_application/view/widgets/fonts/google_poppins.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StudentsRoomListScreen extends StatelessWidget {
  const StudentsRoomListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: StreamBuilder(
                  stream: FirebaseFirestore.instance
              .collection('SchoolListCollection')
              .doc(UserCredentialsController.schoolId)
              .collection(UserCredentialsController.batchId!)
              .doc(UserCredentialsController.batchId)
              .collection('classes')
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
                      return Container(
                        height: 200,
                        color: Colors.grey.withOpacity(0.3),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GoogleMonstserratWidgets(
                              text: data.roomName,
                              fontsize: 20,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                            ),
                            kHeight10,
                            Row(
                              children: [
                                GooglePoppinsWidgets(
                                  text: '   Assigned Teacher :  ',
                                  fontsize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                GoogleMonstserratWidgets(
                                  text: ' ${data.ownerName}',
                                  fontsize: 16,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                GooglePoppinsWidgets(
                                  text: '   Room ID :',
                                  fontsize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                GoogleMonstserratWidgets(
                                  text: ' ${data.roomID}',
                                  fontsize: 16,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                GooglePoppinsWidgets(
                                  text: '   ScheduleTime : ',
                                  fontsize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                GoogleMonstserratWidgets(
                                  text: ' ${data.scheduleTime}',
                                  fontsize: 16,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Spacer(),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      color: Colors.grey.withOpacity(0.3),
                                      child: data.activateLive == true
                                          ? GestureDetector(
                                              onTap: () async {
                                                await Get.to(()=>StudentLiveClassRoom(
                                                    studentName:
                                                        UserCredentialsController
                                                            .studentModel!
                                                            .studentName,
                                                    docId: data.docid,
                                                    roomID: data.roomID));
                                              },
                                              child: Container(
                                                color: Colors.green,
                                                height: 40,
                                                width: 200,
                                                child: Center(
                                                  child: GoogleMonstserratWidgets(
                                                    text: 'Join Now',
                                                    fontsize: 16,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            )
                                          : const Text('')),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
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
                ),
          )),
    );
  }
}
