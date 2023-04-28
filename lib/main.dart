import 'package:dujo_kerala_application/controllers/bloc/user_phone_otp/auth_cubit.dart';
import 'package:dujo_kerala_application/controllers/bloc/user_phone_otp/auth_state.dart';
import 'package:dujo_kerala_application/firebase_options.dart';
import 'package:dujo_kerala_application/view/pages/splash_screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await ScreenUtil.ensureScreenSize();
 
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
              child: GetMaterialApp(
                debugShowCheckedModeBanner: false,
                home: BlocBuilder<AuthCubit, AuthState>(
                  buildWhen: (oldState, newState) {
                    return oldState is AuthInitialState;
                  },
                  builder: (context, state) {
                    if (state is AuthLoggedInState) {
                      return  SplashScreen();
                    } else if (state is AuthLoggedOutState) {
                      return  SplashScreen();
                    }
                    return  SplashScreen();
                  },
                ),

                // LoginVerification(),
              ));
        });
  }
}
