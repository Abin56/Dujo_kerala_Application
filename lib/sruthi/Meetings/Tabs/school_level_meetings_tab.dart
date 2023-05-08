import 'package:dujo_kerala_application/sruthi/Meetings/meetings_school_display.dart';
import 'package:dujo_kerala_application/utils/utils.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controllers/student_controller/student_meeting_controller.dart';
import '../../../view/constant/sizes/sizes.dart';
import '../../../view/widgets/fonts/google_poppins.dart';

class SchoolLevelMeetingPage extends StatelessWidget {
  SchoolLevelMeetingPage({super.key});
  final StudentMeetingController studentMeetingController =
      Get.put(StudentMeetingController());

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await studentMeetingController.getMeetings();
    });

    if (studentMeetingController.meetingLists.isEmpty) {
      return const Material(
        child: Center(
          child: Text("Empty meeting list"),
        ),
      );
    }
    return Obx(
      () => studentMeetingController.isLoading.value
          ? circularProgressIndicatotWidget
          : Scaffold(
              appBar: AppBar(
                backgroundColor: adminePrimayColor,
                title: const Text("Meeting"),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: studentMeetingController.meetingLists.isEmpty
                        ? const Center(
                            child: Text("No Data Found"),
                          )
                        : ListView.builder(
                            itemCount:
                                studentMeetingController.meetingLists.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ListTile(
                                      leading:
                                          const Icon(Icons.message_outlined),
                                      trailing: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  MeetingDisplaySchoolLevel(
                                                meetingModel:
                                                    studentMeetingController
                                                        .meetingLists[index],
                                              ),
                                            ),
                                          );
                                        },
                                        child: GooglePoppinsWidgets(
                                          text: "View",
                                          fontsize: 16.h,
                                          color: Colors.blue,
                                        ),
                                      ),
                                      title: Padding(
                                        padding: EdgeInsets.only(top: 10.h),
                                        child: GooglePoppinsWidgets(
                                            text: studentMeetingController
                                                .meetingLists[index].heading,
                                            fontsize: 19.h),
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(top: 10.h),
                                            child: GooglePoppinsWidgets(
                                                text:
                                                    "Date : ${studentMeetingController.meetingLists[index].date}",
                                                fontsize: 14.h),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 10.h),
                                            child: GooglePoppinsWidgets(
                                                text:
                                                    "Time : ${studentMeetingController.meetingLists[index].time}",
                                                fontsize: 14.h),
                                          ),
                                        ],
                                      )),
                                  const Divider(),
                                  kHeight10
                                ],
                              );
                            }),
                  ),
                ],
              ),
            ),
    );
  }
}
