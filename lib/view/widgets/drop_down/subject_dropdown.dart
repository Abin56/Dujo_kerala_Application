import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

var subjectListValue;

class GetSubjectListDropDownButton extends StatefulWidget {
  String schoolID;
  String batchId;
  String classId;

  GetSubjectListDropDownButton(
      {required this.batchId,
      required this.classId,
      required this.schoolID,
      Key? key})
      : super(key: key);

  @override
  State<GetSubjectListDropDownButton> createState() =>
      _GeClasseslListDropDownButtonState();
}

class _GeClasseslListDropDownButtonState
    extends State<GetSubjectListDropDownButton> {
  @override
  Widget build(BuildContext context) {
    return dropDownButton();
  }

  FutureBuilder<QuerySnapshot<Map<String, dynamic>>> dropDownButton() {
    return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection("SchoolListCollection")
            .doc(widget.schoolID)
            .collection(widget.batchId)
            .doc(widget.batchId)
            .collection("classes")
            .doc(widget.classId)
            .collection('teachers')
            .doc(UserCredentialsController.teacherModel!.docid!)
            .collection('teacherSubject')
            .get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return DropdownButtonFormField(
              hint: subjectListValue == null
                  ?  Text(
                      "Select subject".tr,
                      style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0), fontSize: 18),
                    )
                  : Text(subjectListValue!["subjectName"]),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Colors.transparent, width: 0.5),
                  borderRadius: BorderRadius.circular(20),
                ),
                border: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Colors.transparent, width: 0.5),
                  borderRadius: BorderRadius.circular(20),
                ),
                filled: true,
              ),
              items: snapshot.data!.docs.map(
                (val) {
                  return DropdownMenuItem(
                    value: val["subjectName"],
                    child: Text(val["subjectName"]),
                  );
                },
              ).toList(),
              onChanged: (val) {
                var categoryIDObject = snapshot.data!.docs
                    .where((element) => element["subjectName"] == val)
                    .toList()
                    .first;
                log(categoryIDObject["subjectName"]);

                setState(
                  () {
                    subjectListValue = categoryIDObject;
                  },
                );
              },
            );
          }
          return const SizedBox(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
