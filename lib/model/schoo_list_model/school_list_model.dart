// To parse this JSON data, do
//
//     final schoolModel = schoolModelFromJson(jsonString);

import 'dart:convert';

SchoolModel schoolModelFromJson(String str) =>
    SchoolModel.fromJson(json.decode(str));

String schoolModelToJson(SchoolModel data) => json.encode(data.toJson());

class SchoolModel {
  SchoolModel(
      {required this.adminUserName,
      required this.batchYear,
      required this.district,
      required this.email,
      required this.password,
      required this.phoneNumber,
      required this.place,
      required this.postedDate,
      required this.schoolName,
      required this.docid,
      required this.schoolCode,
      required this.verified});

  String adminUserName;
  String batchYear;
  String district;
  String docid;
  String email;
  String password;
  String phoneNumber;
  String place;
  String postedDate;
  String schoolCode;
  String schoolName;
  bool verified;

  factory SchoolModel.fromJson(Map<String, dynamic> json) => SchoolModel(
      adminUserName: json["adminUserName"] ?? "",
      batchYear: json["batchYear"] ?? "",
      district: json["district"] ?? "",
      email: json["email"] ?? "",
      password: json["password"] ?? "",
      phoneNumber: json["phoneNumber"] ?? "",
      place: json["place"] ?? "",
      postedDate: json["postedDate"] ?? "",
      schoolName: json["schoolName"] ?? "",
      docid: json["docid"] ?? "",
      schoolCode: json["schoolCode"] ?? "",
      verified: json["verified"] ?? false);

  Map<String, dynamic> toJson() => {
        "adminUserName": adminUserName,
        "batchYear": batchYear,
        "district": district,
        "email": email,
        "password": password,
        "phoneNumber": phoneNumber,
        "place": place,
        "postedDate": postedDate,
        "schoolName": schoolName,
        "docid": docid,
        "schoolCode": schoolCode,
        "verified": verified
      };
}
