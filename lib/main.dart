import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:dujo_kerala_application/firebase_options.dart';
import 'package:dujo_kerala_application/view/constant/responsive.dart';
import 'package:dujo_kerala_application/view/language/language.dart';
import 'package:dujo_kerala_application/view/language/select_language/select_language.dart';
import 'package:dujo_kerala_application/view/pages/chat_gpt/providers/chats_provider.dart';
import 'package:dujo_kerala_application/view/pages/chat_gpt/providers/models_provider.dart';
import 'package:dujo_kerala_application/view/pages/login/dujo_login_screen.dart';
import 'package:dujo_kerala_application/view/pages/splash_screen/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

import 'controllers/bloc/user_phone_otp/auth_cubit.dart';
import 'controllers/bloc/user_phone_otp/auth_state.dart';
import 'helper/shared_pref_helper.dart';
import 'local_database/parent_login_database.dart';

late Box<DBParentLogin> parentdataDB;

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  log('Handling  a background message ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(DBParentLoginAdapter().typeId)) {
    Hive.registerAdapter(DBParentLoginAdapter());
  }
  parentdataDB = await Hive.openBox<DBParentLogin>('parentloginAuth');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseMessaging.instance.getInitialMessage();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await ScreenUtil.ensureScreenSize();
  //creating shared preference
  await SharedPreferencesHelper.initPrefs();
  ScreenUtil.ensureScreenSize();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  ///[languageCode]and[countryCode] will be change [updateLanguage] function on select language page
  final String languageCode =
      SharedPreferencesHelper.getString("langCode") ?? "en";
  final String countryCode =
      SharedPreferencesHelper.getString("langCode") ?? "US";

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        minTextAdapt: true,
        splitScreenMode: true,
        designSize: const Size(423.5294196844927, 945.8823706287004),
        builder: (context, child) {
          return BlocProvider(
            create: (context) => AuthCubit(),
            child: MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  create: (_) => ModelsProvider(),
                ),
                ChangeNotifierProvider(
                  create: (_) => ChatProvider(),
                ),
              ],
              child: GetMaterialApp(
                translations: GetxLanguage(),
                locale: Locale(languageCode, countryCode),
                debugShowCheckedModeBanner: false,
                home: BlocBuilder<AuthCubit, AuthState>(
                  buildWhen: (oldState, newState) {
                    return oldState is AuthInitialState;
                  },
                  builder: (context, state) {
                    ResponsiveApp.serMq(context);
                    if (state is AuthLoggedInState) {
                      if (SharedPreferencesHelper.getString("langCode") !=
                          null) {
                        return const SplashScreen();
                      } else {
                        return const SelectLanguage();
                      }
                    } else if (state is AuthLoggedOutState) {
                      if (SharedPreferencesHelper.getString("langCode") !=
                          null) {
                        return const SplashScreen();
                      } else {
                        return const SelectLanguage();
                      }
                    }
                    if (SharedPreferencesHelper.getString("langCode") != null) {
                      return const SplashScreen();
                    } else {
                      return const SelectLanguage();
                    }
                  },
                ),
              ),
            ),
          );
        });
  }
}

////

checkingSchoolActivate(BuildContext context) async {
  final checking = await FirebaseFirestore.instance
      .collection('SchoolListCollection')
      .doc(UserCredentialsController.schoolId)
      .get();

  if (checking.data()!['deactive'] == true) {
    Get.offAll(() => const DujoLoginScren());
    // ignore: use_build_context_synchronously
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Alert'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[Text('Your School is Deactivated')],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('ok'),
              onPressed: () async {
                await FirebaseAuth.instance.signOut().then((value) async {
                  await SharedPreferencesHelper.clearSharedPreferenceData();
                  UserCredentialsController.clearUserCredentials();
                  Get.offAll(() => const DujoLoginScren());
                });
              },
            ),
          ],
        );
      },
    );
  } else {
    return;
  }
}
