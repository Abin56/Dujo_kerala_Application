// To parse this JSON data, do
//
//     final noticeModel = noticeModelFromJson(jsonString);

import 'dart:convert';

NoticeModel noticeModelFromJson(String str) =>
    NoticeModel.fromJson(json.decode(str));

String noticeModelToJson(NoticeModel data) => json.encode(data.toJson());

class NoticeModel {
  String chiefGuest;
  String customContent;
  String dateOfSubmission;
  String dateofoccation;
  String heading;
  String imageId;
  String imageUrl;
  String noticeId;
  String publishedDate;
  String signedBy;
  String signedImageId;
  String signedImageUrl;
  String venue;
  bool visibleGuardian;
  bool visibleStudent;
  bool visibleTeacher;

  NoticeModel({
    required this.chiefGuest,
    required this.customContent,
    required this.dateOfSubmission,
    required this.dateofoccation,
    required this.heading,
    required this.imageId,
    required this.imageUrl,
    required this.noticeId,
    required this.publishedDate,
    required this.signedBy,
    required this.signedImageId,
    required this.signedImageUrl,
    required this.venue,
    required this.visibleGuardian,
    required this.visibleStudent,
    required this.visibleTeacher,
  });

  NoticeModel copyWith({
    String? chiefGuest,
    String? customContent,
    String? dateOfSubmission,
    String? dateofoccation,
    String? heading,
    String? imageId,
    String? imageUrl,
    String? noticeId,
    String? publishedDate,
    String? signedBy,
    String? signedImageId,
    String? signedImageUrl,
    String? venue,
    bool? visibleGuardian,
    bool? visibleStudent,
    bool? visibleTeacher,
  }) =>
      NoticeModel(
        chiefGuest: chiefGuest ?? this.chiefGuest,
        customContent: customContent ?? this.customContent,
        dateOfSubmission: dateOfSubmission ?? this.dateOfSubmission,
        dateofoccation: dateofoccation ?? this.dateofoccation,
        heading: heading ?? this.heading,
        imageId: imageId ?? this.imageId,
        imageUrl: imageUrl ?? this.imageUrl,
        noticeId: noticeId ?? this.noticeId,
        publishedDate: publishedDate ?? this.publishedDate,
        signedBy: signedBy ?? this.signedBy,
        signedImageId: signedImageId ?? this.signedImageId,
        signedImageUrl: signedImageUrl ?? this.signedImageUrl,
        venue: venue ?? this.venue,
        visibleGuardian: visibleGuardian ?? this.visibleGuardian,
        visibleStudent: visibleStudent ?? this.visibleStudent,
        visibleTeacher: visibleTeacher ?? this.visibleTeacher,
      );

  factory NoticeModel.fromJson(Map<String, dynamic> json) => NoticeModel(
        chiefGuest: json["chiefGuest"] ?? "",
        customContent: json["customContent"] ?? "",
        dateOfSubmission: json["dateOfSubmission"] ?? "",
        dateofoccation: json["dateofoccation"] ?? "",
        heading: json["heading"] ?? "",
        imageId: json["imageId"] ?? "",
        imageUrl: json["imageUrl"] ?? "",
        noticeId: json["noticeId"] ?? "",
        publishedDate: json["publishedDate"] ?? "",
        signedBy: json["signedBy"] ?? "",
        signedImageId: json["signedImageId"] ?? "",
        signedImageUrl: json["signedImageUrl"] ?? "",
        venue: json["venue"] ?? "",
        visibleGuardian: json["visibleGuardian"] ?? "",
        visibleStudent: json["visibleStudent"] ?? "",
        visibleTeacher: json["visibleTeacher"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "chiefGuest": chiefGuest,
        "customContent": customContent,
        "dateOfSubmission": dateOfSubmission,
        "dateofoccation": dateofoccation,
        "heading": heading,
        "imageId": imageId,
        "imageUrl": imageUrl,
        "noticeId": noticeId,
        "publishedDate": publishedDate,
        "signedBy": signedBy,
        "signedImageId": signedImageId,
        "signedImageUrl": signedImageUrl,
        "venue": venue,
        "visibleGuardian": visibleGuardian,
        "visibleStudent": visibleStudent,
        "visibleTeacher": visibleTeacher,
      };
}
