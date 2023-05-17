// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ClassWiseSubjectTeacherList {
  String docid;
  String subjectName;
  String teacherId;
  String teacherName;
  ClassWiseSubjectTeacherList({
    required this.docid,
    required this.subjectName,
    required this.teacherId,
    required this.teacherName,
  });

  ClassWiseSubjectTeacherList copyWith({
    String? docid,
    String? subjectName,
    String? teacherId,
    String? teacherName,
  }) {
    return ClassWiseSubjectTeacherList(
      docid: docid ?? this.docid,
      subjectName: subjectName ?? this.subjectName,
      teacherId: teacherId ?? this.teacherId,
      teacherName: teacherName ?? this.teacherName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'docid': docid,
      'subjectName': subjectName,
      'teacherId': teacherId,
      'teacherName': teacherName,
    };
  }

  factory ClassWiseSubjectTeacherList.fromMap(Map<String, dynamic> map) {
    return ClassWiseSubjectTeacherList(
      docid: map['docid'] as String,
      subjectName: map['subjectName'] as String,
      teacherId: map['teacherId'] as String,
      teacherName: map['teacherName'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ClassWiseSubjectTeacherList.fromJson(String source) =>
      ClassWiseSubjectTeacherList.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ClassWiseSubjectTeacherList(docid: $docid, subjectName: $subjectName, teacherId: $teacherId, teacherName: $teacherName)';
  }

  @override
  bool operator ==(covariant ClassWiseSubjectTeacherList other) {
    if (identical(this, other)) return true;

    return other.docid == docid &&
        other.subjectName == subjectName &&
        other.teacherId == teacherId &&
        other.teacherName == teacherName;
  }

  @override
  int get hashCode {
    return docid.hashCode ^
        subjectName.hashCode ^
        teacherId.hashCode ^
        teacherName.hashCode;
  }
}
