import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SelectLanguage extends StatelessWidget {
  final List locale = [
    {'name': 'ENGLISH', 'locale': Locale('en', 'US')},
    {'name': 'ಕನ್ನಡ', 'locale': Locale('kn', 'IN')},
    {'name': 'हिंदी', 'locale': Locale('hi', 'IN')},
    {'name': 'മലയാളം', 'locale': Locale('ml', 'IN')},
  ];
  updateLanguage(Locale locale) {
    Get.back();
    Get.updateLocale(locale);
  }

  builddialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Choose a Language".tr),
          content: Container(
            width: double.maxFinite,
            child: ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                        onTap: () {
                          log(locale[index]['name']);
                          updateLanguage(locale[index]['locale']);
                        },
                        child: Text(
                          locale[index]['name'],
                        )),
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
                itemCount: locale.length),
          ),
        );
      },
    );
  }

  SelectLanguage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 50,
              width: 200,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(30)),
              child: ElevatedButton(
                  onPressed: () async {
                    builddialog(context);
                  },
                  child: Text('Change Language'.tr)),
            ),
            SizedBox(
              height: 20,
            ),
            // Container(
            //   height: 50,
            //   width: 100,
            //   decoration:
            //       BoxDecoration(borderRadius: BorderRadius.circular(30)),
            //   child: ElevatedButton(
            //       onPressed: () async {
            //         Get.offAll(Onboardingpage());
            //       },
            //       child: Text('Next'.tr)),
            // ),
          ],
        ),
      ),
    );
  }
}
    // SharedPreferences prefs =
    //                     await SharedPreferences.getInstance();
    //                 bool? isOnBoard = prefs.getBool('seenonboard');
    //                 if (isOnBoard == true) {
    //                   log("True");
    //                   Get.offAll(OpeningPage());
    //                 } else {
    //                   Get.offAll(SelectLanguage());
    //                 }