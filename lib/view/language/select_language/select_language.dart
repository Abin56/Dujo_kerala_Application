import 'dart:developer';

import 'package:dujo_kerala_application/view/pages/push_notifications/notification_services.dart';
import 'package:dujo_kerala_application/view/pages/splash_screen/splash_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../helper/shared_pref_helper.dart';

class SelectLanguage extends StatefulWidget {
  const SelectLanguage({super.key});

  @override
  State<SelectLanguage> createState() => _SelectLanguageState();
}

class _SelectLanguageState extends State<SelectLanguage> {
  NotificationServices notificationServices = NotificationServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userRequestPermission();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
  }

  final List locale = [
    {'name': 'ENGLISH', 'locale': const Locale('en', 'US')},
    {'name': 'ಕನ್ನಡ', 'locale': const Locale('kn', 'IN')},
    {'name': 'हिंदी', 'locale': const Locale('hi', 'IN')},
    {'name': 'മലയാളം', 'locale': const Locale('ml', 'IN')},
  ];

  Future<void> updateLanguage(Locale locale) async {
    Get.back();
    await Get.updateLocale(locale);
    SharedPreferencesHelper.setString("langCode", locale.languageCode);
    SharedPreferencesHelper.setString("countryCode", locale.countryCode ?? "");
  }

  void userRequestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      log('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      log('User granted provisional permission');
    } else {
      log('User declined or has not accepted permission');
    }
  }

  builddialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Choose a Language".tr),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                        onTap: () async {
                          log(locale[index]['name']);

                          await updateLanguage(locale[index]['locale']);
                        },
                        child: Text(
                          locale[index]['name'],
                        )),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemCount: locale.length),
          ),
        );
      },
    );
  }

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
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 50,
              width: 130,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(30)),
              child: ElevatedButton(
                  onPressed: () async {
                    SharedPreferencesHelper.setString("langCode", "en");
                    SharedPreferencesHelper.setString("countryCode", "US");
                    Get.offAll(const SplashScreen());
                  },
                  child: Text('Next'.tr)),
            ),
          ],
        ),
      ),
    );
  }
}
