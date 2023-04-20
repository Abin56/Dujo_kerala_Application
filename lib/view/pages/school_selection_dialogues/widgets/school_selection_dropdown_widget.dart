import 'package:flutter/material.dart';

class DropDownWidget extends StatelessWidget {
  const DropDownWidget({
    super.key,
    required this.value,
    this.items,
    this.onChanged,
  });
  final String? value;
  final List<DropdownMenuItem<String>>? items;
  final void Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      hint: const Text("Select School"),
      isExpanded: true,
      value: value,
      items: items,
      onChanged: onChanged,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent, width: 0.5),
          borderRadius: BorderRadius.circular(20),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent, width: 0.5),
          borderRadius: BorderRadius.circular(20),
        ),
        filled: true,
      ),
    );
  }
}
