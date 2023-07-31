import 'package:dujo_kerala_application/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/teacher_home/class_test_controller/monthly_controllers/class_test_show_monthly_controller.dart';
import '../../../colors/colors.dart';
import '../../../constant/sizes/sizes.dart';
import 'widgets/test_button_monthly_widget.dart';
import 'widgets/test_data_monthly_widget.dart';

class ClassTestMonthlyShowPage extends StatelessWidget {
  ClassTestMonthlyShowPage({super.key});

  final ShowTestMonthlyController showTestController =
      Get.put(ShowTestMonthlyController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: adminePrimayColor,
      ),
      body: Obx(
        () => showTestController.isLoading.value
            ? circularProgressIndicatotWidget
            : Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    //Test Details

                    TestDataMonthlyWidget(size: size),
                    //Student Score
                    kHeight20,
                    DecoratedBox(
                      decoration: BoxDecoration(
                          color: cgrey1,
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(
                                child: SizedBox(
                                    width: size.width / 2,
                                    child: const Text(
                                      "Out Of Mark",
                                      style: TextStyle(fontSize: 20),
                                    ))),
                            Flexible(
                                child: SizedBox(
                                    width: 80,
                                    height: 50,
                                    child: TextField(
                                      controller: showTestController
                                          .totalMarkController,
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                      ),
                                    )))
                          ],
                        ),
                      ),
                    ),

                    kHeight20,

                    DecoratedBox(
                      decoration: BoxDecoration(
                          color: cgrey1,
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: ListView.separated(
                          controller: ScrollController(),
                          shrinkWrap: true,
                          itemCount: showTestController
                              .textEditingcontrollerMap.length,
                          itemBuilder: (context, index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Flexible(
                                    child: SizedBox(
                                        width: size.width / 2,
                                        child: FutureBuilder(
                                            future: showTestController
                                                .getStudentData(
                                                    studentId: showTestController
                                                        .textEditingcontrollerMap
                                                        .keys
                                                        .toList()[index]),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                return Text(
                                                  snapshot.data?.studentName ??
                                                      "",
                                                  style: const TextStyle(
                                                      fontSize: 19),
                                                );
                                              } else {
                                                return const Text(" ");
                                              }
                                            }))),
                                Flexible(
                                  child: SizedBox(
                                    width: 80,
                                    height: 50,
                                    child: TextField(
                                      controller: showTestController
                                          .textEditingcontrollerMap.values
                                          .toList()[index],
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: "Mark"),
                                    ),
                                  ),
                                )
                              ],
                            );
                          },
                          separatorBuilder: (context, index) {
                            return kHeight20;
                          },
                        ),
                      ),
                    ),
                    kHeight20,
                    TestMonthlyElevatedButton(
                      title: "Update",
                      voidCallback: () async {
                        await showTestController.updateStudentsMark(
                            context: context);
                      },
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
