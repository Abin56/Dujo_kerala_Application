// ignore_for_file: public_member_api_docs, sort_constructors_first
//     final UploadProgressReportModel = UploadProgressReportModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class UploadProgressReportModel {
  String id;
  String whichExam;
  String publishDate;
  String studentName;
  String rollNo;
  String wClass;
  String teacherName;
  String schoolName;
  String schoolPlace;
  String studentIMage;
  List<ExamReports> reports;
  UploadProgressReportModel({
    required this.teacherName,
    required this.id,
    required this.whichExam,
    required this.publishDate,
    required this.studentName,
    required this.rollNo,
    required this.wClass,
    required this.reports,
    required this.schoolName,
    required this.schoolPlace,
    required this.studentIMage,
  });

  UploadProgressReportModel copyWith({
    String? id,
    String? whichExam,
    String? publishDate,
    String? studentName,
    String? rollNo,
    String? wClass,
    String? teacherName,
    String? schoolName,
    String? schoolPlace,
    String? studentIMage,
    List<ExamReports>? reports,
  }) {
    return UploadProgressReportModel(
      id: id ?? this.id,
      whichExam: whichExam ?? this.whichExam,
      publishDate: publishDate ?? this.publishDate,
      studentName: studentName ?? this.studentName,
      rollNo: rollNo ?? this.rollNo,
      wClass: wClass ?? this.wClass,
      reports: reports ?? this.reports,
      teacherName: id ?? this.teacherName,
      schoolName: id ?? this.schoolName,
      schoolPlace: id ?? this.schoolPlace,
      studentIMage: id ?? this.studentIMage,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'whichExam': whichExam,
      'publishDate': publishDate,
      'studentName': studentName,
      'rollNo': rollNo,
      'wClass': wClass,
      'teacherName': teacherName,
      'schoolName': schoolName,
      'schoolPlace': schoolPlace,
      'studentIMage': studentIMage,
      'reports': reports.map((x) => x.toMap()).toList(),
    };
  }

  factory UploadProgressReportModel.fromMap(Map<String, dynamic> map) {
    return UploadProgressReportModel(
      id: map['id'] as String,
      whichExam: map['whichExam'] as String,
      publishDate: map['publishDate'] as String,
      studentName: map['studentName'] as String,
      rollNo: map['rollNo'] as String,
      wClass: map['wClass'] as String,
      teacherName: map['teacherName'] as String,
      schoolName: map['schoolName'] as String,
      schoolPlace: map['schoolPlace'] as String,
      studentIMage: map['studentIMage'] as String,
      reports: List<ExamReports>.from(
        (map['reports'] as List<dynamic>).map<ExamReports>(
          (x) => ExamReports.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory UploadProgressReportModel.fromJson(String source) =>
      UploadProgressReportModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UploadProgressReportModel(id: $id,studentIMage: $studentIMage, whichExam: $whichExam, publishDate: $publishDate, studentName: $studentName, rollNo: $rollNo, wClass: $wClass, teacherName: $teacherName,schoolName: $schoolName,schoolPlace: $schoolPlace, reports: $reports)';
  }

  @override
  bool operator ==(covariant UploadProgressReportModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.whichExam == whichExam &&
        other.publishDate == publishDate &&
        other.studentName == studentName &&
        other.rollNo == rollNo &&
        other.wClass == wClass &&
        other.teacherName == teacherName &&
        other.schoolName == schoolName &&
        other.schoolPlace == schoolPlace &&
        other.studentIMage == studentIMage &&
        listEquals(other.reports, reports);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        whichExam.hashCode ^
        publishDate.hashCode ^
        studentName.hashCode ^
        rollNo.hashCode ^
        wClass.hashCode ^
        teacherName.hashCode ^
        schoolName.hashCode ^
        schoolPlace.hashCode ^
        studentIMage.hashCode ^
        reports.hashCode;
  }
}

class ExamReports {
  String subject;
  double obtainedMark;
  double totalMark;
  ExamReports({
    required this.subject,
    required this.obtainedMark,
    required this.totalMark,
  });

  ExamReports copyWith({
    String? subject,
    double? obtainedMark,
    double? totalMark,
  }) {
    return ExamReports(
      subject: subject ?? this.subject,
      obtainedMark: obtainedMark ?? this.obtainedMark,
      totalMark: totalMark ?? this.totalMark,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'subject': subject,
      'obtainedMark': obtainedMark,
      'totalMark': totalMark,
    };
  }

  factory ExamReports.fromMap(Map<String, dynamic> map) {
    return ExamReports(
      subject: map['subject'] as String,
      obtainedMark: map['obtainedMark'] as double,
      totalMark: map['totalMark'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory ExamReports.fromJson(String source) =>
      ExamReports.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ExamReports(subject: $subject, obtainedMark: $obtainedMark, totalMark: $totalMark)';

  @override
  bool operator ==(covariant ExamReports other) {
    if (identical(this, other)) return true;

    return other.subject == subject &&
        other.obtainedMark == obtainedMark &&
        other.totalMark == totalMark;
  }

  @override
  int get hashCode =>
      subject.hashCode ^ obtainedMark.hashCode ^ totalMark.hashCode;
}

class AddProgressReportStatusToFireBase {
  Future addAProgressReportController(UploadProgressReportModel productModel,
      context, schoolid, classId, studentID, examID, batchId) async {
    try {
      final firebase = FirebaseFirestore.instance;
      firebase
          .collection("SchoolListCollection")
          .doc(schoolid)
          .collection(batchId)
          .doc(batchId)
          .collection("classes")
          .doc(classId)
          .collection("Students")
          .doc(studentID)
          .collection("StudentProgressReport")
          .doc(examID)
          .set(productModel.toMap());
    } on FirebaseException catch (e) {
      print('Error ${e.message.toString()}');
    }
  }
}
