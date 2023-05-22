// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AddExamTimeTableModel {

  String docid;
  String subject;
  dynamic startingtime;
  dynamic endingtime;
  dynamic hours;
  String examDate;
  String createDate;
  AddExamTimeTableModel({
    required this.docid,
    required this.subject,
    required this.startingtime,
    required this.endingtime,
    required this.hours,
    required this.examDate,
    required this.createDate,
  });


  AddExamTimeTableModel copyWith({
    String? docid,
    String? subject,
    dynamic? startingtime,
    dynamic? endingtime,
    dynamic? hours,
    String? examDate,
    String? createDate,
  }) {
    return AddExamTimeTableModel(
      docid: docid ?? this.docid,
      subject: subject ?? this.subject,
      startingtime: startingtime ?? this.startingtime,
      endingtime: endingtime ?? this.endingtime,
      hours: hours ?? this.hours,
      examDate: examDate ?? this.examDate,
      createDate: createDate ?? this.createDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'docid': docid,
      'subject': subject,
      'startingtime': startingtime,
      'endingtime': endingtime,
      'hours': hours,
      'examDate': examDate,
      'createDate': createDate,
    };
  }

  factory AddExamTimeTableModel.fromMap(Map<String, dynamic> map) {
    return AddExamTimeTableModel(
      docid: map['docid'] as String,
      subject: map['subject'] as String,
      startingtime: map['startingtime'] as dynamic,
      endingtime: map['endingtime'] as dynamic,
      hours: map['hours'] as dynamic,
      examDate: map['examDate'] as String,
      createDate: map['createDate'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddExamTimeTableModel.fromJson(String source) => AddExamTimeTableModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AddExamTimeTableModel(docid: $docid, subject: $subject, startingtime: $startingtime, endingtime: $endingtime, hours: $hours, examDate: $examDate, createDate: $createDate)';
  }

  @override
  bool operator ==(covariant AddExamTimeTableModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.docid == docid &&
      other.subject == subject &&
      other.startingtime == startingtime &&
      other.endingtime == endingtime &&
      other.hours == hours &&
      other.examDate == examDate &&
      other.createDate == createDate;
  }

  @override
  int get hashCode {
    return docid.hashCode ^
      subject.hashCode ^
      startingtime.hashCode ^
      endingtime.hashCode ^
      hours.hashCode ^
      examDate.hashCode ^
      createDate.hashCode;
  }
}
