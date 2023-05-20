import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/model/live_room_model/live_room_model.dart';
import 'package:dujo_kerala_application/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../userCredentials/user_credentials.dart';

class LiveRoomController extends GetxController {
  final firebaseFirestore = FirebaseFirestore.instance
      .collection('SchoolListCollection')
      .doc(UserCredentialsController.schoolId)
      .collection(UserCredentialsController.batchId!)
      .doc(UserCredentialsController.batchId)
      .collection('Classes')
      .doc(UserCredentialsController.classId)
      .collection('LiveRooms');
  createRoom(
    BuildContext context,
    String roomName,
    String scheduleTime,
    String docid,
    String roomID,
    String ownerName,
  ) {
    final liveModel = LiveRoomModel(
        roomName: roomName,
        scheduleTime: scheduleTime,
        docid: docid,
        roomID: roomID,
        ownerName: ownerName,
        activateLive: false);

    firebaseFirestore
        .doc(UserCredentialsController.classId)
        .set({}).then((value) {
      showToast(msg: 'Room Created Successfully');
      Navigator.pop(context);
    });
  }
}
