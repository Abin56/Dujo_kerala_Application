// To parse this JSON data, do
//
//     final studentModel = studentModelFromJson(jsonString);

import 'dart:convert';

StudentModel studentModelFromJson(String str) =>
    StudentModel.fromJson(json.decode(str));

String studentModelToJson(StudentModel data) => json.encode(data.toJson());

class StudentModel {
  StudentModel(
      {required this.admissionNumber,
      required this.alPhoneNumber,
      required this.bloodgroup,
      required this.createDate,
      required this.dateofBirth,
      required this.district,
      required this.gender,
      required this.houseName,
      required this.parentPhoneNumber,
      required this.place,
      required this.profileImageId,
      required this.profileImageUrl,
      required this.studentName,
      required this.studentemail,
      required this.uid,
      required this.whichClass,
      required this.docid});

  String admissionNumber;
  String alPhoneNumber;
  String bloodgroup;
  String createDate;
  String dateofBirth;
  String district;
  String gender;
  String houseName;
  String parentPhoneNumber;
  String place;
  String profileImageId;
  String profileImageUrl;
  String studentName;
  String studentemail;
  String uid;
  String whichClass;
  String docid;

  factory StudentModel.fromJson(Map<String, dynamic> json) => StudentModel(
      admissionNumber: json["admissionNumber"] ?? "",
      alPhoneNumber: json["alPhoneNumber"] ?? "",
      bloodgroup: json["bloodgroup"] ?? "",
      createDate: json["createDate"] ?? "",
      dateofBirth: json["dateofBirth"] ?? "",
      district: json["district"] ?? "",
      gender: json["gender"] ?? "",
      houseName: json["houseName"] ?? "",
      parentPhoneNumber: json["parentPhoneNumber"] ?? "",
      place: json["place"] ?? "",
      profileImageId: json["profileImageId"] ?? "",
      profileImageUrl: json["profileImageUrl"] ?? "",
      studentName: json["studentName"] ?? "",
      studentemail: json["studentemail"] ?? "",
      uid: json["uid"] ?? "",
      whichClass: json["whichClass"] ?? "",
      docid: json["docid"] ?? "");

  Map<String, dynamic> toJson() => {
        "admissionNumber": admissionNumber,
        "alPhoneNumber": alPhoneNumber,
        "bloodgroup": bloodgroup,
        "createDate": createDate,
        "dateofBirth": dateofBirth,
        "district": district,
        "gender": gender,
        "houseName": houseName,
        "parentPhoneNumber": parentPhoneNumber,
        "place": place,
        "profileImageId": profileImageId,
        "profileImageUrl": profileImageUrl,
        "studentName": studentName,
        "studentemail": studentemail,
        "uid": uid,
        "whichClass": whichClass,
        "docid": docid
      };
}
