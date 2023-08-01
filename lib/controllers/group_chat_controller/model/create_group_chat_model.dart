// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CreateGroupChatModel {
String docid;
bool admin;
String groupName;
String teacherId;  
  CreateGroupChatModel({
    required this.docid,
    required this.admin,
    required this.groupName,
    required this.teacherId,
  });

  CreateGroupChatModel copyWith({
    String? docid,
    bool? admin,
    String? groupName,
    String? teacherId,
  }) {
    return CreateGroupChatModel(
      docid: docid ?? this.docid,
      admin: admin ?? this.admin,
      groupName: groupName ?? this.groupName,
      teacherId: teacherId ?? this.teacherId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'docid': docid,
      'admin': admin,
      'groupName': groupName,
      'teacherId': teacherId,
    };
  }

  factory CreateGroupChatModel.fromMap(Map<String, dynamic> map) {
    return CreateGroupChatModel(
      docid: map['docid'] as String,
      admin: map['admin'] as bool,
      groupName: map['groupName'] as String,
      teacherId: map['teacherId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CreateGroupChatModel.fromJson(String source) => CreateGroupChatModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CreateGroupChatModel(docid: $docid, admin: $admin, groupName: $groupName, teacherId: $teacherId)';
  }

  @override
  bool operator ==(covariant CreateGroupChatModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.docid == docid &&
      other.admin == admin &&
      other.groupName == groupName &&
      other.teacherId == teacherId;
  }

  @override
  int get hashCode {
    return docid.hashCode ^
      admin.hashCode ^
      groupName.hashCode ^
      teacherId.hashCode;
  }
}
