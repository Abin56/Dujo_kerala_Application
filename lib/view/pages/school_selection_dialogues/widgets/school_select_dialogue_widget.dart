import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/utils.dart';
import '../school_class_selection_controller.dart';
import 'school_selection_dropdown_widget.dart';

Future<dynamic> showDialogueSchoolSelection(BuildContext context) {
  final controller = Get.find<SchoolClassSelectionController>();
  return showDialog(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      if (controller.schoolModelList.isEmpty) {
        return const Center(
          child: Text("No Data Found"),
        );
      }
      return AlertDialog(
        title: Text('Select Your School'.tr),
        content: DropDownWidget(
            value: controller.schoolId,
            items: controller.schoolModelList
                .map(
                  (e) => DropdownMenuItem(
                    value: e.id,
                    child: Text(e.schoolName),
                  ),
                )
                .toList(),
            onChanged: (value) {
              controller.schoolId = value;
              controller.batchId = null;
            }),
        actions: <Widget>[
          TextButton(
            child: Text('ok'.tr),
            onPressed: () async {
              if (controller.schoolId == null) {
                return showToast(msg: "Please Select School");
              }
              await controller.getBatachDetails();
              if (context.mounted) {}
              if (controller.batchList.isEmpty) {
                return showToast(msg: "No Batch Found");
              } else {
                await showDialogueBatchYearSelect(context);
              }
            },
          ),
          TextButton(
            child: Text('cancel'.tr),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Future<dynamic> showDialogueClassSelection(BuildContext context) {
  final controller = Get.find<SchoolClassSelectionController>();
  return showDialog(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Select Your Class'.tr),
        content: DropDownWidget(
            value: controller.classId,
            items: controller.classModelList
                .map(
                  (e) => DropdownMenuItem(
                    value: e.classId,
                    child: Text(e.className),
                  ),
                )
                .toList(),
            onChanged: (value) {
              controller.classId = value;
            }),
        actions: <Widget>[
          TextButton(
            child: Text('ok'.tr),
            onPressed: () async {
              if (controller.classId == null) {
                return showToast(msg: "Please Select Class");
              } else {}
            },
          ),
          TextButton(
            child: Text('cancel'.tr),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Future<dynamic> showDialogueBatchYearSelect(BuildContext context) {
  final controller = Get.find<SchoolClassSelectionController>();
  return showDialog(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Select Batch'.tr),
        content: DropDownWidget(
            value: controller.batchId,
            items: controller.batchList
                .map(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  ),
                )
                .toList(),
            onChanged: (value) {
              controller.batchId = value;
              controller.classId = null;
            }),
        actions: <Widget>[
          TextButton(
            child: Text('ok'.tr),
            onPressed: () async {
              if (controller.batchId == null) {
                return showToast(msg: "Please Select Batch");
              } else {
                await controller.fetchAllClassData();
                if (context.mounted) {
                  await showDialogueClassSelection(context);
                }
              }
            },
          ),
          TextButton(
            child: Text('cancel'.tr),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
