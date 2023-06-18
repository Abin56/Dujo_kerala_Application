import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

var allClassStudentsListValue;

class AllClassStudentsListDropDownButton extends StatefulWidget {
  String classID;
  AllClassStudentsListDropDownButton({Key? key, required this.classID})
      : super(key: key);

  @override
  State<AllClassStudentsListDropDownButton> createState() =>
      _AllClassStudentsListDropDownButtonState();
}

class _AllClassStudentsListDropDownButtonState
    extends State<AllClassStudentsListDropDownButton> {
  @override
  Widget build(BuildContext context) {
    return dropDownButton();
  }

  StreamBuilder<QuerySnapshot<Map<String, dynamic>>> dropDownButton() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("SchoolListCollection")
            .doc(UserCredentialsController.schoolId)
            .collection(UserCredentialsController.batchId!)
            .doc(UserCredentialsController.batchId!)
            .collection("classes")
            .doc(widget.classID)
            .collection('Students')
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasData) {
            return DropdownButtonFormField(
              hint: allClassStudentsListValue == null
                  ?  Text(
                      "Select Student".tr,
                      style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0), fontSize: 18),
                    )
                  : Text(allClassStudentsListValue!["studentName"]),
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
                    value: val["studentName"],
                    child: Text(val["studentName"]),
                  );
                },
              ).toList(),
              onChanged: (val) {
                var categoryIDObject = snapshot.data!.docs
                    .where((element) => element["studentName"] == val)
                    .toList()
                    .first;
                log(categoryIDObject["studentName"]);

                setState(
                  () {
                    allClassStudentsListValue = categoryIDObject;
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
