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
      required this.altPhoneNo, 
      required this.employeeID, 
      required this.joinDate, 
      required this.teacherPhNo,
      required this.docid, 
      required this.userRole
      });

String teacherName; 
String teacherEmail; 
String houseName; 
String houseNumber;
String place;
String gender; 
String district; 
String altPhoneNo; 
String employeeID; 
String joinDate;
String teacherPhNo;
String docid;
String userRole;


  factory TeacherModel.fromJson(Map<String, dynamic> json) => TeacherModel(
      teacherName: json["teacherName"] ?? "",
      teacherEmail: json["teacherEmail"] ?? "",
      houseName: json["houseName"] ?? "",
      houseNumber: json["houseNumber"] ?? "",
      place: json["place"] ?? "", 
      gender: json["gender"]?? "",
      district: json["district"] ?? "", 
      altPhoneNo: json["altPhoneNo"]?? "", 
      employeeID:json["employeeID"]?? "",
      joinDate: json["joinDate"]?? "",
      teacherPhNo : json["teacherPhNo"]??"",
      docid: json["docid"]?? "", 
      userRole: json["userRole"]?? ""
      
      );

  Map<String, dynamic> toJson() => {
        "teacherName": teacherName,
        "teacherEmail": teacherEmail,
        "houseName": houseName,
        "houseNumber": houseNumber,
        "place": place, 
        "gender": gender, 
        "district": district, 
        "altPhoneNo": altPhoneNo , 
        "employeeID":employeeID, 
        "joinDate" : joinDate,
        "teacherPhNo":teacherPhNo,
        "docid" : docid, 
        "userRole":userRole
      };
}

