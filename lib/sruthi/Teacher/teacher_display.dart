import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/get_utils.dart';

import '../../view/colors/colors.dart';
import '../../view/constant/sizes/constant.dart';
import '../../view/constant/sizes/sizes.dart';
import '../../view/widgets/fonts/google_poppins.dart';
import '../../widgets/Iconbackbutton.dart';

class TeacherDisplay extends StatelessWidget {
  const TeacherDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            IconButtonBackWidget(),
            Text(
              "Teachers".tr
              ,
            ),
          ],
        ),
        backgroundColor: adminePrimayColor,
      ),
      body: Column(
        children: [
        kHeight10,
          Expanded(
            child: ListView.separated(
                itemCount: 5,
                separatorBuilder: ((context, index) {
                  return kHeight10;
                }),
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Container(
                          decoration: const BoxDecoration(),
                          child: ListTile(
                            shape: const BeveledRectangleBorder(
                                side:
                                    BorderSide(color: Colors.grey, width: 0.2)),
                            leading: const CircleAvatar(
                              radius: 25,
                              backgroundImage: NetworkImage(
                                  netWorkImagePathPerson),
                            ),
                            title: Padding(
                              padding: EdgeInsets.only(top: 10.h),
                              child: GooglePoppinsWidgets(
                                text: "Anupama",
                                fontsize: 21.h,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 10.h),
                                  child: GooglePoppinsWidgets(
                                    text: "anupama@gmail.com",
                                    fontsize: 14.h,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 10.h),
                                  child: GooglePoppinsWidgets(
                                    text: "9645253614",
                                    fontsize: 14.h,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 10.h),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      GooglePoppinsWidgets(
                                        text: "Subject :",
                                        fontsize: 14.h,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      Flexible(
                                        child: GooglePoppinsWidgets(
                                          text: "Chemistry",
                                          fontsize: 14.h,
                                          fontWeight: FontWeight.bold,
                                          color: adminePrimayColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            trailing: Column(
                              children: const [Icon(Icons.message)],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
          ),
        ],
      ),
    );
  }
}
