import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/teacher_home/class_test_controller/monthly_controllers/class_test_list_monthly_controllers.dart';
import '../../../../controllers/teacher_home/class_test_controller/monthly_controllers/class_test_show_monthly_controller.dart';
import '../../../../controllers/teacher_home/class_test_controller/test_notification_controller.dart';
import '../../../../model/teacher_home/test_class_model/test_class_model.dart';
import '../../../../utils/utils.dart';
import '../../../colors/colors.dart';
import 'class_test_monthly_show_page.dart';

class ClassMonthlyTestListPage extends StatelessWidget {
  ClassMonthlyTestListPage({super.key});
  final ClassListMonthlyShowController classListShowController =
      Get.put(ClassListMonthlyShowController());
  final ShowTestMonthlyController classShowController =
      Get.put(ShowTestMonthlyController());
  final TestNotificationController testNotificationController =
      Get.put(TestNotificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: adminePrimayColor,
          title:  Text("All Test".tr),
        ),
        body: Obx(
          () => classListShowController.isLoading.value
              ? circularProgressIndicatotWidget
              : ListView.builder(
                  itemCount: classListShowController.allClassTestList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: cgrey1,
                      child: ListTile(
                        leading: const Icon(Icons.notes),
                        title: Text(classListShowController
                            .allClassTestList[index].testName),
                        subtitle: Text(timeStampToDateFormat(
                            classListShowController
                                .allClassTestList[index].date)),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                                tooltip:
                                    "Send test Notifiaction to students&parents",
                                onPressed: () async {
                                  ClassTestModel cModel =
                                      classListShowController
                                          .allClassTestList[index];

                                  String date =
                                      timeStampToDateFormat(cModel.date);

                                  await testNotificationController
                                      .sendTestNotification(
                                    classId: cModel.classId,
                                    body:
                                        "Test Name : ${cModel.testName} Date : $date time : ${cModel.time.toString()}",
                                    title: "New test created",
                                  );
                                },
                                icon: const Icon(Icons.notifications)),
                            const Icon(Icons.arrow_forward_ios, size: 17),
                          ],
                        ),
                        onTap: () {
                          classShowController.selectedClassTestModel =
                              classListShowController.allClassTestList[index];
                          classShowController.assigningValuesToControllers();
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ClassTestMonthlyShowPage(),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
        ));
  }
}
