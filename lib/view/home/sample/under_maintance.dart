import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class UnderMaintanceScreen extends StatelessWidget {
  const UnderMaintanceScreen({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
         
            children: [
                
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  LottieBuilder.network(
                    'https://assets8.lottiefiles.com/packages/lf20_TLbeE6oxm5.json',
                    height: 300,
                  ),
                  kHeight10,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Under Maintenance$text",
                        style: GoogleFonts.poppins(
                            fontSize: 18,
                            color: const Color.fromARGB(255, 34, 34, 34)),
                      ),
                      LottieBuilder.network(
                        'https://assets1.lottiefiles.com/packages/lf20_yyoe1mkr.json',
                        height: 100,
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
