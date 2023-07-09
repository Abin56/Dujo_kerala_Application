// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AttendanceStudentModel {
  String Date;
  bool present;
  String studentName;
  String uid;
  AttendanceStudentModel({
    required this.Date,
    required this.present,
    required this.studentName,
    required this.uid,
  });
  

  AttendanceStudentModel copyWith({
    String? Date,
    bool? present,
    String? studentName,
    String? uid,
  }) {
    return AttendanceStudentModel(
      Date: Date ?? this.Date,
      present: present ?? this.present,
      studentName: studentName ?? this.studentName,
      uid: uid ?? this.uid,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Date': Date,
      'present': present,
      'studentName': studentName,
      'uid': uid,
    };
  }

  factory AttendanceStudentModel.fromMap(Map<String, dynamic> map) {
    return AttendanceStudentModel(
      Date: map['Date'] as String,
      present: map['present'] as bool,
      studentName: map['studentName'] as String,
      uid: map['uid'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AttendanceStudentModel.fromJson(String source) => AttendanceStudentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AttendanceStudentModel(Date: $Date, present: $present, studentName: $studentName, uid: $uid)';
  }

  @override
  bool operator ==(covariant AttendanceStudentModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.Date == Date &&
      other.present == present &&
      other.studentName == studentName &&
      other.uid == uid;
  }

  @override
  int get hashCode {
    return Date.hashCode ^
      present.hashCode ^
      studentName.hashCode ^
      uid.hashCode;
  }
}
