// To parse this JSON data, do
//
//     final classModel = classModelFromJson(jsonString);

import 'dart:convert';

ClassModel classModelFromJson(String str) =>
    ClassModel.fromJson(json.decode(str));

String classModelToJson(ClassModel data) => json.encode(data.toJson());

class ClassModel {
  ClassModel({
    required this.classId,
    required this.classIncharge,
    required this.className,
    required this.id,
    required this.joinDate,
  });

  String classId;
  String classIncharge;
  String className;
  String id;
  String joinDate;

  factory ClassModel.fromJson(Map<String, dynamic> json) => ClassModel(
        classId: json["classID"],
        classIncharge: json["classIncharge"],
        className: json["className"],
        id: json["id"],
        joinDate: json["joinDate"],
      );

  Map<String, dynamic> toJson() => {
        "classID": classId,
        "classIncharge": classIncharge,
        "className": className,
        "id": id,
        "joinDate": joinDate,
      };
}
