import 'package:dujo_kerala_application/firebase_options.dart';
import 'package:dujo_kerala_application/view/pages/sign_up/student_sign_up/parent_sign_up.dart';
import 'package:dujo_kerala_application/view/pages/sign_up/student_sign_up/student_sign_up.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() async {
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
          return  GetMaterialApp(
            home: ParentSignUp(),
            //asdfsdf
            //sdfsdfsdf
          );
        });
  }
}
