import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controllers/teacher_home/class_test_controller/class_test_show_controller.dart';
import '../../../../../utils/utils.dart';
import '../../../../constant/sizes/sizes.dart';
import 'test_details_widget.dart';

class TestDataWidget extends StatelessWidget {
  TestDataWidget({
    super.key,
    required this.size,
  });

  final Size size;
  final ShowTestController classShowController = Get.put(ShowTestController());

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height / 2.2,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: cgrey1,
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListView(
        controller: ScrollController(),
        shrinkWrap: true,
        children: [
          kHeight10,
          const Text(
            "Test Details",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
          kHeight30,
          TestDetailsWidget(
            testName: "Test Name",
            testDetails:
                classShowController.selectedClassTestModel?.testName ?? "",
            voidCallback: () async {
              await showMyDialog(context, "testName");
            },
          ),
          kHeight10,
          TestDetailsWidget(
              testName: "Subject Name",
              testDetails:
                  classShowController.selectedClassTestModel?.subjectName ?? "",
              voidCallback: () async {
                await showMyDialog(context, "subjectName");
              }),
          kHeight10,
          TestDetailsWidget(
              voidCallback: () async {
                final int date = await dateTimePickerTimeStamp(context);
                if (date != -1) {
                  await classShowController.updateStudentsData(
                      key: "date", value: date);
                }
              },
              testName: "Date",
              testDetails: timeStampToDateFormat(
                  classShowController.selectedClassTestModel?.date ?? -1)),
          kHeight10,
          TestDetailsWidget(
              voidCallback: () async {
                final String time = await timePicker(context);
                if (time.isNotEmpty) {
                  await classShowController.updateStudentsData(
                      key: "time", value: time);
                }
              },
              testName: "Time",
              testDetails:
                  classShowController.selectedClassTestModel?.time ?? ""),
          kHeight10,
          TestDetailsWidget(
              testName: "Description",
              testDetails:
                  classShowController.selectedClassTestModel?.description ?? "",
              voidCallback: () async {
                await showMyDialog(context, "description");
              }),
        ],
      ),
    );
  }

  Future<void> showMyDialog(BuildContext context, String key) async {
    TextEditingController textEditingController = TextEditingController();

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Value'),
          content: TextFormField(
            controller: textEditingController,
            decoration: const InputDecoration(
              hintText: 'Enter your text',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                if (textEditingController.text.isNotEmpty) {
                  Navigator.pop(context);
                  await classShowController.updateStudentsData(
                      key: key, value: textEditingController.text);
                } else {
                  return showToast(msg: "Field is empty");
                }
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }
}
