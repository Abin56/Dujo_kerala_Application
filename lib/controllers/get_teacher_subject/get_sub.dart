import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../userCredentials/user_credentials.dart';

class TeacherSubjectController extends GetxController {
  RxList teacherNameList = [].obs;
  RxString teacherName = ''.obs;
  Future<String> getSubject(String teacherID) async {
    final DocumentSnapshot<Map<String, dynamic>> result =
        await FirebaseFirestore.instance
            .collection("SchoolListCollection")
            .doc(UserCredentialsController.schoolId)
            .collection('Teachers')
            .doc(teacherID)
            .get();
    return result.data()?["teacherName"];
  }

  getTeacherName(String teacherID) async {
    final DocumentSnapshot<Map<String, dynamic>> result =
        await FirebaseFirestore.instance
            .collection("SchoolListCollection")
            .doc(UserCredentialsController.schoolId)
            .collection('Teachers')
            .doc(teacherID)
            .get();
    teacherName.value = result.data()!['teacherName'] ?? "";
  }
}
