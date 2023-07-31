import 'package:dujo_kerala_application/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controllers/teacher_list/teacher_list_controller.dart';
import '../../colors/colors.dart';
import '../../constant/sizes/sizes.dart';
import '../../widgets/fonts/google_poppins.dart';

class TeacherSubjectWiseList extends StatelessWidget {
  String navValue;
  TeacherSubjectWiseList({required this.navValue, super.key});
  final TeacherListController teacherListController =
      Get.put(TeacherListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Teachers".tr,
        ),
        backgroundColor: adminePrimayColor,
      ),
      body: FutureBuilder(
          future: teacherListController.getAllSubjects(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return circularProgressIndicatotWidget;
            }
            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              return Column(
                children: [
                  kHeight10,
                  Expanded(
                    child: ListView.separated(
                        itemCount: snapshot.data!.length,
                        separatorBuilder: ((context, index) {
                          return kHeight10;
                        }),
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Container(
                                  decoration: const BoxDecoration(),
                                  child: FutureBuilder(
                                      future:
                                          teacherListController.getTeacherData(
                                              snapshot.data![index].teacherId),
                                      builder: (context, snap) {
                                        if (snap.connectionState ==
                                            ConnectionState.waiting) {
                                          return circularProgressIndicatotWidget;
                                        }
                                        if (snap.hasData) {
                                          return ListTile(
                                            shape: const BeveledRectangleBorder(
                                                side: BorderSide(
                                                    color: Colors.grey,
                                                    width: 0.2)),
                                            leading: CircleAvatar(
                                              radius: 25,
                                              backgroundImage: snap
                                                      .data!.imageUrl!.isEmpty
                                                  ? const NetworkImage(
                                                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTHQYMHHvI6NnOaZp9iU5Wa1MOhAwxzE0oRRw&usqp=CAU")
                                                  : NetworkImage(
                                                      snap.data!.imageUrl!),
                                              onBackgroundImageError:
                                                  (exception, stackTrace) {},
                                            ),
                                            title: Padding(
                                              padding:
                                                  EdgeInsets.only(top: 10.h),
                                              child: GooglePoppinsWidgets(
                                                text: snap.data!.teacherName ??
                                                    " ",
                                                fontsize: 21.h,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            subtitle: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 10.h),
                                                  child: GooglePoppinsWidgets(
                                                    text: snap.data!
                                                            .teacherEmail ??
                                                        " ",
                                                    fontsize: 14.h,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.blue,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 10.h),
                                                  child: GooglePoppinsWidgets(
                                                    text: snap.data!
                                                            .teacherPhNo ??
                                                        " ",
                                                    fontsize: 14.h,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 10.h),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      GooglePoppinsWidgets(
                                                        text: "Subject :".tr,
                                                        fontsize: 14.h,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                      Flexible(
                                                        child:
                                                            GooglePoppinsWidgets(
                                                          text: snapshot
                                                              .data![index]
                                                              .subjectName,
                                                          fontsize: 14.h,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              adminePrimayColor,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                        
                                          );
                                        } else {
                                          return kHeight;
                                        }
                                      }),
                                ),
                              ),
                            ],
                          );
                        }),
                  ),
                ],
              );
            } else {
              return const Center(
                child: Text("No data found"),
              );
            }
          }),
    );
  }
}
