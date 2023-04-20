// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GoogleOswaldtWidgets extends StatelessWidget {
  String text;
  double fontsize;
  FontWeight? fontWeight;
  double? letterSpacing;
  Color? color;
  GoogleOswaldtWidgets({
    required this.text,
    required this.fontsize,
    this.fontWeight,
    this.color,
    this.letterSpacing,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.montserrat(
        letterSpacing: letterSpacing,
        fontSize: fontsize,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }
}
