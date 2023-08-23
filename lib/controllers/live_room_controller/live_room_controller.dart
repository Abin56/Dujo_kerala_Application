import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/model/live_room_model/live_room_model.dart';
import 'package:dujo_kerala_application/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../userCredentials/user_credentials.dart';

class LiveRoomController extends GetxController {
  Future<void> createRoom(
    BuildContext context,
    String roomName,
    String scheduleTime,
    String docid,
    String roomID,
    String ownerName,
  ) async {
    log('School ID ::${UserCredentialsController.schoolId}');
    log('batchId ID ::${UserCredentialsController.batchId}');
    log('classId ID ::${UserCredentialsController.classId}');
    log('roomName ID ::$roomName');
    log('scheduleTime ID ::$scheduleTime');
    log('docid ID ::$docid');
    log('roomID ID ::$roomID');
    log('ownerName ID ::$ownerName');

    final liveModel = LiveRoomModel(
        createDate: DateTime.now().toString(),
        roomName: roomName,
        scheduleTime: scheduleTime,
        docid: docid,
        roomID: roomID,
        ownerName: ownerName,
        activateLive: false);

    await FirebaseFirestore.instance
        .collection('SchoolListCollection')
        .doc(UserCredentialsController.schoolId)
        .collection(UserCredentialsController.batchId!)
        .doc(UserCredentialsController.batchId!)
        .collection('classes')
        .doc(UserCredentialsController.classId)
        .collection('LiveRooms')
        .doc(liveModel.docid)
        .set(liveModel.toJson())
        .then((value) {
      showToast(msg: 'Room Created Successfully');
    });
  }
}
