import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controllers/teacher_home/class_test_controller/monthly_controllers/class_test_show_monthly_controller.dart';
import '../../../../../utils/utils.dart';
import '../../../../constant/sizes/sizes.dart';
import 'test_details_monthly_widget.dart';

class TestDataMonthlyWidget extends StatelessWidget {
  TestDataMonthlyWidget({
    super.key,
    required this.size,
  });

  final Size size;
  final ShowTestMonthlyController showTestController =
      Get.put(ShowTestMonthlyController());

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
          TestDetailsMonthlyWidget(
            testName: "Test Name",
            testDetails:
                showTestController.selectedClassTestModel?.testName ?? "",
            voidCallback: () async {
              await showMyDialog(context, "testName");
            },
          ),
          kHeight10,
          TestDetailsMonthlyWidget(
              testName: "Subject Name",
              testDetails:
                  showTestController.selectedClassTestModel?.subjectName ?? "",
              voidCallback: () async {
                await showMyDialog(context, "subjectName");
              }),
          kHeight10,
          TestDetailsMonthlyWidget(
              voidCallback: () async {
                final int date = await dateTimePickerTimeStamp(context);
                if (date != -1) {
                  await showTestController.updateStudentsData(
                      key: "date", value: date);
                }
              },
              testName: "Date",
              testDetails: timeStampToDateFormat(
                  showTestController.selectedClassTestModel?.date ?? -1)),
          kHeight10,
          TestDetailsMonthlyWidget(
              voidCallback: () async {
                final String time = await timePicker(context);
                if (time.isNotEmpty) {
                  await showTestController.updateStudentsData(
                      key: "time", value: time);
                }
              },
              testName: "Time",
              testDetails:
                  showTestController.selectedClassTestModel?.time ?? ""),
          kHeight10,
          TestDetailsMonthlyWidget(
              testName: "Description",
              testDetails:
                  showTestController.selectedClassTestModel?.description ?? "",
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
                  await showTestController.updateStudentsData(
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
