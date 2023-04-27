import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../userCredentials/user_credentials.dart';

class ParentSignUpController extends GetxController {
  CollectionReference<Map<String, dynamic>> firebaseData = FirebaseFirestore
      .instance
      .collection("SchoolListCollection")
      .doc(UserCredentialsController.schoolId)
      .collection(UserCredentialsController.batchId ?? "")
      .doc(UserCredentialsController.batchId ?? "")
      .collection("Classes")
      .doc(UserCredentialsController.classId)
      .collection("Students");
}
