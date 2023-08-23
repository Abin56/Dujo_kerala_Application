// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class HostelModelComplaint {
  String docId;
  String title;
  String description;
  String actionsTaken;
  String studentId;
  String classId;
  bool isAdminUpdated;
  int date;
  String status;
  HostelModelComplaint({
    required this.docId,
    required this.title,
    required this.description,
    required this.actionsTaken,
    required this.studentId,
    required this.classId,
    required this.isAdminUpdated,
    required this.date,
    required this.status,
  });

  HostelModelComplaint copyWith({
    String? docId,
    String? title,
    String? description,
    String? actionsTaken,
    String? studentId,
    String? classId,
    bool? isAdminUpdated,
    int? date,
    String? status,
  }) {
    return HostelModelComplaint(
      docId: docId ?? this.docId,
      title: title ?? this.title,
      description: description ?? this.description,
      actionsTaken: actionsTaken ?? this.actionsTaken,
      studentId: studentId ?? this.studentId,
      classId: classId ?? this.classId,
      isAdminUpdated: isAdminUpdated ?? this.isAdminUpdated,
      date: date ?? this.date,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'docId': docId,
      'title': title,
      'description': description,
      'actionsTaken': actionsTaken,
      'studentId': studentId,
      'classId': classId,
      'isAdminUpdated': isAdminUpdated,
      'date': date,
      'status': status,
    };
  }

  factory HostelModelComplaint.fromMap(Map<String, dynamic> map) {
    return HostelModelComplaint(
      docId: map['docId'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      actionsTaken: map['actionsTaken'] as String,
      studentId: map['studentId'] as String,
      classId: map['classId'] as String,
      isAdminUpdated: map['isAdminUpdated'] as bool,
      date: map['date'] as int,
      status: map['status'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory HostelModelComplaint.fromJson(String source) =>
      HostelModelComplaint.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'HostelModelComplaint(docId: $docId, title: $title, description: $description, actionsTaken: $actionsTaken, studentId: $studentId, classId: $classId, isAdminUpdated: $isAdminUpdated, date: $date, status: $status)';
  }

  @override
  bool operator ==(covariant HostelModelComplaint other) {
    if (identical(this, other)) return true;

    return other.docId == docId &&
        other.title == title &&
        other.description == description &&
        other.actionsTaken == actionsTaken &&
        other.studentId == studentId &&
        other.classId == classId &&
        other.isAdminUpdated == isAdminUpdated &&
        other.date == date &&
        other.status == status;
  }

  @override
  int get hashCode {
    return docId.hashCode ^
        title.hashCode ^
        description.hashCode ^
        actionsTaken.hashCode ^
        studentId.hashCode ^
        classId.hashCode ^
        isAdminUpdated.hashCode ^
        date.hashCode ^
        status.hashCode;
  }
}
