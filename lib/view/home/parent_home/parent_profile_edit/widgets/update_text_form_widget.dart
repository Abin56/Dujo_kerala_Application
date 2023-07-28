import 'package:flutter/material.dart';

Widget updateTextFormField({
  required BuildContext context,
  required String hintText,
  required TextEditingController textEditingController,
  required VoidCallback voidCallback,
  required TextInputType textInputType,
}) {
  return AlertDialog(
    title: TextFormField(
      keyboardType: textInputType,
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: hintText,
      ),
    ),
    actions: [
      TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text("Cancel"),
      ),
      TextButton(
        onPressed: voidCallback,
        child: const Text("Submit"),
      ),
    ],
  );
}
