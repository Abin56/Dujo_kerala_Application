// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ClassLevelNoticeModel {
  String content;
  String date;
  String docid;
  String heading;
  String signedBy;
  String topic;
  ClassLevelNoticeModel({
    required this.content,
    required this.date,
    required this.docid,
    required this.heading,
    required this.signedBy,
    required this.topic,
  });

  ClassLevelNoticeModel copyWith({
    String? content,
    String? date,
    String? docid,
    String? heading,
    String? signedBy,
    String? topic,
  }) {
    return ClassLevelNoticeModel(
      content: content ?? this.content,
      date: date ?? this.date,
      docid: docid ?? this.docid,
      heading: heading ?? this.heading,
      signedBy: signedBy ?? this.signedBy,
      topic: topic ?? this.topic,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'content': content,
      'date': date,
      'docid': docid,
      'heading': heading,
      'signedBy': signedBy,
      'topic': topic,
    };
  }

  factory ClassLevelNoticeModel.fromMap(Map<String, dynamic> map) {
    return ClassLevelNoticeModel(
      content: map['content'] ?? "",
      date: map['date'] ?? "",
      docid: map['docid'] ?? "",
      heading: map['heading'] ?? "",
      signedBy: map['signedBy'] ?? "",
      topic: map['topic'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory ClassLevelNoticeModel.fromJson(String source) =>
      ClassLevelNoticeModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ClassLevelNoticeModel(content: $content, date: $date, docid: $docid, heading: $heading, signedBy: $signedBy, topic: $topic)';
  }

  @override
  bool operator ==(covariant ClassLevelNoticeModel other) {
    if (identical(this, other)) return true;

    return other.content == content &&
        other.date == date &&
        other.docid == docid &&
        other.heading == heading &&
        other.signedBy == signedBy &&
        other.topic == topic;
  }

  @override
  int get hashCode {
    return content.hashCode ^
        date.hashCode ^
        docid.hashCode ^
        heading.hashCode ^
        signedBy.hashCode ^
        topic.hashCode;
  }
}
