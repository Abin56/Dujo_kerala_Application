// To parse this JSON data, do
//
//     final parentModel = parentModelFromJson(jsonString);

import 'dart:convert';

ParentModel parentModelFromJson(String str) =>
    ParentModel.fromJson(json.decode(str));

String parentModelToJson(ParentModel data) => json.encode(data.toJson());

class ParentModel {
  String createdate;
  String docid;
  String gender;
  String houseName;
  String parentEmail;
  String parentName;
  String parentPhoneNumber;
  String pincode;
  String place;
  String profileImageId;
  String profileImageUrl;
  String state;
  String studentId;
  String uid;
  String userRole;

  ParentModel({
    required this.createdate,
    required this.docid,
    required this.gender,
    required this.houseName,
    required this.parentEmail,
    required this.parentName,
    required this.parentPhoneNumber,
    required this.pincode,
    required this.place,
    required this.profileImageId,
    required this.profileImageUrl,
    required this.state,
    required this.studentId,
    required this.uid,
    required this.userRole,
  });

  ParentModel copyWith({
    String? createdate,
    String? docid,
    String? gender,
    String? houseName,
    String? parentEmail,
    String? parentName,
    String? parentPhoneNumber,
    String? pincode,
    String? place,
    String? profileImageId,
    String? profileImageUrl,
    String? state,
    String? studentId,
    String? uid,
    String? userRole,
  }) =>
      ParentModel(
        createdate: createdate ?? this.createdate,
        docid: docid ?? this.docid,
        gender: gender ?? this.gender,
        houseName: houseName ?? this.houseName,
        parentEmail: parentEmail ?? this.parentEmail,
        parentName: parentName ?? this.parentName,
        parentPhoneNumber: parentPhoneNumber ?? this.parentPhoneNumber,
        pincode: pincode ?? this.pincode,
        place: place ?? this.place,
        profileImageId: profileImageId ?? this.profileImageId,
        profileImageUrl: profileImageUrl ?? this.profileImageUrl,
        state: state ?? this.state,
        studentId: studentId ?? this.studentId,
        uid: uid ?? this.uid,
        userRole: userRole ?? this.userRole,
      );

  factory ParentModel.fromJson(Map<String, dynamic> json) => ParentModel(
        createdate: json["createdate"],
        docid: json["docid"],
        gender: json["gender"],
        houseName: json["houseName"],
        parentEmail: json["parentEmail"],
        parentName: json["parentName"],
        parentPhoneNumber: json["parentPhoneNumber"],
        pincode: json["pincode"],
        place: json["place"],
        profileImageId: json["profileImageID"],
        profileImageUrl: json["profileImageURL"],
        state: json["state"],
        studentId: json["studentID"],
        uid: json["uid"],
        userRole: json["userRole"],
      );

  Map<String, dynamic> toJson() => {
        "createdate": createdate,
        "docid": docid,
        "gender": gender,
        "houseName": houseName,
        "parentEmail": parentEmail,
        "parentName": parentName,
        "parentPhoneNumber": parentPhoneNumber,
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
