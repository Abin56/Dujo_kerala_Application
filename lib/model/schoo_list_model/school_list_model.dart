// To parse this JSON data, do
//
//     final schoolModel = schoolModelFromJson(jsonString);

import 'dart:convert';

SchoolModel schoolModelFromJson(String str) =>
    SchoolModel.fromJson(json.decode(str));

String schoolModelToJson(SchoolModel data) => json.encode(data.toJson());

class SchoolModel {
  SchoolModel({
    required this.adminUserName,
    required this.batchYear,
    required this.district,
    required this.email,
    required this.id,
    required this.password,
    required this.phoneNumber,
    required this.place,
    required this.postedDate,
    required this.schoolId,
    required this.schoolName,
  });

  String adminUserName;
  String batchYear;
  String district;
  String email;
  String id;
  String password;
  String phoneNumber;
  String place;
  String postedDate;
  String schoolId;
  String schoolName;

  factory SchoolModel.fromJson(Map<String, dynamic> json) => SchoolModel(
        adminUserName: json["adminUserName"],
        batchYear: json["batchYear"],
        district: json["district"],
        email: json["email"],
        id: json["id"],
        password: json["password"],
        phoneNumber: json["phoneNumber"],
        place: json["place"],
        postedDate: json["postedDate"],
        schoolId: json["schoolID"],
        schoolName: json["schoolName"],
      );

  Map<String, dynamic> toJson() => {
        "adminUserName": adminUserName,
        "batchYear": batchYear,
        "district": district,
        "email": email,
        "id": id,
        "password": password,
        "phoneNumber": phoneNumber,
        "place": place,
        "postedDate": postedDate,
        "schoolID": schoolId,
        "schoolName": schoolName,
      };
}
