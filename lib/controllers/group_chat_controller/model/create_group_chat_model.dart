// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CreateGroupChatModel {
  bool activate;
  String docid;
  bool admin;
  String groupName;
  String teacherId;
  CreateGroupChatModel({
    required this.activate,
    required this.docid,
    required this.admin,
    required this.groupName,
    required this.teacherId,
  });

  CreateGroupChatModel copyWith({
    bool? activate,
    String? docid,
    bool? admin,
    String? groupName,
    String? teacherId,
  }) {
    return CreateGroupChatModel(
      activate: activate ?? this.activate,
      docid: docid ?? this.docid,
      admin: admin ?? this.admin,
      groupName: groupName ?? this.groupName,
      teacherId: teacherId ?? this.teacherId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'activate': activate,
      'docid': docid,
      'admin': admin,
      'groupName': groupName,
      'teacherId': teacherId,
    };
  }

  factory CreateGroupChatModel.fromMap(Map<String, dynamic> map) {
    return CreateGroupChatModel(
      activate: map['activate'] as bool,
      docid: map['docid'] as String,
      admin: map['admin'] as bool,
      groupName: map['groupName'] as String,
      teacherId: map['teacherId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CreateGroupChatModel.fromJson(String source) =>
      CreateGroupChatModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CreateGroupChatModel(activate: $activate, docid: $docid, admin: $admin, groupName: $groupName, teacherId: $teacherId)';
  }

  @override
  bool operator ==(covariant CreateGroupChatModel other) {
    if (identical(this, other)) return true;

    return other.activate == activate &&
        other.docid == docid &&
        other.admin == admin &&
        other.groupName == groupName &&
        other.teacherId == teacherId;
  }

  @override
  int get hashCode {
    return activate.hashCode ^
        docid.hashCode ^
        admin.hashCode ^
        groupName.hashCode ^
        teacherId.hashCode;
  }
}
