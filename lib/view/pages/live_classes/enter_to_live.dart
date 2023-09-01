// ignore_for_file: must_be_immutable, sort_child_properties_last

import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/utils/utils.dart';
import 'package:dujo_kerala_application/view/widgets/fonts/google_poppins.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:omni_jitsi_meet/jitsi_meet.dart';

import '../../../controllers/userCredentials/user_credentials.dart';

class LiveClassRoom extends StatefulWidget {
  String roomID;
  String docId;
  String teacherName;
  LiveClassRoom({
    Key? key,
    required this.teacherName,
    required this.docId,
    required this.roomID,
  }) : super(key: key);

  @override
  State<LiveClassRoom> createState() => _LiveClassRoomState();
}

class _LiveClassRoomState extends State<LiveClassRoom> {
  final GlobalKey<FormState> updateFormkey = GlobalKey<FormState>();
  //final serverText = TextEditingController(text: "https://test.scipro.in/");
  final roomText = TextEditingController(text: "");
  final subjectText = TextEditingController(text: "");
  final nameText = TextEditingController(text: "");
  final emailText = TextEditingController(text: "");
  final iosAppBarRGBAColor =
      TextEditingController(text: "#0080FF80"); //transparent blue
  bool? isAudioOnly = false;
  bool? isAudioMuted = false;
  bool? isVideoMuted = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return MaterialApp(
      home: Form(
        key: updateFormkey,
        child: Scaffold(
          appBar: AppBar(
            title: const Text(''),
          ),
          body: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            child: kIsWeb
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: width * 0.30,
                        child: meetConfig(),
                      ),
                      SizedBox(
                          width: width * 0.60,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                                color: Colors.white54,
                                child: SizedBox(
                                  width: width * 0.60 * 0.70,
                                  height: width * 0.60 * 0.70,
                                  child: JitsiMeetConferencing(
                                    extraJS: const [
                                      // extraJs setup example
                                      '<script src="https://code.jquery.com/jquery-3.5.1.slim.js" integrity="sha256-DrT5NfxfbHvMHux31Lkhxg42LY6of8TaYyK50jnxRnM=" crossorigin="anonymous"></script>'
                                    ],
                                  ),
                                )),
                          ))
                    ],
                  )
                : meetConfig(),
          ),
        ),
      ),
    );
  }

  Widget meetConfig() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 16.0,
          ),
          const SizedBox(
            height: 14.0,
          ),
          TextFormField(
            validator: (value) {
              if (roomText.text.isEmpty) {
                return 'Please Enter RoomID';
              } else {
                return null;
              }
            },
            controller: roomText,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: widget.roomID,
            ),
          ),
          const SizedBox(
            height: 14.0,
          ),
          const SizedBox(
            height: 14.0,
          ),
          TextFormField(
            validator: (value) {
              if (roomText.text.isEmpty) {
                return 'Please Enter Your Name';
              } else {
                return null;
              }
            },
            controller: nameText,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: widget.teacherName,
            ),
          ),
          const SizedBox(
            height: 14.0,
          ),
          CheckboxListTile(
            title: const Text("Audio Only"),
            value: isAudioOnly,
            onChanged: _onAudioOnlyChanged,
          ),
          const SizedBox(
            height: 14.0,
          ),
          CheckboxListTile(
            title: const Text("Audio Muted"),
            value: isAudioMuted,
            onChanged: _onAudioMutedChanged,
          ),
          const SizedBox(
            height: 14.0,
          ),
          CheckboxListTile(
            title: const Text("Video Muted"),
            value: isVideoMuted,
            onChanged: _onVideoMutedChanged,
          ),
          const Divider(
            height: 48.0,
            thickness: 2.0,
          ),
          FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('SchoolListCollection')
                  .doc(UserCredentialsController.schoolId)
                  .collection(UserCredentialsController.batchId!)
                  .doc(UserCredentialsController.batchId!)
                  .collection('classes')
                  .doc(UserCredentialsController.classId)
                  .collection('LiveRooms')
                  .doc(widget.docId)
                  .get(),
              builder: (context, snapss) {
                if (snapss.hasData) {
                  if (snapss.data?.data()!['activateLive'] == false) {
                    return SizedBox(
                      height: 64.0,
                      width: double.maxFinite,
                      child: ElevatedButton(
                        onPressed: () async {
                          log("r ${widget.roomID}");
                          log("S ${roomText.text}");
                          log("D ${widget.teacherName}");
                          log("e ${nameText.text}");
                          if (updateFormkey.currentState!.validate() &&
                              widget.roomID == roomText.text.trim() &&
                              nameText.text.trim().isNotEmpty) {
                            _joinMeeting();
                            Future.delayed(const Duration(seconds: 10))
                                .then((value) async {
                              await FirebaseFirestore.instance
                                  .collection('SchoolListCollection')
                                  .doc(UserCredentialsController.schoolId)
                                  .collection(
                                      UserCredentialsController.batchId!)
                                  .doc(UserCredentialsController.batchId!)
                                  .collection('classes')
                                  .doc(UserCredentialsController.classId)
                                  .collection('LiveRooms')
                                  .doc(widget.docId)
                                  .update({'activateLive': true}).then((value) {
                                print(
                                    "workingggggggggggggggggggggggggggggggggggg");
                                showToast(msg: 'Live is ON');
                              });
                            });
                          } else {
                            return showToast(
                                msg:
                                    'Please check RoomID are same or YourName ');
                          }
                        },
                        child: const Text(
                          "Join Meeting",
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith(
                                (states) => Colors.blue)),
                      ),
                    );
                  } else {
                    return const Center();
                  }
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
          FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('SchoolListCollection')
                  .doc(UserCredentialsController.schoolId)
                  .collection(UserCredentialsController.batchId!)
                  .doc(UserCredentialsController.batchId!)
                  .collection('classes')
                  .doc(UserCredentialsController.classId)
                  .collection('LiveRooms')
                  .doc(widget.docId)
                  .get(),
              builder: (context, snap) {
                if (snap.hasData) {
                  if (snap.data?.data()!['activateLive'] == true) {
                    return SizedBox(
                      height: 64.0,
                      width: double.maxFinite,
                      child: GestureDetector(
                        onTap: () async {
                          await FirebaseFirestore.instance
                              .collection('SchoolListCollection')
                              .doc(UserCredentialsController.schoolId)
                              .collection(UserCredentialsController.batchId!)
                              .doc(UserCredentialsController.batchId!)
                              .collection('classes')
                              .doc(UserCredentialsController.classId)
                              .collection('LiveRooms')
                              .doc(widget.docId)
                              .delete()
                              .then((value) => Get.back());
                        },
                        child: Container(
                            height: 64,
                            color: Colors.red,
                            child: Center(
                              child: GooglePoppinsWidgets(
                                text: 'End This Live Room',
                                fontsize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                              ),
                            )),
                      ),
                    );
                  } else {
                    return const Center();
                  }
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
          const SizedBox(
            height: 48.0,
          ),
        ],
      ),
    );
  }

  _onAudioOnlyChanged(bool? value) {
    setState(() {
      isAudioOnly = value;
    });
  }

  _onAudioMutedChanged(bool? value) {
    setState(() {
      isAudioMuted = value;
    });
  }

  _onVideoMutedChanged(bool? value) {
    setState(() {
      isVideoMuted = value;
    });
  }

  _joinMeeting() async {
    //String? serverUrl = serverText.text.trim().isEmpty ? null : serverText.text;
    String serverUrl = "https://live.leptondujo.com/";

    Map<FeatureFlagEnum, dynamic> featureFlags = {
      FeatureFlagEnum.ADD_PEOPLE_ENABLED: false,
      FeatureFlagEnum.ANDROID_SCREENSHARING_ENABLED: false,
      FeatureFlagEnum.AUDIO_FOCUS_DISABLED: false,
      FeatureFlagEnum.AUDIO_MUTE_BUTTON_ENABLED: true,
      FeatureFlagEnum.AUDIO_ONLY_BUTTON_ENABLED: false,
      FeatureFlagEnum.CALENDAR_ENABLED: false,
      FeatureFlagEnum.CAR_MODE_ENABLED: false,
      FeatureFlagEnum.CLOSE_CAPTIONS_ENABLED: false,
      FeatureFlagEnum.CONFERENCE_TIMER_ENABLED: false,
      FeatureFlagEnum.CHAT_ENABLED: false,
      FeatureFlagEnum.FILMSTRIP_ENABLED: false,
      FeatureFlagEnum.FULLSCREEN_ENABLED: true,
      FeatureFlagEnum.HELP_BUTTON_ENABLED: false,
      FeatureFlagEnum.INVITE_ENABLED: false,
      FeatureFlagEnum.IOS_RECORDING_ENABLED: false,
      FeatureFlagEnum.IOS_SCREENSHARING_ENABLED: false,
      FeatureFlagEnum.SPEAKERSTATS_ENABLED: false,
      FeatureFlagEnum.KICK_OUT_ENABLED: false,
      FeatureFlagEnum.LIVE_STREAMING_ENABLED: false,
      FeatureFlagEnum.LOBBY_MODE_ENABLED: false,
      FeatureFlagEnum.MEETING_NAME_ENABLED: false,
      FeatureFlagEnum.MEETING_PASSWORD_ENABLED: false,
      FeatureFlagEnum.NOTIFICATIONS_ENABLED: false,
      FeatureFlagEnum.OVERFLOW_MENU_ENABLED: true,
      FeatureFlagEnum.PIP_ENABLED: false,
      FeatureFlagEnum.PREJOIN_PAGE_ENABLED: false,
      FeatureFlagEnum.RAISE_HAND_ENABLED: true,
      FeatureFlagEnum.REACTIONS_ENABLED: false,
      FeatureFlagEnum.RECORDING_ENABLED: false,
      FeatureFlagEnum.REPLACE_PARTICIPANT: false,
      FeatureFlagEnum.RESOLUTION: FeatureFlagVideoResolution.HD_RESOLUTION,
      FeatureFlagEnum.SECURITY_OPTIONS_ENABLED: false,
      FeatureFlagEnum.SERVER_URL_CHANGE_ENABLED: false,
      FeatureFlagEnum.SETTINGS_ENABLED: false,
      FeatureFlagEnum.TILE_VIEW_ENABLED: true,
      FeatureFlagEnum.TOOLBOX_ALWAYS_VISIBLE: false,
      FeatureFlagEnum.TOOLBOX_ENABLED: true,
      FeatureFlagEnum.VIDEO_MUTE_BUTTON_ENABLED: true,
      FeatureFlagEnum.VIDEO_SHARE_BUTTON_ENABLED: false,
      FeatureFlagEnum.WELCOME_PAGE_ENABLED: false,
    };
    if (!kIsWeb && Platform.isAndroid) {
      featureFlags[FeatureFlagEnum.CALL_INTEGRATION_ENABLED] = false;
    }
    // Define meetings options here
    var options = JitsiMeetingOptions(room: roomText.text);
    // ..serverURL = serverUrl
    // ..subject = subjectText.text
    // ..userDisplayName = nameText.text
    // ..userEmail = emailText.text
    // ..iosAppBarRGBAColor = iosAppBarRGBAColor.text
    // ..audioOnly = isAudioOnly
    // ..audioMuted = isAudioMuted
    // ..videoMuted = isVideoMuted
    // ..featureFlags?.addAll(featureFlags)
    // ..webOptions = {
    //   "roomName": roomText.text,
    //   "width": "100%",
    //   "height": "100%",
    //   "enableWelcomePage": false,
    //   "enableNoAudioDetection": true,
    //   "enableNoisyMicDetection": true,
    //   "enableClosePage": false,
    //   "prejoinPageEnabled": false,
    //   "hideConferenceTimer": true,
    //   "disableInviteFunctions": true,
    //   "chromeExtensionBanner": null,
    //   "configOverwrite": {
    //     "prejoinPageEnabled": false,
    //     "disableDeepLinking": true,
    //     "enableLobbyChat": false,
    //     "enableClosePage": false,
    //     "toolbarButtons": [
    //       "microphone",
    //       "camera",
    //       "hangup",
    //     ]
    //   },
    //   "userInfo": {"email": emailText.text, "displayName": nameText.text}
    // };

    await JitsiMeet.joinMeeting(
      options,
      listener: JitsiMeetingListener(
          onOpened: () {
            debugPrint("JitsiMeetingListener - onOpened");
          },
          onClosed: () {
            debugPrint("JitsiMeetingListener - onClosed");
          },
          onError: (error) {
            debugPrint("JitsiMeetingListener - onError: error: $error");
          },
          onConferenceWillJoin: (url) {
            debugPrint(
                "JitsiMeetingListener - onConferenceWillJoin: url: $url");
          },
          onConferenceJoined: (url) {
            debugPrint("JitsiMeetingListener - onConferenceJoined: url:$url");
          },
          onConferenceTerminated: (url, error) {
            debugPrint(
                "JitsiMeetingListener - onConferenceTerminated: url: $url, error: $error");
          },
          onParticipantLeft: (participantId) {
            debugPrint(
                "JitsiMeetingListener - onParticipantLeft: $participantId");
          },
          onParticipantJoined: (email, name, role, participantId) {
            debugPrint("JitsiMeetingListener - onParticipantJoined: "
                "email: $email, name: $name, role: $role, "
                "participantId: $participantId");
          },
          onAudioMutedChanged: (muted) {
            debugPrint(
                "JitsiMeetingListener - onAudioMutedChanged: muted: $muted");
          },
          onVideoMutedChanged: (muted) {
            debugPrint(
                "JitsiMeetingListener - onVideoMutedChanged: muted: $muted");
          },
          onScreenShareToggled: (participantId, isSharing) {
            debugPrint("JitsiMeetingListener - onScreenShareToggled: "
                "participantId: $participantId, isSharing: $isSharing");
          },
          genericListeners: [
            JitsiGenericListener(
                eventName: 'readyToClose',
                callback: (dynamic message) {
                  debugPrint("JitsiMeetingListener - readyToClose callback");
                }),
          ]),
    );
  }
}
