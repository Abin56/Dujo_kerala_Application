import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../model/general_instructions_model/general_instructions_model.dart';
import '../../utils/utils.dart';
import '../userCredentials/user_credentials.dart';

class GeneralInstructionsController {
  CollectionReference<Map<String, dynamic>> firebase = FirebaseFirestore
      .instance
      .collection('SchoolListCollection')
      .doc(UserCredentialsController.schoolId)
      .collection(UserCredentialsController.batchId ?? " ")
      .doc(UserCredentialsController.batchId ?? " ")
      .collection('general_instructions');

  RxList<GeneralInstructionModel> listOfGeneralIModel =
      RxList<GeneralInstructionModel>([]);

  RxBool isLoading = RxBool(false);
  RxString schoolName = RxString("");

  Future<void> getInstruction() async {
    try {
      isLoading.value = true;
      await getSchoolName(UserCredentialsController.schoolId ?? "");
      QuerySnapshot<Map<String, dynamic>> result =
          await firebase.orderBy('time').get();
      listOfGeneralIModel.value = result.docs
          .map(
            (e) => GeneralInstructionModel.fromMap(
              e.data(),
            ),
          )
          .toList();
      isLoading.value = false;
    } catch (e) {
      showToast(msg: 'Failed to load data ${e.toString()}');
      isLoading.value = false;
    }
  }

  Future<void> getSchoolName(String schoolId) async {
    try {
      final schoolData = await FirebaseFirestore.instance
          .collection('SchoolListCollection')
          .doc(schoolId)
          .get();
      schoolName.value = schoolData.data()!['schoolName'];
    } catch (e) {
      showToast(msg: 'School Name error');
    }
  }
}
