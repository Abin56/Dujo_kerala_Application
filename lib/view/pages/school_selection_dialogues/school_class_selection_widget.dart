import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'school_class_selection_controller.dart';
import 'widgets/school_select_dialogue_widget.dart';

class SchoolClassSelectionScreen extends StatelessWidget {
  SchoolClassSelectionScreen({super.key});
  final SchoolClassSelectionController schoolClassSelectionController =
      Get.put(SchoolClassSelectionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await showDialogueSchoolSelection(context);
          },
          child: const Text(
            "Press",
          ),
        ),
      ),
    );
  }
}


