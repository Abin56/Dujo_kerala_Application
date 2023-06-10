// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeWorksModel {
  String? docid;
  String tasks;
  String teacherid;
  String subjectid;
  String uploadDate;
  String endDate;
  HomeWorksModel({
    this.docid,
    required this.tasks,
    required this.teacherid,
    required this.subjectid,
    required this.uploadDate,
    required this.endDate,
  });

  HomeWorksModel copyWith({
    String? docid,
    String? tasks,
    String? teacherid,
    String? subjectid,
    String? uploadDate,
    String? endDate,
  }) {
    return HomeWorksModel(
      docid: docid ?? this.docid,
      tasks: tasks ?? this.tasks,
      teacherid: teacherid ?? this.teacherid,
      subjectid: subjectid ?? this.subjectid,
      uploadDate: uploadDate ?? this.uploadDate,
      endDate: endDate ?? this.endDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'docid': docid ?? "",
      'tasks': tasks,
      'teacherid': teacherid,
      'subjectid': subjectid,
      'uploadDate': uploadDate,
      'endDate': endDate,
    };
  }

  factory HomeWorksModel.fromMap(Map<String, dynamic> map) {
    return HomeWorksModel(
      docid: map['docid'] != null ? map['docid'] as String : null,
      tasks: map['tasks'] as String,
      teacherid: map['teacherid'] as String,
      subjectid: map['subjectid'] as String,
      uploadDate: map['uploadDate'] as String,
      endDate: map['endDate'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory HomeWorksModel.fromJson(String source) =>
      HomeWorksModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'HomeWorksModel(docid: $docid, tasks: $tasks, teacherid: $teacherid, subjectid: $subjectid, uploadDate: $uploadDate, endDate: $endDate)';
  }

  @override
  bool operator ==(covariant HomeWorksModel other) {
    if (identical(this, other)) return true;

    return other.docid == docid &&
        other.tasks == tasks &&
        other.teacherid == teacherid &&
        other.subjectid == subjectid &&
        other.uploadDate == uploadDate &&
        other.endDate == endDate;
  }

  @override
  int get hashCode {
    return docid.hashCode ^
        tasks.hashCode ^
        teacherid.hashCode ^
        subjectid.hashCode ^
        uploadDate.hashCode ^
        endDate.hashCode;
  }
}

class AddHomeWorsToFireBase {
  Future addHomeWorksController(
      HomeWorksModel productModel, context, schoolid, classId, batchId) async {
    try {
      final firebase = FirebaseFirestore.instance;
      final doc = firebase
          .collection("SchoolListCollection")
          .doc(schoolid)
          .collection(batchId)
          .doc(batchId)
          .collection("classes")
          .doc(classId)
          .collection("HomeWorks")
          .add(productModel.toMap())
          .then((value) {
        firebase
            .collection("SchoolListCollection")
            .doc(schoolid)
            .collection(batchId)
            .doc(batchId)
            .collection("classes")
            .doc(classId)
            .collection("HomeWorks")
            .doc(value.id)
            .update({'docid': value.id}).then((value) {
          return showDialog(
            context: context,
            barrierDismissible: false, // user must tap button!
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Message'),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: const <Widget>[
                      Text('Successfully uploaded'),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Ok'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        });
      });
    } on FirebaseException catch (e) {
      print('Error ${e.message.toString()}');
    }
  }
}
