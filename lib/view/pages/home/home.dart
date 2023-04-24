import 'package:flutter/material.dart';

import '../../widgets/fonts/google_poppins.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Center(
        child:     GooglePoppinsWidgets(
                    text: "Welcome Home",
                    fontsize: 20,
                    fontWeight: FontWeight.w700,
                  ),
      )),
    );
  }
}