import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../utils/utils.dart';
import '../../model/class_list_model/class_list_model.dart';
import '../../model/schoo_list_model/school_list_model.dart';
import '../userCredentials/user_credentials.dart';

class SchoolClassSelectionController extends GetxController {
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
      final data = await collectionReference.get();
      for (var element in data.docs) {
        schoolModelList
            .add(SchoolModel.fromJson(element.data() as Map<String, dynamic>));
      }
    } catch (e) {
      showToast(msg: "School Data Error");
    }
  }

  ///User Click School from[SearchSchoolBar]  on tap function assign schoolId

  Future<void> fetchBatachDetails() async {
    try {
      batchList.clear();
      QuerySnapshot<Map<String, dynamic>> data =
          await collectionReference.doc(UserCredentialsController.schoolId).collection('BatchYear').get();

      for (var element in data.docs) {
        batchList.add(element.id);
      }
    } catch (e) {
      showToast(msg: 'Batch Selection Error');
    }
  }

  Future<void> fetchAllClassData() async {
    if (UserCredentialsController.schoolId == null || UserCredentialsController.batchId == null) {
      showToast(msg: "Some Error Occured");
      return;
    }
    try {
      classModelList.clear();
      final data = await collectionReference
          .doc(UserCredentialsController.schoolId)
          .collection(UserCredentialsController.batchId!)
          .doc(UserCredentialsController.batchId)
          .collection('Classes')
          .get();
      for (var element in data.docs) {
        classModelList.add(
          ClassModel.fromJson(
            element.data(),
          ),
        );
      }
    } catch (e) {
      showToast(msg: "Class Data Error");
    }
  }

  @override
  void onInit() async {
    await fetchAllSchoolData();
    super.onInit();
  }
}
