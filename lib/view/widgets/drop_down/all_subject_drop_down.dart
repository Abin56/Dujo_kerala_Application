import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

var allsubjectListValue;

class GetAllSubjectListDropDownButton extends StatefulWidget {
  String schoolID;
  String batchId;
  String classId;

  GetAllSubjectListDropDownButton(
      {required this.batchId,
      required this.classId,
      required this.schoolID,
      Key? key})
      : super(key: key);

  @override
  State<GetAllSubjectListDropDownButton> createState() =>
      _GeClasseslListDropDownButtonState();
}

class _GeClasseslListDropDownButtonState
    extends State<GetAllSubjectListDropDownButton> {
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
            .collection('subjects')
            .get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding:  const EdgeInsets.all(10),
              child: DropdownButtonFormField(
                hint: allsubjectListValue == null
                    ?  Text(
                        "Select subject".tr,
                        style: TextStyle(
                            color: const Color.fromARGB(255, 0, 0, 0), fontSize: 15.w),
                      )
                    : Text(allsubjectListValue!["subjectName"]),
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
                      allsubjectListValue = categoryIDObject;
                    },
                  );
                },
              ),
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
