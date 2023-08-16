import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

var multipileStundentDOCIDValue;

class GetSelectStundentforParentsDropDownButton extends StatefulWidget {
  String parentDocID;
  GetSelectStundentforParentsDropDownButton(
      {Key? key, required this.parentDocID})
      : super(key: key);

  @override
  State<GetSelectStundentforParentsDropDownButton> createState() =>
      _GetSelectStundentforParentsDropDownButtonState();
}

class _GetSelectStundentforParentsDropDownButtonState
    extends State<GetSelectStundentforParentsDropDownButton> {
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
            .doc(UserCredentialsController.classId)
            .collection('ParentCollection')
            .doc(widget.parentDocID)
            .collection('MultipleStudents')
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasData) {
            return DropdownButtonFormField(
              hint: multipileStundentDOCIDValue == null
                  ? Text(
                      "Select Student".tr,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0), fontSize: 18),
                    )
                  : Text(multipileStundentDOCIDValue!["studentName"]),
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
                    multipileStundentDOCIDValue = categoryIDObject;
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
