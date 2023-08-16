import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:dujo_kerala_application/view/home/parent_home/parent_main_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/drop_down/select_Stundet_forParent.dart';

class MultipileStudentsController extends GetxController {
  RxBool isLoading = RxBool(false);
  assignStudentToParent(String schoolID, String batchID, String classID,
      String parentID, String studentID) async {
    isLoading.value = true;
    final firebase = FirebaseFirestore.instance
        .collection("SchoolListCollection")
        .doc(schoolID)
        .collection(batchID)
        .doc(batchID)
        .collection(classID)
        .doc(classID);

    final checkingstudentID =
        await firebase.collection('ParentCollection').doc(parentID).get();

    if (checkingstudentID.data()?['studentID']) {
      log("Current StudentID ::: ${checkingstudentID.data()?['studentID']}");

      firebase
          .collection("ParentCollection")
          .doc(parentID)
          .collection('MultipileStudents')
          .doc(checkingstudentID.data()!['studentID'])
          .set({'studentID': checkingstudentID.data()!['studentID']}).then(
              (value) async {
        await firebase
            .collection("ParentCollection")
            .doc(parentID)
            .collection('MultipileStudents')
            .doc(studentID)
            .set({'studentID': studentID}).then((value) async {
          await firebase
              .collection('Students')
              .doc(studentID)
              .set({"parentID": parentID}, SetOptions(merge: true));
        });
      });
      isLoading.value = false;
    } else {
      log("Current StudentID ::: NOT FOUND ::");
      await firebase
          .collection("ParentCollection")
          .doc(parentID)
          .collection('MultipileStudents')
          .doc(studentID)
          .set({'studentID': studentID});
      isLoading.value = false;
    }
  }

  switchToStudent(BuildContext context, String parentID) async {
    showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Student'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GetSelectStundentforParentsDropDownButton(
                  parentDocID: parentID,
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('ok'),
              onPressed: () async {
                UserCredentialsController.schoolId =
                    multipileStundentDOCIDValue!['schoolID'];
                UserCredentialsController.batchId =
                    multipileStundentDOCIDValue!['batchID'];
                UserCredentialsController.classId =
                    multipileStundentDOCIDValue!['classID'];
                UserCredentialsController.parentModel!.studentID =
                    multipileStundentDOCIDValue!['studentID'];

                Get.offAll(const ParentMainHomeScreen());
              },
            ),
            TextButton(
              child: const Text('cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
