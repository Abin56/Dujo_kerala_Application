
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class GetParentAndGuardian extends GetxController {
  RxString parentNAme = ''.obs;
  Future<void> getParentDetail(String studentID) async {
    var vari = await FirebaseFirestore.instance
        .collection("SchoolListCollection")
        .doc('MarthCheng13283')
        .collection("Students_Parents")
        .where('studentID', isEqualTo: studentID)
        .get();

    parentNAme.value = vari.docs[0].data()['parentName'];
  }

  ////////////////////////////
  ///
  ///
  ///
  RxString parentID = ''.obs;
  RxString parentNamee = ''.obs;
  RxString parentEmail = ''.obs;
  RxString studentID = ''.obs;
  RxString parentIMage = ''.obs;
  RxString studentName = ''.obs;

  Future<void> fetchAllParentData() async {
    var vari = await FirebaseFirestore.instance
        .collection("SchoolListCollection")
        .doc('MarthCheng13283')
        .collection('Students_Parents')
        .doc('1AqOvcgqUpn3I8o4MKB7')
        .get();
    parentID.value = vari.data()!['docid'];
    parentNamee.value = vari.data()!['parentName'];
    parentEmail.value = vari.data()!['parentEmail'];
    studentID.value = vari.data()!['studentID'];
    parentIMage.value = vari.data()!['profileImageURL'];
  }

  Future<void> fetchStudentDetail() async {
    var vari = await FirebaseFirestore.instance
        .collection("SchoolListCollection")
        .doc('MarthCheng13283')
        .collection('2023-June-2024-February')
        .doc('2023-June-2024-February')
        .collection("Classes")
        .doc('class1A@mthss')
        .collection('Students')
        .doc(studentID.value)
        .get();

    studentName.value = vari.data()!['studentName'];
  }
}
