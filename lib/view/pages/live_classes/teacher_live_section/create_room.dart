import 'dart:math';

import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:dujo_kerala_application/view/widgets/button_container_widget.dart';
import 'package:dujo_kerala_application/view/widgets/fonts/google_monstre.dart';
import 'package:dujo_kerala_application/view/widgets/fonts/google_poppins.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CreateRoomScreen extends StatefulWidget {
  const CreateRoomScreen({super.key});

  @override
  State<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends State<CreateRoomScreen> {
  String randomID = '';
  final TextEditingController _timeController = TextEditingController();

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
                      ],
                    ))),
            Positioned(
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
                        text: 'Create Live Room',
                        fontWeight: FontWeight.bold,
                      ),
                      //  kHeight10,
                      GooglePoppinsWidgets(
                        fontsize: 16,
                        text: 'Enter Room Details',
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
                              text: 'Room ID :  $randomID',
                              color: Colors.white,
                              fontsize: 15,
                            ),
                          )),
                      kHeight30,
                      SizedBox(
                        height: 80,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GooglePoppinsWidgets(
                                    fontsize: 12,
                                    fontWeight: FontWeight.w300,
                                    text: 'Room Name : ',
                                  ),
                                  SizedBox(
                                    height: 50,
                                    width: 200,
                                    child: Center(
                                      child: TextFormField(
                                        decoration: const InputDecoration(
                                          hintText: 'Enter Room Name',
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
                            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GooglePoppinsWidgets(
                                      fontsize: 12,
                                      fontWeight: FontWeight.w300,
                                      text: 'Select Time : ',
                                    ),
                                    SizedBox(
                                      height: 50,
                                      width: 150,
                                      child: Center(
                                          child: TextFormField(
                                        controller: _timeController,
                                        decoration: const InputDecoration(
                                          hintText: '  Selected Time',
                                        ),
                                        readOnly: true,
                                      )),
                                    ),
                                    IconButton(onPressed: () {
                                      selectTime(context);
                                      
                                    }, icon: const Icon(Icons.timer))
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),

                      ButtonContainerWidget(
                          curving: 10,
                          colorindex: 2,
                          height: 50,
                          width: 240,
                          child: Center(
                              child: GooglePoppinsWidgets(
                            text: 'Create Room ',
                            fontsize: 18,
                            color: cWhite,
                          ))),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10, right: 20),
                            child: Column(
                              children: [
                                GooglePoppinsWidgets(
                                    text:
                                        'Owner: ${FirebaseAuth.instance.currentUser!.displayName}',
                                    fontsize: 14),
                                GooglePoppinsWidgets(
                                    text: 'Owner: ', fontsize: 14),
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
