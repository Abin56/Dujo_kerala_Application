import 'dart:developer';

import 'package:dujo_kerala_application/firebase_options.dart';
import 'package:dujo_kerala_application/view/language/language.dart';
import 'package:dujo_kerala_application/view/language/select_language/select_language.dart';
import 'package:dujo_kerala_application/view/pages/chat_gpt/providers/chats_provider.dart';
import 'package:dujo_kerala_application/view/pages/chat_gpt/providers/models_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';

import 'controllers/bloc/user_phone_otp/auth_cubit.dart';
import 'controllers/bloc/user_phone_otp/auth_state.dart';
import 'helper/shared_pref_helper.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  log('Handling  a background message ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
                locale: const Locale('en', 'US'),
                debugShowCheckedModeBanner: false,
                home: BlocBuilder<AuthCubit, AuthState>(
                  buildWhen: (oldState, newState) {
                    return oldState is AuthInitialState;
                  },
                  builder: (context, state) {
                    if (state is AuthLoggedInState) {
                      return SelectLanguage();
                    } else if (state is AuthLoggedOutState) {
                      return SelectLanguage();
                    }
                    return SelectLanguage();
                  },
                ),
              ),
            ),
          );
        });
  }
}
