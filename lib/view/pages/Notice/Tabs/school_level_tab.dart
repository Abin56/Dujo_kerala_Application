import 'package:dujo_kerala_application/view/pages/Notice/notice_school_display_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../controllers/student_controller/student_notice_controller/student_notice_controller.dart';
import '../../../widgets/fonts/google_poppins.dart';

class SchoolLevelNoticePage extends StatelessWidget {
  SchoolLevelNoticePage({super.key});

  final StudentNoticeController studentNoticeController =
      Get.put(StudentNoticeController());

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await studentNoticeController.getSchoolLevelNotices();
    });

    return Scaffold(
        backgroundColor: Colors.grey.withOpacity(0.2),
        body: studentNoticeController.schoolLevelNoticeLists.isEmpty
            ? const Center(
                child: Text("No Data Found"),
              )
            : ListView.separated(
             //   reverse: true,
                itemCount:
                    studentNoticeController.schoolLevelNoticeLists.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding:
                         EdgeInsets.only(bottom: 10.h, right: 10.w, left: 10.w),
                    child: Card(
                      child: ListTile(
                        shape: BeveledRectangleBorder(
                            side: BorderSide(
                                color: Colors.grey.withOpacity(0.2))),
                        leading: const Image(
                            image: NetworkImage(
                                "https://media.istockphoto.com/id/926144358/photo/portrait-of-a-little-bird-tit-flying-wide-spread-wings-and-flushing-feathers-on-white-isolated.jpg?b=1&s=170667a&w=0&k=20&c=DEARMqqAI_YoA5kXtRTyYTYU9CKzDZMqSIiBjOmqDNY=")),
                        title: GooglePoppinsWidgets(
                          fontsize: 22.h,
                          text: studentNoticeController
                              .schoolLevelNoticeLists[index].heading,
                        ),
                        subtitle: GooglePoppinsWidgets(
                          fontsize: 14.h,
                          text: studentNoticeController
                              .schoolLevelNoticeLists[index].publishedDate,
                        ),
                        trailing: InkWell(
                          child: GooglePoppinsWidgets(
                              text: "View".tr,
                              fontsize: 16.h,
                              fontWeight: FontWeight.w300,
                              color: Colors.blue),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NoticeClassDisplayPage(
                                      noticeModel: studentNoticeController
                                          .schoolLevelNoticeLists[index]),
                                ));
                          },
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Text('');
                },
              ));
  }
}
