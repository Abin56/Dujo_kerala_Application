// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class HostelModel {
  String docId;
  String studentId;
  int date;
  String description;
  bool isCompleted;
  HostelModel({
    required this.docId,
    required this.studentId,
    required this.date,
    required this.description,
    required this.isCompleted,
  });

  HostelModel copyWith({
    String? docId,
    String? studentId,
    int? date,
    String? description,
    bool? isCompleted,
  }) {
    return HostelModel(
      docId: docId ?? this.docId,
      studentId: studentId ?? this.studentId,
      date: date ?? this.date,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'docId': docId,
      'studentId': studentId,
      'date': date,
      'description': description,
      'isCompleted': isCompleted,
    };
  }

  factory HostelModel.fromMap(Map<String, dynamic> map) {
    return HostelModel(
      docId: map['docId'] as String,
      studentId: map['studentId'] as String,
      date: map['date'] as int,
      description: map['description'] as String,
      isCompleted: map['isCompleted'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory HostelModel.fromJson(String source) =>
      HostelModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'HostelModel(docId: $docId, studentId: $studentId, date: $date, description: $description, isCompleted: $isCompleted)';
  }

  @override
  bool operator ==(covariant HostelModel other) {
    if (identical(this, other)) return true;

    return other.docId == docId &&
        other.studentId == studentId &&
        other.date == date &&
        other.description == description &&
        other.isCompleted == isCompleted;
  }

  @override
  int get hashCode {
    return docId.hashCode ^
        studentId.hashCode ^
        date.hashCode ^
        description.hashCode ^
        isCompleted.hashCode;
  }
}
