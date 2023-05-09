import 'package:dujo_kerala_application/controllers/student_controller/student_notice_controller/student_notice_controller.dart';
import 'package:dujo_kerala_application/view/pages/Notice/notice_class_display_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../constant/sizes/sizes.dart';
import '../../../widgets/fonts/google_poppins.dart';

class ClassLevelNoticePage extends StatelessWidget {
  ClassLevelNoticePage({super.key});

  final StudentNoticeController studentNoticeController =
      Get.put(StudentNoticeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: studentNoticeController.classLevelNoticeLists.isEmpty
            ? const Center(
                child: Text("Data Not Found"),
              )
            : ListView.builder(
                itemCount: studentNoticeController.classLevelNoticeLists.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.blue[50],
                            border:
                                const Border(bottom: BorderSide(width: 0.09))),
                        child: ListTile(
                          leading: const Image(
                              image: NetworkImage(
                                  "https://media.istockphoto.com/id/926144358/photo/portrait-of-a-little-bird-tit-flying-wide-spread-wings-and-flushing-feathers-on-white-isolated.jpg?b=1&s=170667a&w=0&k=20&c=DEARMqqAI_YoA5kXtRTyYTYU9CKzDZMqSIiBjOmqDNY=")),
                          title: GooglePoppinsWidgets(
                            fontsize: 22.h,
                            text: studentNoticeController
                                .classLevelNoticeLists[index].heading,
                          ),
                          subtitle: GooglePoppinsWidgets(
                            fontsize: 14.h,
                            text: studentNoticeController
                                .classLevelNoticeLists[index].date,
                          ),
                          trailing: InkWell(
                            child: GooglePoppinsWidgets(
                                text: "View",
                                fontsize: 16.h,
                                fontWeight: FontWeight.w300,
                                color: Colors.blue),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        NoticeClassDisplayPage(
                                            classLevelNoticeModel:
                                                studentNoticeController
                                                        .classLevelNoticeLists[
                                                    index]),
                                  ));
                            },
                          ),
                        ),
                      ),
                      kHeight10,
                    ],
                  );
                }));
  }
}
