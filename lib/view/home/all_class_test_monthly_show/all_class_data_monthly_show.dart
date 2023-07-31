import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/all_class_test_show/all_class_test_monthly_show_controller.dart';
import '../../../controllers/userCredentials/user_credentials.dart';
import '../../../utils/utils.dart';
import '../../colors/colors.dart';
import '../../constant/responsive.dart';
import '../../constant/sizes/sizes.dart';

class AllClassTestMonthlyShowPage extends StatelessWidget {
  AllClassTestMonthlyShowPage({super.key, required this.navigationPageName});
  final AllClassListMonthlyShowController allClassListShowController =
      Get.put(AllClassListMonthlyShowController());
  final String navigationPageName;

  @override
  Widget build(BuildContext context) {
    final num? totalMark = allClassListShowController.classTestModel?.totalMark;

    final String totalMarkvalue =
        (totalMark == -1 ? "Mark not entered" : totalMark).toString();
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

            Container(
              height: ResponsiveApp.mq.size.height / 2.2,
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
                  AllClassTestDetailsWidget(
                    testName: "Test Name",
                    testDetails:
                        allClassListShowController.classTestModel?.testName ??
                            "",
                  ),
                  kHeight10,
                  AllClassTestDetailsWidget(
                    testName: "Subject Name",
                    testDetails: allClassListShowController
                            .classTestModel?.subjectName ??
                        "",
                  ),
                  kHeight10,
                  AllClassTestDetailsWidget(
                      testName: "Date",
                      testDetails: timeStampToDateFormat(
                          allClassListShowController.classTestModel?.date ??
                              -1)),
                  kHeight10,
                  AllClassTestDetailsWidget(
                      testName: "Time",
                      testDetails:
                          allClassListShowController.classTestModel?.time ??
                              ""),
                  kHeight10,
                  AllClassTestDetailsWidget(
                    testName: "Description",
                    testDetails: allClassListShowController
                            .classTestModel?.description ??
                        "",
                  ),
                ],
              ),
            ),
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
                            width: ResponsiveApp.mq.size.width / 2,
                            child: const Text(
                              "Out Of Mark",
                              style: TextStyle(fontSize: 20),
                            ))),
                    Flexible(
                      child: SizedBox(
                        width: 80,
                        child: Text(
                          (totalMarkvalue).toString(),
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                    )
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
                child: ListView.builder(
                    controller: ScrollController(),
                    shrinkWrap: true,
                    itemCount: allClassListShowController
                            .classTestModel?.studentDetails.length ??
                        0,
                    itemBuilder: (context, index) {
                      String value = "";
                      if (navigationPageName == "student") {
                        if (allClassListShowController.classTestModel
                                ?.studentDetails[index].studentId ==
                            UserCredentialsController.studentModel?.docid) {
                          final num? mark = allClassListShowController
                              .classTestModel?.studentDetails[index].mark;

                          value = (mark == -1 ? "Mark not entered" : mark)
                              .toString();

                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: FutureBuilder(
                                    future: allClassListShowController
                                        .getStudentData(
                                      studentId: allClassListShowController
                                              .classTestModel
                                              ?.studentDetails[index]
                                              .studentId ??
                                          "",
                                    ),
                                    builder: (
                                      context,
                                      snapshot,
                                    ) {
                                      return SizedBox(
                                        width: ResponsiveApp.mq.size.width / 2,
                                        child: Text(
                                          snapshot.data?.studentName ?? "",
                                          style: const TextStyle(fontSize: 19),
                                        ),
                                      );
                                    }),
                              ),
                              Flexible(
                                child: SizedBox(
                                  width: 80,
                                  child: Text(
                                    (value).toString(),
                                    style: const TextStyle(fontSize: 19),
                                  ),
                                ),
                              )
                            ],
                          );
                        } else {
                          return const SizedBox();
                        }
                      } else if (navigationPageName == "parent") {
                        if (allClassListShowController.classTestModel
                                ?.studentDetails[index].studentId ==
                            UserCredentialsController.parentModel?.studentID) {
                          final num? mark = allClassListShowController
                              .classTestModel?.studentDetails[index].mark;

                          value = (mark == -1 ? "Mark not entered" : mark)
                              .toString();

                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: FutureBuilder(
                                    future: allClassListShowController
                                        .getStudentData(
                                      studentId: allClassListShowController
                                              .classTestModel
                                              ?.studentDetails[index]
                                              .studentId ??
                                          "",
                                    ),
                                    builder: (
                                      context,
                                      snapshot,
                                    ) {
                                      if (snapshot.hasData) {
                                        return SizedBox(
                                          width:
                                              ResponsiveApp.mq.size.width / 2,
                                          child: Text(
                                            snapshot.data?.studentName ?? "",
                                            style:
                                                const TextStyle(fontSize: 19),
                                          ),
                                        );
                                      } else if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return circularProgressIndicatotWidget;
                                      } else {
                                        return const SizedBox();
                                      }
                                    }),
                              ),
                              Flexible(
                                child: SizedBox(
                                  width: 80,
                                  child: Text(
                                    (value).toString(),
                                    style: const TextStyle(fontSize: 19),
                                  ),
                                ),
                              )
                            ],
                          );
                        }
                      } else {
                        return const SizedBox();
                      }
                      return const SizedBox();
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AllClassTestDetailsWidget extends StatelessWidget {
  const AllClassTestDetailsWidget({
    super.key,
    required this.testName,
    required this.testDetails,
  });
  final String testName;
  final String testDetails;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Flexible(
          child: SizedBox(
            width: 200,
            child: Text(
              testName,
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ),
        const Flexible(child: Text(":")),
        SizedBox(
            width: 200,
            child: Text(
              testDetails,
              style: const TextStyle(fontSize: 15),
            )),
      ],
    );
  }
}
