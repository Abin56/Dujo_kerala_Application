// To parse this JSON data, do
//
//     final TeacherModel = TeacherModelFromJson(jsonString);

import 'dart:convert';

TeacherModel TeacherModelFromJson(String str) =>
    TeacherModel.fromJson(json.decode(str));

String TeacherModelToJson(TeacherModel data) => json.encode(data.toJson());

class TeacherModel {
  TeacherModel(
      {required this.teacherName,
      required this.teacherEmail,
      required this.houseName,
      required this.houseNumber,
      required this.place, 
      required this.gender, 
      required this.district, 
      required this.altPhoneNo
      });

String teacherName; 
String teacherEmail; 
String houseName; 
String houseNumber;
String place;
String gender; 
String district; 
String altPhoneNo; 


  factory TeacherModel.fromJson(Map<String, dynamic> json) => TeacherModel(
      teacherName: json["teacherName"] ?? "",
      teacherEmail: json["teacherEmail"] ?? "",
      houseName: json["houseName"] ?? "",
      houseNumber: json["houseNumber"] ?? "",
      place: json["place"] ?? "", 
      gender: json["gender"]?? "",
      district: json["district"] ?? "", 
      altPhoneNo: json["altPhoneNo"]?? ""
      );

  Map<String, dynamic> toJson() => {
        "teacherName": teacherName,
        "teacherEmail": teacherEmail,
        "houseName": houseName,
        "houseNumber": houseNumber,
        "place": place, 
        "gender": gender, 
        "district": district, 
        "altPhoneNo": altPhoneNo 
      };
}

