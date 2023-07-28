import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/all_class_test_show/all_class_test_show_controller.dart';
import '../../colors/colors.dart';
import '../../constant/sizes/sizes.dart';

class AllClassTestShowPage extends StatelessWidget {
  AllClassTestShowPage({super.key});
  final AllClassListShowController allClassListShowController =
      Get.put(AllClassListShowController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: adminePrimayColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            //Test Details

            // TestDataWidget(size: size),
            //Student Score
            kHeight20,
            DecoratedBox(
              decoration: BoxDecoration(
                  color: cgrey1, borderRadius: BorderRadius.circular(20)),
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
                            child: Text((allClassListShowController
                                        .classTestModel?.totalMark ??
                                    "")
                                .toString())))
                  ],
                ),
              ),
            ),

            kHeight20,

            DecoratedBox(
              decoration: BoxDecoration(
                  color: cgrey1, borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListView.separated(
                  controller: ScrollController(),
                  shrinkWrap: true,
                  itemCount: allClassListShowController
                          .classTestModel?.studentDetails.length ??
                      0,
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                          child: SizedBox(
                            width: size.width / 2,
                            child: Text(
                              allClassListShowController.classTestModel
                                      ?.studentDetails[index].studentId ??
                                  "",
                              style: const TextStyle(fontSize: 19),
                            ),
                          ),
                        ),
                        Flexible(
                          child: SizedBox(
                            width: 80,
                            height: 50,
                            child: Text(
                              (allClassListShowController.classTestModel
                                          ?.studentDetails[index].mark ??
                                      "")
                                  .toString(),
                              style: const TextStyle(fontSize: 19),
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
          ],
        ),
      ),
    );
  }
}
