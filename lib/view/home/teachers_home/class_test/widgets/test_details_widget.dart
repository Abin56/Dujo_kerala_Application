import 'package:flutter/material.dart';

class TestDetailsWidget extends StatelessWidget {
  const TestDetailsWidget({
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
                width: 200,
                child: Text(
                  testName,
                  style: const TextStyle(fontSize: 18),
                ))),
        const Flexible(child: Text(":")),
        Flexible(
          child: SizedBox(
            width: 200,
            child: Row(
              children: [
                Flexible(child: Text(testDetails)),
                Flexible(
                  child: IconButton(
                    onPressed: voidCallback,
                    icon: const Icon(
                      Icons.edit,
                      size: 17,
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
