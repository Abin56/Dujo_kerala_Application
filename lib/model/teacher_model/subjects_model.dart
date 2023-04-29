// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class SubjectModel {
  String subjectName;
  String docid;
 String date;
  SubjectModel({
    required this.subjectName,
    required this.docid,
    required this.date,
  });

  SubjectModel copyWith({
    String? subjectName,
    String? docid,
    String? date,
  }) {
    return SubjectModel(
      subjectName: subjectName ?? this.subjectName,
      docid: docid ?? this.docid,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'subjectName': subjectName,
      'docid': docid,
      'date': date,
    };
  }

  factory SubjectModel.fromMap(Map<String, dynamic> map) {
    return SubjectModel(
      subjectName: map['subjectName'] as String,
      docid: map['docid'] as String,
      date: map['date'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SubjectModel.fromJson(String source) => SubjectModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'SubjectModel(subjectName: $subjectName, docid: $docid, date: $date)';

  @override
  bool operator ==(covariant SubjectModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.subjectName == subjectName &&
      other.docid == docid &&
      other.date == date;
  }

  @override
  int get hashCode => subjectName.hashCode ^ docid.hashCode ^ date.hashCode;
}


