// To parse this JSON data, do
//
//     final studentModel = studentModelFromJson(jsonString);

import 'dart:convert';

StudentModel studentModelFromJson(String str) =>
    StudentModel.fromJson(json.decode(str));

String studentModelToJson(StudentModel data) => json.encode(data.toJson());

class StudentModel {
  String admissionNumber;
  String alPhoneNumber;
  String bloodgroup;
  String classId;
  String createDate;
  String dateofBirth;
  String district;
  String docid;
  String gender;
  String guardianId;
  String houseName;
  String parentId;
  String parentPhoneNumber;
  String place;
  String profileImageId;
  String profileImageUrl;
  String studentName;
  String studentemail;
  String userRole='student';

  StudentModel({
    required this.admissionNumber,
    required this.alPhoneNumber,
    required this.bloodgroup,
    required this.classId,
    required this.createDate,
    required this.dateofBirth,
    required this.district,
    required this.docid,
    required this.gender,
    required this.guardianId,
    required this.houseName,
    required this.parentId,
    required this.parentPhoneNumber,
    required this.place,
    required this.profileImageId,
    required this.profileImageUrl,
    required this.studentName,
    required this.studentemail,
    required this.userRole,
  });

  StudentModel copyWith({
    String? admissionNumber,
    String? alPhoneNumber,
    String? bloodgroup,
    String? classId,
    String? createDate,
    String? dateofBirth,
    String? district,
    String? docid,
    String? gender,
    String? guardianId,
    String? houseName,
    String? parentId,
    String? parentPhoneNumber,
    String? place,
    String? profileImageId,
    String? profileImageUrl,
    String? studentName,
    String? studentemail,
    String? userRole,
  }) =>
      StudentModel(
        admissionNumber: admissionNumber ?? this.admissionNumber,
        alPhoneNumber: alPhoneNumber ?? this.alPhoneNumber,
        bloodgroup: bloodgroup ?? this.bloodgroup,
        classId: classId ?? this.classId,
        createDate: createDate ?? this.createDate,
        dateofBirth: dateofBirth ?? this.dateofBirth,
        district: district ?? this.district,
        docid: docid ?? this.docid,
        gender: gender ?? this.gender,
        guardianId: guardianId ?? this.guardianId,
        houseName: houseName ?? this.houseName,
        parentId: parentId ?? this.parentId,
        parentPhoneNumber: parentPhoneNumber ?? this.parentPhoneNumber,
        place: place ?? this.place,
        profileImageId: profileImageId ?? this.profileImageId,
        profileImageUrl: profileImageUrl ?? this.profileImageUrl,
        studentName: studentName ?? this.studentName,
        studentemail: studentemail ?? this.studentemail,
        userRole: userRole ?? this.userRole,
      );

  factory StudentModel.fromJson(Map<String, dynamic> json) => StudentModel(
        admissionNumber: json["admissionNumber"] ?? "",
        alPhoneNumber: json["alPhoneNumber"] ?? "",
        bloodgroup: json["bloodgroup"] ?? "",
        classId: json["classID"] ?? "",
        createDate: json["createDate"] ?? "",
        dateofBirth: json["dateofBirth"] ?? "",
        district: json["district"] ?? "",
        docid: json["docid"] ?? "",
        gender: json["gender"] ?? "",
        guardianId: json["guardianID"] ?? "",
        houseName: json["houseName"] ?? "",
        parentId: json["parentID"] ?? "",
        parentPhoneNumber: json["parentPhoneNumber"] ?? "",
        place: json["place"] ?? "",
        profileImageId: json["profileImageId"] ?? "",
        profileImageUrl: json["profileImageUrl"] ?? "",
        studentName: json["studentName"] ?? "",
        studentemail: json["studentemail"] ?? "",
        userRole: json["userRole"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "admissionNumber": admissionNumber,
        "alPhoneNumber": alPhoneNumber,
        "bloodgroup": bloodgroup,
        "classID": classId,
        "createDate": createDate,
        "dateofBirth": dateofBirth,
        "district": district,
        "docid": docid,
        "gender": gender,
        "guardianID": guardianId,
        "houseName": houseName,
        "parentID": parentId,
        "parentPhoneNumber": parentPhoneNumber,
        "place": place,
        "profileImageId": profileImageId,
        "profileImageUrl": profileImageUrl,
        "studentName": studentName,
        "studentemail": studentemail,
        "userRole": userRole,
      };
}
