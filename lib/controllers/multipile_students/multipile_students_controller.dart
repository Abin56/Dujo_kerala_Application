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
import '../../view/pages/login/dujo_login_screen.dart';

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
                                      parentAuthlist[index].batchID,
                                      parentAuthlist[index].parentEmail,
                                      parentAuthlist[index].parentPassword,
                                    );
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

  Future<void> parentsignIn(
      BuildContext context,
      String parentDocID,
      String classID,
      String schoolID,
      String batchID,
      String parentemail,
      String password) async {
    try {
      isLoading.value = true;
      await FirebaseAuth.instance
          .signOut()
          .then((value) async {
                await SharedPreferencesHelper.setString(
              SharedPreferencesHelper.userRoleKey,'parent').then((value) => log('Added userRoll'));
            // await SharedPreferencesHelper.clearSharedPreferenceData();
            // UserCredentialsController.clearUserCredentials();
          })
          .then((value) async {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(
          email: parentemail.trim(),
          password: password.trim(),
        )
            .then((value) async {
          log("Loggined sucess");
          //fetching parent data from firebase
          final DocumentSnapshot<Map<String, dynamic>> parentData =
              await FirebaseFirestore.instance
                  .collection('SchoolListCollection')
                  .doc(schoolID)
                  .collection(batchID)
                  .doc(batchID)
                  .collection('classes')
                  .doc(classID)
                  .collection('ParentCollection')
                  .doc(parentDocID)
                  .get();
          log("fecting data....");
          if (parentData.data() != null) {
            UserCredentialsController.parentModel = ParentModel.fromMap(
              parentData.data()!,
            );
          }

          //assigining shared preference user role for app close

          await SharedPreferencesHelper.setString(
              SharedPreferencesHelper.userRoleKey,'parent').then((value) => log('Added userRoll'));
          Get.offAll(const ParentMainHomeScreen());
          isLoading.value = false;
        }).catchError((error) {
          if (error is FirebaseAuthException) {
            isLoading.value = false;
            handleFirebaseError(error);
          }
        });
      });
    } catch (e) {
      isLoading.value = false;
      showToast(msg: "Sign in failed");
    }
  }
}
