import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/controllers/log_out/user_logout_controller.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:dujo_kerala_application/view/home/parent_home/parent_main_home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helper/shared_pref_helper.dart';
import '../../local_database/parent_login_database.dart';
import '../../main.dart';
import '../../model/parent_model/parent_model.dart';
import '../../utils/utils.dart';

class MultipileStudentsController extends GetxController {
  RxBool isLoading = RxBool(false);
  var parentAuthlist = <DBParentLogin>[].obs;

  @override
  void onReady() {
    parentAuthlist.clear();
    parentAuthlist.addAll(parentdataDB.values);
    super.onReady();
  }

  addParentAuthDetails(DBParentLogin dBParentLoginDetails) async {
    parentdataDB.add(dBParentLoginDetails);
    parentAuthlist.add(dBParentLoginDetails);
    log("parentdataDB.toString()>>>>>>>>>${parentAuthlist[0].batchID}");
  }

  checkalreadyexist(String newParentDocID, DBParentLogin dBParentLoginDetails) {
    // log("Hive ++++++++  ${parentdataDB.getAt(0)?.parentID}");
    List<DBParentLogin> parentDocIDes = parentdataDB.values.toList();
    List<DBParentLogin> checkingIDAlready = parentDocIDes
        .where((element) => element.parentDocID == newParentDocID)
        .toList();
    if (checkingIDAlready.isEmpty) {
      log('TTTTTTT   Parent Deatils Added TTTTTTTT');

      addParentAuthDetails(dBParentLoginDetails);
      return false;
    } else {
      log('xxxxxxxxxx   Parent Deatils Already Exist   xxxxxxxxx');

      return true;
    }
  }

  Future<void> switchStudent(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Obx(() {
          return isLoading.value
              ? circularProgressIndicatotWidget
              : AlertDialog(
                  title: Text('Select Class'.tr),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        SizedBox(
                          height: 500,
                          width: 500,
                          child: ListView.separated(
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () async {
                                    await parentsignIn(
                                        context,
                                        parentAuthlist[index].parentDocID,
                                        parentAuthlist[index].classID,
                                        parentAuthlist[index].schoolID,
                                        parentAuthlist[index].batchID);
                                  },
                                  child: Container(
                                    color: Colors.red,
                                    height: 40,
                                    child: Text(parentAuthlist[index].emailID),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return Divider();
                              },
                              itemCount: parentdataDB.length),
                        )
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('cancel'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                );
        });
      },
    );
  }

  Future<void> parentsignIn(BuildContext context, String parentDocID,
      String classID, String schoolID, String batchID) async {
    UserCredentialsController.batchId = batchID;
    UserCredentialsController.classId = classID;

    log("School ID ${schoolID}");
    log("parentDocID ID ${parentDocID}");
    log("batchID ID ${batchID}");
    log("classID ID ${classID}");
    try {
      isLoading.value = true;

      //fetching parent data from firebase
      final parentData = await FirebaseFirestore.instance
          .collection('SchoolListCollection')
          .doc(schoolID)
          .collection(batchID)
          .doc(batchID)
          .collection('classes')
          .doc(classID)
          .collection('ParentCollection')
          .doc(parentDocID)
          .get();

      if (parentData.data() != null) {
        UserCredentialsController.parentModel = ParentModel.fromMap(
          parentData.data()!,
        );
      }
      if (UserCredentialsController.parentModel?.userRole == "parent") {
        //assigining shared preference user role for app close
        log("Entered>>>>>>>>>>>");
        await SharedPreferencesHelper.setString(
            SharedPreferencesHelper.userRoleKey, 'parent');
        await Future.delayed(const Duration(seconds: 3)).then((value) {
          Get.offAll(ParentMainHomeScreen());
        });
        isLoading.value = false;
      } else {
        log("Access denied since you are not a parent");
        showToast(
          msg: "Access denied since you are not a parent",
        );
        isLoading.value = false;
      }
    } catch (e) {
      isLoading.value = false;
      showToast(msg: "Sign in failed");
    }
  }
}
