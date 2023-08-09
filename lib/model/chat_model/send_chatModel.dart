// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SendUserStatusModel {
bool? block;
String docid;
int messageindex;
String teacherName;
  SendUserStatusModel({
    this.block,
    required this.docid,
    required this.messageindex,
    required this.teacherName,
  });

  SendUserStatusModel copyWith({
    bool? block,
    String? docid,
    int? messageindex,
    String? teacherName,
  }) {
    return SendUserStatusModel(
      block: block ?? this.block,
      docid: docid ?? this.docid,
      messageindex: messageindex ?? this.messageindex,
      teacherName: teacherName ?? this.teacherName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'block': block,
      'docid': docid,
      'messageindex': messageindex,
      'teacherName': teacherName,
    };
  }

  factory SendUserStatusModel.fromMap(Map<String, dynamic> map) {
    return SendUserStatusModel(
      block: map['block'] != null ? map['block'] as bool :false ,
      docid: map['docid'] as String,
      messageindex: map['messageindex'] as int,
      teacherName: map['teacherName'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SendUserStatusModel.fromJson(String source) => SendUserStatusModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SendUserStatusModel(block: $block, docid: $docid, messageindex: $messageindex, teacherName: $teacherName)';
  }

  @override
  bool operator ==(covariant SendUserStatusModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.block == block &&
      other.docid == docid &&
      other.messageindex == messageindex &&
      other.teacherName == teacherName;
  }

  @override
  int get hashCode {
    return block.hashCode ^
      docid.hashCode ^
      messageindex.hashCode ^
      teacherName.hashCode;
  }
}
