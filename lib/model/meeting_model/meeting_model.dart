// To parse this JSON data, do
//
//     final meetingModel = meetingModelFromJson(jsonString);

import 'dart:convert';

MeetingModel meetingModelFromJson(String str) =>
    MeetingModel.fromJson(json.decode(str));

String meetingModelToJson(MeetingModel data) => json.encode(data.toJson());

class MeetingModel {
  String categoryOfMeeting;
  String date;
  String heading;
  String meetingId;
  String membersToBeExpected;
  String specialGuest;
  String time;
  String venue;
  bool visibleGuardian;
  bool visibleStudent;
  bool visibleTeacher;

  MeetingModel({
    required this.categoryOfMeeting,
    required this.date,
    required this.heading,
    required this.meetingId,
    required this.membersToBeExpected,
    required this.specialGuest,
    required this.time,
    required this.venue,
    required this.visibleGuardian,
    required this.visibleStudent,
    required this.visibleTeacher,
  });

  MeetingModel copyWith({
    String? categoryOfMeeting,
    String? date,
    String? heading,
    String? meetingId,
    String? membersToBeExpected,
    String? specialGuest,
    String? time,
    String? venue,
    bool? visibleGuardian,
    bool? visibleStudent,
    bool? visibleTeacher,
  }) =>
      MeetingModel(
        categoryOfMeeting: categoryOfMeeting ?? this.categoryOfMeeting,
        date: date ?? this.date,
        heading: heading ?? this.heading,
        meetingId: meetingId ?? this.meetingId,
        membersToBeExpected: membersToBeExpected ?? this.membersToBeExpected,
        specialGuest: specialGuest ?? this.specialGuest,
        time: time ?? this.time,
        venue: venue ?? this.venue,
        visibleGuardian: visibleGuardian ?? this.visibleGuardian,
        visibleStudent: visibleStudent ?? this.visibleStudent,
        visibleTeacher: visibleTeacher ?? this.visibleTeacher,
      );

  factory MeetingModel.fromJson(Map<String, dynamic> json) => MeetingModel(
        categoryOfMeeting: json["categoryOfMeeting"] ?? "",
        date: json["date"] ?? "",
        heading: json["heading"] ?? "",
        meetingId: json["meetingId"] ?? "",
        membersToBeExpected: json["membersToBeExpected"] ?? "",
        specialGuest: json["specialGuest"] ?? "",
        time: json["time"] ?? "",
        venue: json["venue"] ?? "",
        visibleGuardian: json["visibleGuardian"] ?? "",
        visibleStudent: json["visibleStudent"] ?? "",
        visibleTeacher: json["visibleTeacher"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "categoryOfMeeting": categoryOfMeeting,
        "date": date,
        "heading": heading,
        "meetingId": meetingId,
        "membersToBeExpected": membersToBeExpected,
        "specialGuest": specialGuest,
        "time": time,
        "venue": venue,
        "visibleGuardian": visibleGuardian,
        "visibleStudent": visibleStudent,
        "visibleTeacher": visibleTeacher,
      };
}
