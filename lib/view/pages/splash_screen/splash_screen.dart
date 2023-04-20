import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../fonts/fonts.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              height: 200.h,
              width: 200.w,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/leptonlogo.png'))),
            ),
          ),
          Text(
            "Lepton DuJo",
            style: DGoogleFonts.headTextStyleMont,
          )
        ],
      )),
    );
  }
}
