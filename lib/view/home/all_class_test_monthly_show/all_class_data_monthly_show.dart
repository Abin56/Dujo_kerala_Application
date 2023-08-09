import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/all_class_test_show/all_class_test_monthly_show_controller.dart';
import '../../../controllers/userCredentials/user_credentials.dart';
import '../../../model/teacher_home/test_class_model/test_class_model.dart';
import '../../../utils/utils.dart';
import '../../colors/colors.dart';
import '../../constant/responsive.dart';
import '../../constant/sizes/sizes.dart';

class AllClassTestMonthlyShowPage extends StatelessWidget {
  AllClassTestMonthlyShowPage({super.key, required this.navigationPageName});
  final AllClassListMonthlyShowController controller =
      Get.put(AllClassListMonthlyShowController());
  final String navigationPageName;

  @override
  Widget build(BuildContext context) {
    final ClassTestModel? studentModel = controller.classTestModel;
    final num? totalMark = studentModel?.totalMark;

    final List<StudentClassMarkModel>? studentList =
        studentModel?.studentDetails;

    final String totalMarkvalue =
        (totalMark == -1 ? "Mark not entered" : totalMark).toString();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: adminePrimayColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              //Test Details

              Container(
                height: ResponsiveApp.height / 1.5,
                padding: const EdgeInsets.all(10),
                alignment: Alignment.center,
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
                      testDetails: controller.classTestModel?.testName ?? "",
                    ),
                    kHeight10,
                    AllClassTestDetailsWidget(
                      testName: "Subject Name",
                      testDetails: controller.classTestModel?.subjectName ?? "",
                    ),
                    kHeight10,
                    AllClassTestDetailsWidget(
                        testName: "Date",
                        testDetails: timeStampToDateFormat(
                            controller.classTestModel?.date ?? -1)),
                    kHeight10,
                    AllClassTestDetailsWidget(
                        testName: "Time",
                        testDetails: controller.classTestModel?.time ?? ""),
                    kHeight10,
                    AllClassTestDetailsWidget(
                      testName: "Description",
                      testDetails: controller.classTestModel?.description ?? "",
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
                              child: Text(
                                "Out of mark",
                                style: TextStyle(
                                    fontSize: ResponsiveApp.width * .04),
                              ))),
                      Flexible(
                        child: SizedBox(
                          width: 80,
                          child: Text(
                            (totalMarkvalue).toString(),
                            style:
                                TextStyle(fontSize: ResponsiveApp.width * .04),
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
                      itemCount:
                          controller.classTestModel?.studentDetails.length ?? 0,
                      itemBuilder: (context, index) {
                        String mark = (studentList?[index].mark == -1
                                ? "Mark not entered"
                                : studentList?[index].mark)
                            .toString();

                        if (navigationPageName == "student" &&
                            studentList?[index].studentId ==
                                UserCredentialsController.studentModel?.docid) {
                          return DataShowWidget(
                            mark: mark,
                            studentId: studentList?[index].studentId ?? "",
                          );
                        } else if (navigationPageName == "parent" &&
                            studentList?[index].studentId ==
                                UserCredentialsController
                                    .parentModel?.studentID) {
                          return DataShowWidget(
                            mark: mark,
                            studentId: studentList?[index].studentId ?? "",
                          );
                        } else if (navigationPageName == "guardian" &&
                            studentList?[index].studentId ==
                                UserCredentialsController
                                    .guardianModel?.studentID) {
                          return DataShowWidget(
                            mark: mark,
                            studentId: studentList?[index].studentId ?? "",
                          );
                        } else {
                          return const SizedBox();
                        }
                      }),
                ),
              ),
            ],
          ),
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
            width: ResponsiveApp.mq.size.width / 2,
            child: Text(
              testName,
              style: TextStyle(fontSize: ResponsiveApp.width * .04),
            ),
          ),
        ),
        const Flexible(child: Text(":")),
        SizedBox(
            width: ResponsiveApp.mq.size.width / 2.5,
            child: Text(
              testDetails,
              style: TextStyle(fontSize: ResponsiveApp.width * .04),
            )),
      ],
    );
  }
}

class DataShowWidget extends StatelessWidget {
  DataShowWidget({super.key, required this.mark, required this.studentId});

  final String mark;
  final String studentId;
  final AllClassListMonthlyShowController controller =
      Get.put(AllClassListMonthlyShowController());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: controller.getStudentData(studentId: studentId),
        builder: (context, snapshot) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                child: SizedBox(
                  width: ResponsiveApp.width / 2,
                  child: Text(
                    snapshot.data?.studentName ?? "",
                    style: TextStyle(fontSize: ResponsiveApp.width * .04),
                  ),
                ),
              ),
              Flexible(
                child: SizedBox(
                  width: 80,
                  child: Text(
                    mark,
                    style: TextStyle(fontSize: ResponsiveApp.width * .04),
                  ),
                ),
              )
            ],
          );
        });
  }
}
