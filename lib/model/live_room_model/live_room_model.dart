// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

LiveRoomModel LiveRoomModelFromJson(String str) =>
    LiveRoomModel.fromJson(json.decode(str));

String LiveRoomModelToJson(LiveRoomModel data) => json.encode(data.toJson());

class LiveRoomModel {
  LiveRoomModel(
      {required this.roomName,
      required this.scheduleTime,
      required this.docid,
      required this.roomID,
      required this.ownerName,
      required this.createDate,
      required this.activateLive});

  String roomName;
  String scheduleTime;
  String docid;
  String roomID;
  String ownerName;
  String createDate;
  bool activateLive = false;
  factory LiveRoomModel.fromJson(Map<String, dynamic> json) => LiveRoomModel(
        roomName: json["roomName"] ?? '',
        scheduleTime: json["scheduleTime"] ?? '',
        docid: json["docid"] ?? '',
        roomID: json["roomID"] ?? '',
        ownerName: json["ownerName"] ?? '',
         createDate: json["createDate"] ?? '',
        activateLive: json["activateLive"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "roomName": roomName,
        "scheduleTime": scheduleTime,
        "docid": docid,
        "roomID": roomID,
        "ownerName": ownerName,
               "createDate": createDate,
        "activateLive": activateLive,
      };
}
