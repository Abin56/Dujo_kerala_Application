import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/teacher_home/class_test_controller/class_test_show_controller.dart';
import '../../../../controllers/teacher_home/class_test_list_controller.dart';
import '../../../../utils/utils.dart';
import '../../../colors/colors.dart';
import 'class_test_show_page.dart';

class ClassTestListPage extends StatelessWidget {
  ClassTestListPage({super.key});
  final ClassListShowController classListShowController =
      Get.put(ClassListShowController());
  final ShowTestController classShowController = Get.put(ShowTestController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: adminePrimayColor,
          title: const Text("All Test"),
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
                        trailing: const Icon(Icons.arrow_forward_ios, size: 17),
                        onTap: () {
                          classShowController.selectedClassTestModel =
                              classListShowController.allClassTestList[index];
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ClassTestShowPage(),
                            ),
                          );
                          classShowController.assigningValuesToControllers();
                        },
                      ),
                    );
                  },
                ),
        ));
  }
}
