import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/controllers/live_room_controller/live_room_controller.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/constant/sizes/constant.dart';
import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:dujo_kerala_application/view/pages/live_classes/teacher_live_section/list_of_rooms.dart';
import 'package:dujo_kerala_application/view/widgets/button_container_widget.dart';
import 'package:dujo_kerala_application/view/widgets/fonts/google_monstre.dart';
import 'package:dujo_kerala_application/view/widgets/fonts/google_poppins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CreateRoomScreen extends StatefulWidget {
  LiveRoomController liveRoomController = Get.put(LiveRoomController());
  CreateRoomScreen({super.key});

  @override
  State<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends State<CreateRoomScreen> {
  String randomID = '';
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _roomNameController = TextEditingController();

  createRandomID() async {
    var random = Random();
    String roomName = (random.nextInt(10000000) + 10000000).toString();
    randomID = roomName;
  }

  @override
  void initState() {
    createRandomID();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> updateFormkey = GlobalKey<FormState>();
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,

              right: 0,
              top: 0,
              child: ButtonContainerWidget(
                curving: 0,
                colorindex: 0,
                height: 100,
                width: double.infinity,
                child: Column(
                  children: [
                    kHeight30,
                    kHeight30,
                    kHeight30,
                    GoogleMonstserratWidgets(
                        text: "DuJO Live",
                        fontsize: 35,
                        color: cWhite,
                        fontWeight: FontWeight.bold),
                    kHeight20,
                    kHeight20,
                    kHeight20,
                    Row(
                      children: [
                        const Spacer(),
                        StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('SchoolListCollection')
                                .doc(UserCredentialsController.schoolId)
                                .collection(UserCredentialsController.batchId!)
                                .doc(UserCredentialsController.batchId!)
                                .collection('classes')
                                .doc(UserCredentialsController.classId)
                                .collection('LiveRooms')
                                .snapshots(),
                            builder: (context, snap) {
                              if (snap.hasData) {
                                if (snap.data!.docs.isEmpty) {
                                  return const Center();
                                } else {
                                  return GestureDetector(
                                    onTap: () {
                                      Get.to(()=>const ListofRoomsScreen());
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 150,
                                      color:
                                          const Color.fromARGB(63, 255, 255, 255),
                                      child: Center(
                                        child: GooglePoppinsWidgets(
                                          fontsize: 16,
                                          text: 'View session',
                                          color: cWhite,
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              } else {
                                return const Center();
                              }
                            }),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Form(
              key: updateFormkey,
              child: Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                top: 300,
                child: Container(
                  decoration: const BoxDecoration(
                      color: cWhite,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  height: 250,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        kHeight40,
                        GooglePoppinsWidgets(
                          fontsize: 30,
                          text: 'Create live session',
                          fontWeight: FontWeight.bold,
                        ),
                        //  kHeight10,
                        GooglePoppinsWidgets(
                          fontsize: 16,
                          text: 'Enter session details',
                        ),
                        kHeight30,

                        ButtonContainerWidget(
                            curving: 10,
                            colorindex: 2,
                            height: 40,
                            width: 300,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8, left: 10),
                              child: GooglePoppinsWidgets(
                                text: 'Session ID :  $randomID',
                                color: Colors.white,
                                fontsize: 15,
                              ),
                            )),
                        kHeight30,
                        SizedBox(
                          height: 80,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // GooglePoppinsWidgets(
                                    //   fontsize: 12,
                                    //   fontWeight: FontWeight.w300,
                                    //   text: 'Room Name : ',
                                    // ),
                                    SizedBox(
                                      height: 50,
                                      width: 200,
                                      child: Center(
                                        child: TextFormField(
                                          controller: _roomNameController,
                                          validator: (value) {
                                            if (_roomNameController
                                                .text.isEmpty) {
                                              return 'Please Enter Room Name';
                                            } else {
                                              return null;
                                            }
                                          },
                                          decoration: const InputDecoration(
                                            hintText: 'Enter the topic',
                                            border: OutlineInputBorder(),
                                            contentPadding: EdgeInsets.all(7),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            selectTime(context);
                          },
                          child: SizedBox(
                            height: 80,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      // GooglePoppinsWidgets(
                                      //   fontsize: 12,
                                      //   fontWeight: FontWeight.w300,
                                      //   text: 'Select Time : ',
                                      // ),
                                      SizedBox(
                                        height: 50.w,
                                        width: 150.w,
                                        child: Center(
                                            child: TextFormField(
                                          validator: (value) {
                                            if (_timeController.text.isEmpty) {
                                              return "Please select Time";
                                            } else {
                                              return null;
                                            }
                                          },
                                          controller: _timeController,
                                          decoration: const InputDecoration(
                                            hintText: '  Selected Time',
                                          ),
                                          readOnly: true,
                                        )),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            selectTime(context);
                                          },
                                          icon: const Icon(Icons.timer))
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),

                        GestureDetector(
                          onTap: () async {
                            if (updateFormkey.currentState!.validate()) {
                              await widget.liveRoomController.createRoom(
                                  context,
                                  _roomNameController.text.trim(),
                                  _timeController.text,
                                  uuid.v1(),
                                  randomID,
                                  UserCredentialsController
                                          .teacherModel!.teacherName ??
                                      "test");
                            } else {
                              return;
                            }
                          },
                          child: ButtonContainerWidget(
                              curving: 10,
                              colorindex: 2,
                              height: 50,
                              width: 240,
                              child: Center(
                                  child: GooglePoppinsWidgets(
                                text: 'Create Session ',
                                fontsize: 18,
                                color: cWhite,
                              ))),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, right: 20),
                              child: Column(
                                children: [
                                  GooglePoppinsWidgets(
                                      text:
                                          'Owner : ${UserCredentialsController.teacherModel?.teacherName}',
                                      fontsize: 14),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime != null) {
      final String formattedTime = selectedTime.format(context);
      _timeController.text = formattedTime;
    }
  }
}

const containerColor = [
  [
    Color.fromARGB(255, 27, 199, 159),
    Color.fromARGB(255, 202, 141, 161),
  ],
  [Color.fromARGB(255, 202, 141, 161), Color.fromARGB(255, 55, 124, 158)],
  [Color(0xff6448fe), Color(0xff5fc6ff)],
  [Color(0xfffe6197), Color.fromARGB(255, 159, 94, 25)],
  [Color.fromARGB(107, 2, 141, 64), Color.fromARGB(107, 2, 141, 64)],
  [Color.fromARGB(255, 116, 130, 255), Color.fromARGB(255, 86, 74, 117)],
  [Color.fromARGB(255, 205, 215, 15), Color.fromARGB(255, 224, 173, 22)],
  [Color.fromARGB(255, 208, 104, 105), Color.fromARGB(255, 241, 66, 66)],
  [Color.fromARGB(255, 242, 230, 230), Color.fromARGB(255, 255, 252, 252)]
];
