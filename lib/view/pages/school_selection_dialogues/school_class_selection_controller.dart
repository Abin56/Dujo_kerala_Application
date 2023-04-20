
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'utils/utils.dart';
import 'class_list_model.dart';
import 'school_list_model.dart';

class SchoolClassSelectionController extends GetxController {
  final CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('SchoolListCollection');
  List<SchoolModel> schoolModelList = [];
  List<ClassModel> classModelList = [];
  List<String> batchList = [];
  String? schoolId;
  String? classId;
  String? batchId;

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

  Future<void> fetchAllClassData() async {
    if (schoolId == null) {
      showToast(msg: "Some Error Occured");
      return;
    }
    try {
      classModelList.clear();
      final data = await collectionReference
          .doc(schoolId)
          .collection(batchId ?? "")
          .doc(batchId)
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

  Future<void> getBatachDetails() async {
    try {
      batchList.clear();
      QuerySnapshot<Map<String, dynamic>> data =
          await collectionReference.doc(schoolId).collection('BatchYear').get();

      for (var element in data.docs) {
        batchList.add(element.id);
      }
    } catch (e) {
      showToast(msg: 'Batch Selection Error');
    }
  }

  @override
  void onInit() async {
    await fetchAllSchoolData();
    super.onInit();
  }
}
