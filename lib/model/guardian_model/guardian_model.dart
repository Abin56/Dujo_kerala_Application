// To parse this JSON data, do
//
//     final guardiantModel = guardiantModelFromJson(jsonString);

import 'dart:convert';

GuardianModel guardiantModelFromJson(String str) =>
    GuardianModel.fromJson(json.decode(str));

String guardiantModelToJson(GuardianModel data) => json.encode(data.toJson());

class GuardianModel {
  String createdate;
  String docid;
  String gender;
  String houseName;
  String guardiantEmail;
  String guardiantName;
  String guardiantPhoneNumber;
  String pincode;
  String place;
  String profileImageId;
  String profileImageUrl;
  String state;
  String studentId;
  String uid;
  String userRole;

  GuardianModel({
    required this.createdate,
    required this.docid,
    required this.gender,
    required this.houseName,
    required this.guardiantEmail,
    required this.guardiantName,
    required this.guardiantPhoneNumber,
    required this.pincode,
    required this.place,
    required this.profileImageId,
    required this.profileImageUrl,
    required this.state,
    required this.studentId,
    required this.uid,
    required this.userRole,
  });

  GuardianModel copyWith({
    String? createdate,
    String? docid,
    String? gender,
    String? houseName,
    String? guardiantEmail,
    String? guardiantName,
    String? guardiantPhoneNumber,
    String? pincode,
    String? place,
    String? profileImageId,
    String? profileImageUrl,
    String? state,
    String? studentId,
    String? uid,
    String? userRole,
  }) =>
      GuardianModel(
        createdate: createdate ?? this.createdate,
        docid: docid ?? this.docid,
        gender: gender ?? this.gender,
        houseName: houseName ?? this.houseName,
        guardiantEmail: guardiantEmail ?? this.guardiantEmail,
        guardiantName: guardiantName ?? this.guardiantName,
        guardiantPhoneNumber: guardiantPhoneNumber ?? this.guardiantPhoneNumber,
        pincode: pincode ?? this.pincode,
        place: place ?? this.place,
        profileImageId: profileImageId ?? this.profileImageId,
        profileImageUrl: profileImageUrl ?? this.profileImageUrl,
        state: state ?? this.state,
        studentId: studentId ?? this.studentId,
        uid: uid ?? this.uid,
        userRole: userRole ?? this.userRole,
      );

  factory GuardianModel.fromJson(Map<String, dynamic> json) => GuardianModel(
        createdate: json["createdate"] ?? "",
        docid: json["docid"] ?? "",
        gender: json["gender"] ?? "",
        houseName: json["houseName"] ?? "",
        guardiantEmail: json["guardiantEmail"] ?? "",
        guardiantName: json["guardiantName"] ?? "",
        guardiantPhoneNumber: json["guardiantPhoneNumber"] ?? "",
        pincode: json["pincode"] ?? "",
        place: json["place"] ?? "",
        profileImageId: json["profileImageID"] ?? "",
        profileImageUrl: json["profileImageURL"] ?? "",
        state: json["state"] ?? "",
        studentId: json["studentID"] ?? "",
        uid: json["uid"] ?? "",
        userRole: json["userRole"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "createdate": createdate,
        "docid": docid,
        "gender": gender,
        "houseName": houseName,
        "guardiantEmail": guardiantEmail,
        "guardiantName": guardiantName,
        "guardiantPhoneNumber": guardiantPhoneNumber,
        "pincode": pincode,
        "place": place,
        "profileImageID": profileImageId,
        "profileImageURL": profileImageUrl,
        "state": state,
        "studentID": studentId,
        "uid": uid,
        "userRole": userRole,
      };
}
