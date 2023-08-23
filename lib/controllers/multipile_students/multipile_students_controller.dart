import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
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
import '../../view/colors/colors.dart';

class MultipileStudentsController extends GetxController {
  RxBool isLoading = RxBool(false);
  List<DBParentLogin> parentAuthlist = <DBParentLogin>[].obs;
  @override
  void onInit() {
    parentAuthlist.clear();
    parentAuthlist.addAll(parentdataDB.values);
    super.onInit();
  }

  addParentAuthDetails(DBParentLogin dBParentLoginDetails) async {
    await parentdataDB.add(dBParentLoginDetails);
    parentAuthlist.add(dBParentLoginDetails);
  }

  Future<void> removeFromHive(int index) async {
    await parentdataDB.deleteAt(index);
    parentAuthlist.removeAt(index);
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
                  title: Text('Select Mail'.tr),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        SizedBox(
                          height: 400,
                          width: 400,
                          child: parentdataDB.isEmpty
                              ? const Center(
                                  child: Text('No Mail found'),
                                )
                              : ListView.separated(
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
                                        color:
                                            adminePrimayColor.withOpacity(0.2),
                                        // width:100,
                                        height: 40,
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 05),
                                              child: Text(parentAuthlist[index]
                                                  .emailID),
                                            ),
                                            const Spacer(),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 04),
                                              child: IconButton(
                                                onPressed: () {
                                                  showDialog(
                                                    context: context,
                                                    barrierDismissible:
                                                        false, // user must tap button!
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        title:
                                                            const Text('Alert'),
                                                        content:
                                                            SingleChildScrollView(
                                                          child: ListBody(
                                                            children: const <
                                                                Widget>[
                                                              Text(
                                                                  'Do you want to remove this email')
                                                            ],
                                                          ),
                                                        ),
                                                        actions: <Widget>[
                                                          TextButton(
                                                            child: const Text(
                                                                'Cancel'),
                                                            onPressed:
                                                                () async {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                          ),
                                                          TextButton(
                                                            child: const Text(
                                                                'Ok'),
                                                            onPressed:
                                                                () async {
                                                              await removeFromHive(
                                                                      index)
                                                                  .then(
                                                                      (value) {
                                                                Navigator.pop(
                                                                    context);
                                                                Navigator.pop(
                                                                    context);
                                                              });
                                                            },
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                },
                                                icon: const Icon(
                                                  Icons.delete,
                                                ),
                                                color:
                                                    Colors.red.withOpacity(0.4),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return const Divider();
                                  },
                                  itemCount: parentdataDB.length),
                        )
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('Cancel'),
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
      UserCredentialsController.schoolId = schoolID;
      UserCredentialsController.batchId = batchID;
      UserCredentialsController.classId = classID;
      await FirebaseAuth.instance.signOut().then((value) async {
        await SharedPreferencesHelper.setString(
                SharedPreferencesHelper.userRoleKey, 'parent')
            .then((value) => log('Added userRoll'));
        // await SharedPreferencesHelper.clearSharedPreferenceData();
        // UserCredentialsController.clearUserCredentials();
      }).then((value) async {
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
                  SharedPreferencesHelper.userRoleKey, 'parent')
              .then((value) => log('Added userRoll'));
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
