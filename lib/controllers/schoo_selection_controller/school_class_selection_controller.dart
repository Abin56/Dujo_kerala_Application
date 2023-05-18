import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../utils/utils.dart';
import '../../model/class_list_model/class_list_model.dart';
import '../../model/schoo_list_model/school_list_model.dart';
import '../userCredentials/user_credentials.dart';

class   SchoolClassSelectionController extends GetxController {
  String className = "SchoolClassSelectionController";
  final CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('SchoolListCollection');
  List<SchoolModel> schoolModelList = [];
  List<ClassModel> classModelList = [];
  List<String> batchList = [];

  ///Application open time creating a [SchoolClassSelectionController] singleton object using Get.put()
  ///inside of init function [onInit] call [fetchAllSchoolData]

  Future<void> fetchAllSchoolData() async {
    schoolModelList.clear();
    try {
      final QuerySnapshot<Map<String, dynamic>> data = await collectionReference
          .get() as QuerySnapshot<Map<String, dynamic>>;
      schoolModelList =
          data.docs.map((e) => SchoolModel.fromJson(e.data())).toList();
    } catch (e) {
      showToast(msg: "School Data Error");
      log(name: className, e.toString());
    }
  }

  ///User Click School from[SearchSchoolBar]  on tap function assign schoolId

  Future<void> fetchBatachDetails() async {
    batchList.clear();
    try {
      QuerySnapshot<Map<String, dynamic>> data = await collectionReference
          .doc(UserCredentialsController.schoolId)
          .collection('BatchYear')
          .get();

      batchList = data.docs.map((e) => e.id).toList();
    } catch (e) {
      showToast(msg: 'Batch Selection Error');
      log(name: className, e.toString());
    }
  }

  Future<void> fetchAllClassData() async {
    classModelList.clear();
    if (UserCredentialsController.schoolId == null ||
        UserCredentialsController.batchId == null) {
      showToast(msg: "Some Error Occured");
      return;
    }
    try {
      final data = await collectionReference
          .doc(UserCredentialsController.schoolId)
          .collection(UserCredentialsController.batchId!)
          .doc(UserCredentialsController.batchId)
          .collection('classes')
          .get();

      classModelList =
          data.docs.map((e) => ClassModel.fromMap(e.data())).toList();
    } catch (e) {
      showToast(msg: "Class Data Error");
      log(name: className, e.toString());
    }
  }

  @override
  void onInit() async {
    await fetchAllSchoolData();
    super.onInit();
  }
}
