import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/controllers/live_room_controller/live_room_controller.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/constant/sizes/constant.dart';
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
              bottom: 0.r,
              left: 0.r,
              right: 0.r,
              top: 0.r,
              child: ButtonContainerWidget(
                curving: 0.r,
                colorindex: 0,
                height: ScreenUtil().setHeight(100),
                width: double.infinity,
                child: Column(
                  children: [
                    SizedBox(
                      height: ScreenUtil().setHeight(90),
                    ),
                    GoogleMonstserratWidgets(
                        text: "DuJO Live",
                        fontsize: 35.sp,
                        color: cWhite,
                        fontWeight: FontWeight.bold),
                    SizedBox(
                      height: ScreenUtil().setHeight(60),
                    ),
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
                                      Get.to(() => const ListofRoomsScreen());
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 20),
                                      child: Container(
                                        height: ScreenUtil().setHeight(40),
                                        width: ScreenUtil().setWidth(150),
                                        color: const Color.fromARGB(
                                            63, 255, 255, 255),
                                        child: Center(
                                          child: GooglePoppinsWidgets(
                                            fontsize: 16.sp,
                                            text: 'View session',
                                            color: cWhite,
                                          ),
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
                bottom: 0.r,
                left: 0.r,
                right: 0.r,
                top: 300.r,
                child: Container(
                  decoration: const BoxDecoration(
                      color: cWhite,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  height: ScreenUtil().setHeight(250),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: ScreenUtil().setHeight(40),
                        ),
                        GooglePoppinsWidgets(
                          fontsize: 30.sp,
                          text: 'Create live session',
                          fontWeight: FontWeight.bold,
                        ),
                        //  kHeight10,
                        GooglePoppinsWidgets(
                          fontsize: 16.sp,
                          text: 'Enter session details',
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(30),
                        ),

                        ButtonContainerWidget(
                            curving: 10.r,
                            colorindex: 2,
                            height: ScreenUtil().setHeight(40),
                            width: ScreenUtil().setWidth(300),
                            child: Padding(
                              padding: EdgeInsets.only(top: 5.r, left: 10.r),
                              child: Center(
                                child: GooglePoppinsWidgets(
                                    text: 'Session ID :  $randomID',
                                    color: Colors.white,
                                    fontsize: 15.sp),
                              ),
                            )),
                        SizedBox(
                          height: ScreenUtil().setHeight(30),
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(80),
                          child: Padding(
                            padding: EdgeInsets.only(left: 8.0.r, right: 8.0.r),
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
                                      height: ScreenUtil().setHeight(50),
                                      width: ScreenUtil().setWidth(200),
                                      child: Center(
                                        child: TextFormField(
                                          style: TextStyle(fontSize: 16.sp),
                                          controller: _roomNameController,
                                          validator: (value) {
                                            if (_roomNameController
                                                .text.isEmpty) {
                                              return 'Please Enter Room Name';
                                            } else {
                                              return null;
                                            }
                                          },
                                          decoration: InputDecoration(
                                            hintText: 'Enter the topic',
                                            border: const OutlineInputBorder(),
                                            contentPadding:
                                                const EdgeInsets.all(7).r,
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
                            height: ScreenUtil().setHeight(80),
                            child: Padding(
                              padding:
                                  EdgeInsets.only(left: 8.0.r, right: 8.0.r),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: ScreenUtil().setHeight(50),
                                        width: ScreenUtil().setWidth(150),
                                        child: Center(
                                            child: TextFormField(
                                          style: TextStyle(fontSize: 16.sp),
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
                              await widget.liveRoomController
                                  .createRoom(
                                      context,
                                      _roomNameController.text.trim(),
                                      _timeController.text,
                                      uuid.v1(),
                                      randomID,
                                      UserCredentialsController
                                              .teacherModel!.teacherName ??
                                          "test")
                                  .then((value) {
                                _timeController.clear();
                                _roomNameController.clear();

                                ////
                              });
                            } else {
                              return;
                            }
                          },
                          child: ButtonContainerWidget(
                              curving: 10.r,
                              colorindex: 2,
                              height: ScreenUtil().setHeight(50),
                              width: ScreenUtil().setWidth(240),
                              child: Center(
                                  child: GooglePoppinsWidgets(
                                text: 'Create Session ',
                                fontsize: 18.sp,
                                color: cWhite,
                              ))),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 10.r, right: 20.r),
                              child: Column(
                                children: [
                                  GooglePoppinsWidgets(
                                      text:
                                          'Owner : ${UserCredentialsController.teacherModel?.teacherName}',
                                      fontsize: 14.sp),
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
