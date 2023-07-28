// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class OnlineChatModel {
  bool? admin;
  bool? block;
  int messageindex;
  String chatid;
  String docid;
  String sendTime;
  String message;
  OnlineChatModel({
    this.admin,
    this.block,
    required this.messageindex,
    required this.chatid,
    required this.docid,
    required this.sendTime,
    required this.message,
  });

  OnlineChatModel copyWith({
    bool? admin,
    bool? block,
    int? messageindex,
    String? chatid,
    String? docid,
    String? sendTime,
    String? message,
  }) {
    return OnlineChatModel(
      admin: admin ?? this.admin,
      block: block ?? this.block,
      messageindex: messageindex ?? this.messageindex,
      chatid: chatid ?? this.chatid,
      docid: docid ?? this.docid,
      sendTime: sendTime ?? this.sendTime,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'admin': admin,
      'block': block,
      'messageindex': messageindex,
      'chatid': chatid,
      'docid': docid,
      'sendTime': sendTime,
      'message': message,
    };
  }

  factory OnlineChatModel.fromMap(Map<String, dynamic> map) {
    return OnlineChatModel(
      admin: map['admin'] != null ? map['admin'] as bool : null,
      block: map['block'] != null ? map['block'] as bool : null,
      messageindex: map['messageindex'] as int,
      chatid: map['chatid'] as String,
      docid: map['docid'] as String,
      sendTime: map['sendTime'] as String,
      message: map['message'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory OnlineChatModel.fromJson(String source) => OnlineChatModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OnlineChatModel(admin: $admin, block: $block, messageindex: $messageindex, chatid: $chatid, docid: $docid, sendTime: $sendTime, message: $message)';
  }

  @override
  bool operator ==(covariant OnlineChatModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.admin == admin &&
      other.block == block &&
      other.messageindex == messageindex &&
      other.chatid == chatid &&
      other.docid == docid &&
      other.sendTime == sendTime &&
      other.message == message;
  }

  @override
  int get hashCode {
    return admin.hashCode ^
      block.hashCode ^
      messageindex.hashCode ^
      chatid.hashCode ^
      docid.hashCode ^
      sendTime.hashCode ^
      message.hashCode;
  }
}
