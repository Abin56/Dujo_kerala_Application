import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class GetFireBaseData extends GetxController {
  RxString teacherID = ''.obs;
  RxString teacherName = ''.obs;
  RxString employeeID = ''.obs;
  RxString classIncharge = ''.obs;
  RxString teacherEmail = ''.obs;
   RxString teacherImage = ''.obs;

  Future<void> fetchAllTeacherData() async {
    var vari = await FirebaseFirestore.instance
        .collection("SchoolListCollection")
        .doc('MarthCheng13283')
        .collection('Teachers')
        .doc('abinjohn8089@gmail.com')
        .get();
    teacherID.value = vari.data()!['docID'];
    teacherName.value = vari.data()!['teacherName'];
    employeeID.value = vari.data()!['employeeID'];
    classIncharge.value = vari.data()!['classIncharge'];
    teacherEmail.value = vari.data()!['teacherEmail'];
     teacherImage.value = vari.data()!['teacherImage'];
  }
}