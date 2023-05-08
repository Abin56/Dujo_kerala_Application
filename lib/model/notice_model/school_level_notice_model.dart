// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SchoolLevelNoticeModel {
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
  SchoolLevelNoticeModel({
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

  SchoolLevelNoticeModel copyWith({
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
  }) {
    return SchoolLevelNoticeModel(
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
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'chiefGuest': chiefGuest,
      'customContent': customContent,
      'dateOfSubmission': dateOfSubmission,
      'dateofoccation': dateofoccation,
      'heading': heading,
      'imageId': imageId,
      'imageUrl': imageUrl,
      'noticeId': noticeId,
      'publishedDate': publishedDate,
      'signedBy': signedBy,
      'signedImageId': signedImageId,
      'signedImageUrl': signedImageUrl,
      'venue': venue,
      'visibleGuardian': visibleGuardian,
      'visibleStudent': visibleStudent,
      'visibleTeacher': visibleTeacher,
    };
  }

  factory SchoolLevelNoticeModel.fromMap(Map<String, dynamic> map) {
    return SchoolLevelNoticeModel(
      chiefGuest: map['chiefGuest'] ?? "",
      customContent: map['customContent'] ?? "",
      dateOfSubmission: map['dateOfSubmission'] ?? "",
      dateofoccation: map['dateofoccation'] ?? "",
      heading: map['heading'] ?? "",
      imageId: map['imageId'] ?? "",
      imageUrl: map['imageUrl'] ?? "",
      noticeId: map['noticeId'] ?? "",
      publishedDate: map['publishedDate'] ?? "",
      signedBy: map['signedBy'] ?? "",
      signedImageId: map['signedImageId'] ?? "",
      signedImageUrl: map['signedImageUrl'] ?? "",
      venue: map['venue'] as String,
      visibleGuardian: map['visibleGuardian'] as bool,
      visibleStudent: map['visibleStudent'] as bool,
      visibleTeacher: map['visibleTeacher'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory SchoolLevelNoticeModel.fromJson(String source) =>
      SchoolLevelNoticeModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SchoolLevelNoticeModel(chiefGuest: $chiefGuest, customContent: $customContent, dateOfSubmission: $dateOfSubmission, dateofoccation: $dateofoccation, heading: $heading, imageId: $imageId, imageUrl: $imageUrl, noticeId: $noticeId, publishedDate: $publishedDate, signedBy: $signedBy, signedImageId: $signedImageId, signedImageUrl: $signedImageUrl, venue: $venue, visibleGuardian: $visibleGuardian, visibleStudent: $visibleStudent, visibleTeacher: $visibleTeacher)';
  }

  @override
  bool operator ==(covariant SchoolLevelNoticeModel other) {
    if (identical(this, other)) return true;

    return other.chiefGuest == chiefGuest &&
        other.customContent == customContent &&
        other.dateOfSubmission == dateOfSubmission &&
        other.dateofoccation == dateofoccation &&
        other.heading == heading &&
        other.imageId == imageId &&
        other.imageUrl == imageUrl &&
        other.noticeId == noticeId &&
        other.publishedDate == publishedDate &&
        other.signedBy == signedBy &&
        other.signedImageId == signedImageId &&
        other.signedImageUrl == signedImageUrl &&
        other.venue == venue &&
        other.visibleGuardian == visibleGuardian &&
        other.visibleStudent == visibleStudent &&
        other.visibleTeacher == visibleTeacher;
  }

  @override
  int get hashCode {
    return chiefGuest.hashCode ^
        customContent.hashCode ^
        dateOfSubmission.hashCode ^
        dateofoccation.hashCode ^
        heading.hashCode ^
        imageId.hashCode ^
        imageUrl.hashCode ^
        noticeId.hashCode ^
        publishedDate.hashCode ^
        signedBy.hashCode ^
        signedImageId.hashCode ^
        signedImageUrl.hashCode ^
        venue.hashCode ^
        visibleGuardian.hashCode ^
        visibleStudent.hashCode ^
        visibleTeacher.hashCode;
  }
}
