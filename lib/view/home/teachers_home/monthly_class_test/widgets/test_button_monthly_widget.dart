import 'package:flutter/material.dart';

import '../../../../colors/colors.dart';

class TestMonthlyElevatedButton extends StatelessWidget {
  const TestMonthlyElevatedButton({super.key, required this.title, this.voidCallback});

  final String title;
  final VoidCallback? voidCallback;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: adminePrimayColor,
          shape: const StadiumBorder(),
          minimumSize: const Size(double.infinity, 50)),
      onPressed: voidCallback,
      child: Text(title),
    );
  }
}
