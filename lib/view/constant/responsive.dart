import 'package:flutter/material.dart';

class ResponsiveApp {
  static late MediaQueryData _mediaQueryData;

  static MediaQueryData get mq => _mediaQueryData;
  static void serMq(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
  }
}
