import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:dujo_kerala_application/utils/utils.dart';

import '../../model/bus_route_model/bus_route_model.dart';

class BusListController {
  Future<List<BusRouteModel>> getAllBusList() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> busData =
          await FirebaseFirestore.instance
              .collection("SchoolListCollection")
              .doc(UserCredentialsController.schoolId)
              .collection("BusRoute")
              .get();

      final buslist =
          busData.docs.map((e) => BusRouteModel.fromMap(e.data())).toList();
      return buslist;
    } catch (e) {
      log(e.toString());
      showToast(msg: "Something Went Wrong");
      return [];
    }
  }
}
