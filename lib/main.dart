import 'package:dujo_kerala_application/firebase_options.dart';
import 'package:dujo_kerala_application/view/pages/live_classes/enter_to_live.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'helper/shared_pref_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await ScreenUtil.ensureScreenSize();
  //creating shared preference
  await SharedPreferencesHelper.initPrefs(); 
   ScreenUtil.ensureScreenSize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:  LiveClassRoom(
                        roomID: '2323',
                    ),
    );
    // return ScreenUtilInit(
    //     minTextAdapt: true,
    //     splitScreenMode: true,
    //     designSize: const Size(423.5294196844927, 945.8823706287004),
    //     builder: (context, child) {
    //       return BlocProvider(
    //           create: (context) => AuthCubit(),
    //           child: GetMaterialApp(
    //             debugShowCheckedModeBanner: false,
    //             home: BlocBuilder<AuthCubit, AuthState>(
    //               buildWhen: (oldState, newState) {
    //                 return oldState is AuthInitialState;
    //               },
    //               builder: (context, state) {
    //                 if (state is AuthLoggedInState) {
    //                   return const SplashScreen();
    //                 } else if (state is AuthLoggedOutState) {
    //                   return const SplashScreen();
    //                 }
    //                 return const SplashScreen();
    //               },
    //             ),

    //             // LoginVerification(),
    //           ));
    //     });
  }
}
