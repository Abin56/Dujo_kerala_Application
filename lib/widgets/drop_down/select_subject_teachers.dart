import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

var teacherSubjectValue;

class GetTeachersSubjectsDropDownButton extends StatefulWidget {
  String classId;
  GetTeachersSubjectsDropDownButton({Key? key, required this.classId})
      : super(key: key);

  @override
  State<GetTeachersSubjectsDropDownButton> createState() =>
      _GetTeachersSubjectsDropDownButtonState();
}

class _GetTeachersSubjectsDropDownButtonState
    extends State<GetTeachersSubjectsDropDownButton> {
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
            .collection('classes')
            .doc(widget.classId)
            .collection('teachers')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('teacherSubject')
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasData) {
            return DropdownButtonFormField(
              hint: teacherSubjectValue == null
                  ?  Text(
                      "Select Subject".tr,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0), fontSize: 18),
                    )
                  : Text(teacherSubjectValue!["subjectName"]),
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
                    teacherSubjectValue = categoryIDObject;
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
