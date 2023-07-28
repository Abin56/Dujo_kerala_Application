// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class ClassTestModel {
  String docId;
  String testName;
  String subjectName;
  String description;
  int date;
  String time;
  int createdTime;
  String teacherId;
  String classId;
  String subjectId;
  num totalMark;
  List<StudentClassMarkModel> studentDetails;
  ClassTestModel({
    required this.docId,
    required this.testName,
    required this.subjectName,
    required this.description,
    required this.date,
    required this.time,
    required this.createdTime,
    required this.teacherId,
    required this.classId,
    required this.subjectId,
    required this.totalMark,
    required this.studentDetails,
  });

  ClassTestModel copyWith({
    String? docId,
    String? testName,
    String? subjectName,
    String? description,
    int? date,
    String? time,
    int? createdTime,
    String? teacherId,
    String? classId,
    String? subjectId,
    num? totalMark,
    List<StudentClassMarkModel>? studentDetails,
  }) {
    return ClassTestModel(
      docId: docId ?? this.docId,
      testName: testName ?? this.testName,
      subjectName: subjectName ?? this.subjectName,
      description: description ?? this.description,
      date: date ?? this.date,
      time: time ?? this.time,
      createdTime: createdTime ?? this.createdTime,
      teacherId: teacherId ?? this.teacherId,
      classId: classId ?? this.classId,
      subjectId: subjectId ?? this.subjectId,
      totalMark: totalMark ?? this.totalMark,
      studentDetails: studentDetails ?? this.studentDetails,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'docId': docId,
      'testName': testName,
      'subjectName': subjectName,
      'description': description,
      'date': date,
      'time': time,
      'createdTime': createdTime,
      'teacherId': teacherId,
      'classId': classId,
      'subjectId': subjectId,
      'totalMark': totalMark,
      'studentDetails': studentDetails.map((x) => x.toMap()).toList(),
    };
  }

  factory ClassTestModel.fromMap(Map<String, dynamic> map) {
    return ClassTestModel(
      docId: map['docId'] as String,
      testName: map['testName'] as String,
      subjectName: map['subjectName'] as String,
      description: map['description'] as String,
      date: map['date'] as int,
      time: map['time'] as String,
      createdTime: map['createdTime'] as int,
      teacherId: map['teacherId'] as String,
      classId: map['classId'] as String,
      subjectId: map['subjectId'] as String,
      totalMark: map['totalMark'] as num,
      studentDetails: List<StudentClassMarkModel>.from(
        (map['studentDetails'] as List<dynamic>).map<StudentClassMarkModel>(
          (x) => StudentClassMarkModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ClassTestModel.fromJson(String source) =>
      ClassTestModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ClassTestModel(docId: $docId, testName: $testName, subjectName: $subjectName, description: $description, date: $date, time: $time, createdTime: $createdTime, teacherId: $teacherId, classId: $classId, subjectId: $subjectId, totalMark: $totalMark, studentDetails: $studentDetails)';
  }

  @override
  bool operator ==(covariant ClassTestModel other) {
    if (identical(this, other)) return true;

    return other.docId == docId &&
        other.testName == testName &&
        other.subjectName == subjectName &&
        other.description == description &&
        other.date == date &&
        other.time == time &&
        other.createdTime == createdTime &&
        other.teacherId == teacherId &&
        other.classId == classId &&
        other.subjectId == subjectId &&
        other.totalMark == totalMark &&
        listEquals(other.studentDetails, studentDetails);
  }

  @override
  int get hashCode {
    return docId.hashCode ^
        testName.hashCode ^
        subjectName.hashCode ^
        description.hashCode ^
        date.hashCode ^
        time.hashCode ^
        createdTime.hashCode ^
        teacherId.hashCode ^
        classId.hashCode ^
        subjectId.hashCode ^
        totalMark.hashCode ^
        studentDetails.hashCode;
  }
}

class StudentClassMarkModel {
  String studentId;
  num mark;

  StudentClassMarkModel({
    required this.studentId,
    required this.mark,
  });

  StudentClassMarkModel copyWith({
    String? studentId,
    num? mark,
  }) {
    return StudentClassMarkModel(
      studentId: studentId ?? this.studentId,
      mark: mark ?? this.mark,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'studentId': studentId,
      'mark': mark,
    };
  }

  factory StudentClassMarkModel.fromMap(Map<String, dynamic> map) {
    return StudentClassMarkModel(
      studentId: map['studentId'] as String,
      mark: map['mark'] as num,
    );
  }

  String toJson() => json.encode(toMap());

  factory StudentClassMarkModel.fromJson(String source) =>
      StudentClassMarkModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'StudentClassMarkModel(studentId: $studentId, mark: $mark)';

  @override
  bool operator ==(covariant StudentClassMarkModel other) {
    if (identical(this, other)) return true;

    return other.studentId == studentId && other.mark == mark;
  }

  @override
  int get hashCode => studentId.hashCode ^ mark.hashCode;
}
