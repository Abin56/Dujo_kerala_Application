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
  String parentImage;
  String parentName;
  String parentPhoneNumber;
  String pincode;
  String place;
  String profileImageId;
  String profileImageUrl;
  String state;
  String uid;
  String userRole;
  String wStudent;

  ParentModel({
    required this.createdate,
    required this.docid,
    required this.gender,
    required this.houseName,
    required this.parentEmail,
    required this.parentImage,
    required this.parentName,
    required this.parentPhoneNumber,
    required this.pincode,
    required this.place,
    required this.profileImageId,
    required this.profileImageUrl,
    required this.state,
    required this.uid,
    required this.userRole,
    required this.wStudent,
  });

  factory ParentModel.fromJson(Map<String, dynamic> json) => ParentModel(
        createdate: json["createdate"],
        docid: json["docid"],
        gender: json["gender"],
        houseName: json["houseName"],
        parentEmail: json["parentEmail"],
        parentImage: json["parentImage"],
        parentName: json["parentName"],
        parentPhoneNumber: json["parentPhoneNumber"],
        pincode: json["pincode"],
        place: json["place"],
        profileImageId: json["profileImageID"],
        profileImageUrl: json["profileImageURL"],
        state: json["state"],
        uid: json["uid"],
        userRole: json["userRole"],
        wStudent: json["wStudent"],
      );

  Map<String, dynamic> toJson() => {
        "createdate": createdate,
        "docid": docid,
        "gender": gender,
        "houseName": houseName,
        "parentEmail": parentEmail,
        "parentImage": parentImage,
        "parentName": parentName,
        "parentPhoneNumber": parentPhoneNumber,
        "pincode": pincode,
        "place": place,
        "profileImageID": profileImageId,
        "profileImageURL": profileImageUrl,
        "state": state,
        "uid": uid,
        "userRole": userRole,
        "wStudent": wStudent,
      };
}
