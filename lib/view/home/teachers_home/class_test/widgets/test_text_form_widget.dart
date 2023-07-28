import 'package:flutter/material.dart';

class TestTextFormWidget extends StatelessWidget {
  const TestTextFormWidget({
    super.key,
    required this.label,
    required this.icons,
    this.readOnly = false,
    this.voidCallback,
    this.onTap,
    this.textEditingController,
  });
  final String label;
  final IconData icons;
  final bool readOnly;
  final void Function(String e)? voidCallback;
  final VoidCallback? onTap;
  final TextEditingController? textEditingController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      readOnly: readOnly,
      maxLines: null,
      onChanged: voidCallback,
      onTap: onTap,
      decoration: InputDecoration(
        label: Text(label),
        prefixIcon: Icon(icons),
      ),
    );
  }
}
