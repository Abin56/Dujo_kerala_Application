import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/model/live_room_model/live_room_model.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/pages/live_classes/enter_to_live.dart';
import 'package:dujo_kerala_application/view/widgets/fonts/google_monstre.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/userCredentials/user_credentials.dart';

class ListofRoomsScreen extends StatelessWidget {
  const ListofRoomsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Rooms'),
        backgroundColor: adminePrimayColor,
      ),
      body: SafeArea(
          child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('SchoolListCollection')
            .doc(UserCredentialsController.schoolId)
            .collection(UserCredentialsController.batchId!)
            .doc(UserCredentialsController.batchId!)
            .collection('Classes')
            .doc(UserCredentialsController.classId)
            .collection('LiveRooms')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.separated(
                itemBuilder: (context, index) {
                  final data =
                      LiveRoomModel.fromJson(snapshot.data!.docs[index].data());
                  return Container(
                    color: const Color.fromARGB(255, 199, 196, 196),
                    height: 200,
                    child: Column(
                      children: [
                        GoogleMonstserratWidgets(
                            text: data.scheduleTime, fontsize: 20),
                        GoogleMonstserratWidgets(
                            text: 'Room Name : ${data.roomName}', fontsize: 20),
                        GoogleMonstserratWidgets(
                            text: 'Time ${data.scheduleTime}', fontsize: 20),
                        GoogleMonstserratWidgets(
                            text: 'Creator : ${data.ownerName}', fontsize: 20),
                        GoogleMonstserratWidgets(
                            text: data.scheduleTime, fontsize: 20),
                        GoogleMonstserratWidgets(
                            text: 'Room ID : ${data.roomID}', fontsize: 20),
                        TextButton.icon(
                            onPressed: () async {
                       
                            
                              Get.to(  LiveClassRoom(roomID: data.roomID));
                    
                            },
                            icon: const Icon(Icons.flash_on_outlined),
                            label: const Text('Start Live'))
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemCount: snapshot.data!.docs.length);
          } else {
            return const Center();
          }
        },
      )),
    );
  }
}
