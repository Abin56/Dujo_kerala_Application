import 'package:flutter/material.dart';

import '../../../../constant/responsive.dart';

class TestDetailsMonthlyWidget extends StatelessWidget {
  const TestDetailsMonthlyWidget({
    super.key,
    required this.testName,
    required this.testDetails,
    this.voidCallback,
  });
  final String testName;
  final String testDetails;
  final VoidCallback? voidCallback;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Flexible(
            child: SizedBox(
                width: ResponsiveApp.width / 2,
                child: Text(
                  testName,
                  style: TextStyle(fontSize: ResponsiveApp.width * .04),
                ))),
        const Flexible(child: Text(":")),
        Flexible(
          child: SizedBox(
            width: ResponsiveApp.width / 2.5,
            child: Row(
              children: [
                Flexible(child: Text(testDetails)),
                Flexible(
                  child: IconButton(
                    onPressed: voidCallback,
                    icon: const Icon(
                      Icons.edit,
                      size: 15,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
