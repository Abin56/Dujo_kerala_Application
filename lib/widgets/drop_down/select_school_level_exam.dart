import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

var schoolLevelExamistValue;

class GetSchoolLevelExamDropDownButton extends StatefulWidget {
  String examType;
  GetSchoolLevelExamDropDownButton({Key? key, required this.examType})
      : super(key: key);

  @override
  State<GetSchoolLevelExamDropDownButton> createState() =>
      _GetSchoolLevelExamDropDownButtonState();
}

class _GetSchoolLevelExamDropDownButtonState
    extends State<GetSchoolLevelExamDropDownButton> {
  @override
  Widget build(BuildContext context) {
    return dropDownButton();
  }

  dropDownButton() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("SchoolListCollection")
            .doc(UserCredentialsController.schoolId)
            .collection(UserCredentialsController.batchId!)
            .doc(UserCredentialsController.batchId!)
            .collection(widget.examType)
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasData) {
            return DropdownButtonFormField(
              hint: schoolLevelExamistValue == null
                  ? Text(
                      "Select Exam".tr,
                      style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0), fontSize: 18),
                    )
                  : Text(schoolLevelExamistValue!["examName"]),
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
                    value: val["examName"],
                    child: Text(val["examName"]),
                  );
                },
              ).toList(),
              onChanged: (val) {
                var categoryIDObject = snapshot.data!.docs
                    .where((element) => element["examName"] == val)
                    .toList()
                    .first;
                log(categoryIDObject["examName"]);

                setState(
                  () {
                    schoolLevelExamistValue = categoryIDObject;
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
