// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class HostelModelComplaint {
  String docId;
  String title;
  String studentId;
  String classId;
  int date;
  String description;
  bool isCompleted;
  HostelModelComplaint({
    required this.docId,
    required this.title,
    required this.studentId,
    required this.classId,
    required this.date,
    required this.description,
    required this.isCompleted,
  });

  HostelModelComplaint copyWith({
    String? docId,
    String? title,
    String? studentId,
    String? classId,
    int? date,
    String? description,
    bool? isCompleted,
  }) {
    return HostelModelComplaint(
      docId: docId ?? this.docId,
      title: title ?? this.title,
      studentId: studentId ?? this.studentId,
      classId: classId ?? this.classId,
      date: date ?? this.date,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'docId': docId,
      'title': title,
      'studentId': studentId,
      'classId': classId,
      'date': date,
      'description': description,
      'isCompleted': isCompleted,
    };
  }

  factory HostelModelComplaint.fromMap(Map<String, dynamic> map) {
    return HostelModelComplaint(
      docId: map['docId'] as String,
      title: map['title'] as String,
      studentId: map['studentId'] as String,
      classId: map['classId'] as String,
      date: map['date'] as int,
      description: map['description'] as String,
      isCompleted: map['isCompleted'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory HostelModelComplaint.fromJson(String source) =>
      HostelModelComplaint.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'HostelModelComplaint(docId: $docId, title: $title, studentId: $studentId, classId: $classId, date: $date, description: $description, isCompleted: $isCompleted)';
  }

  @override
  bool operator ==(covariant HostelModelComplaint other) {
    if (identical(this, other)) return true;

    return other.docId == docId &&
        other.title == title &&
        other.studentId == studentId &&
        other.classId == classId &&
        other.date == date &&
        other.description == description &&
        other.isCompleted == isCompleted;
  }

  @override
  int get hashCode {
    return docId.hashCode ^
        title.hashCode ^
        studentId.hashCode ^
        classId.hashCode ^
        date.hashCode ^
        description.hashCode ^
        isCompleted.hashCode;
  }
}
