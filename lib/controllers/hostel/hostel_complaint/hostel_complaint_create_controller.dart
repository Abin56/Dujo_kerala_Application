import 'package:cloud_firestore/cloud_firestore.dart';

class HostelComplaintCreateController {
  static String className =
      "HostelComplaintCreateController"; //for debugging log

  final _firestore =
      FirebaseFirestore.instance.collection("SchoolListCollection");

  Future<void> createHostelComplaint() async {}
}
