import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controllers/userCredentials/user_credentials.dart';
import '../../view/colors/colors.dart';
import '../../view/constant/sizes/sizes.dart';
import '../../view/widgets/fonts/google_poppins.dart';
import '../../widgets/Iconbackbutton.dart';
import '../sruthi/edit_image_selection_widget.dart';
import '../view/home/student_home/Student Edit Profile/widget/user_edit_page_widget.dart';

class UserEditPage extends StatelessWidget {
  const UserEditPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: ListView(children: [
      Container(
        width: double.infinity,
        height: 300.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12.h),
              bottomRight: Radius.circular(12.h)),
          color: adminePrimayColor,
        ),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButtonBackWidget(
                color: cWhite,
              ),
             
              GooglePoppinsWidgets(
                text: "Profile".tr,
                fontsize: 22.h,
                color: cWhite,
              )
            ],
          ),
          kHeight20,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(children:  [
                SingleChildScrollView(
                  child: CircleAvatharImageSelectionWidget(),
                ),
                kHeight20,
              ]),
            ],
          )
        ]),
      ),
      SizedBox(
        width: double.infinity,
        height: 700.h,
        child: ListView(
          children: [
            UserEditListileWidget(
              icon: Icons.person,
              subtitle: GooglePoppinsWidgets(
                  text:
                      UserCredentialsController.studentModel?.studentName ?? "",
                  fontsize: 19.h),
              title: GooglePoppinsWidgets(text: "Name".tr, fontsize: 12.h),
            ),
            UserEditListileWidget(
              icon: Icons.call,
              subtitle: GooglePoppinsWidgets(
                  text: UserCredentialsController
                          .studentModel?.parentPhoneNumber ??
                      "",
                  fontsize: 19.h),
              title: GooglePoppinsWidgets(text: "Phone No.".tr, fontsize: 12.h),
            ),
            UserEditListileWidget(
              icon: Icons.email,
              subtitle: GooglePoppinsWidgets(
                  text: UserCredentialsController.studentModel?.studentemail ??
                      "",
                  fontsize: 19.h),
              title: GooglePoppinsWidgets(text: "Email".tr, fontsize: 12.h),
              editicon: Icons.edit,
            ),
            UserEditListileWidget(
              icon: Icons.class_rounded,
              subtitle: FutureBuilder(
                  future: getClassName(
                      UserCredentialsController.studentModel?.classId ?? ""),
                  builder: (context, snapshot) {
                    return GooglePoppinsWidgets(
                        text: snapshot.data ?? " ", fontsize: 19.h);
                  }),
              title: GooglePoppinsWidgets(text: "Class".tr, fontsize: 12.h),
            ),
            UserEditListileWidget(
              icon: Icons.bloodtype_outlined,
              subtitle:
                  GooglePoppinsWidgets(text: "Blood Group".tr, fontsize: 19.h),
              title: GooglePoppinsWidgets(
                  text:
                      UserCredentialsController.studentModel?.bloodgroup ?? "",
                  fontsize: 12.h),
            ),
            UserEditListileWidget(
              icon: Icons.home,
              subtitle: GooglePoppinsWidgets(
                  text: UserCredentialsController.studentModel?.houseName ?? "",
                  fontsize: 19.h),
              title: GooglePoppinsWidgets(text: "Address".tr, fontsize: 12.h),
            ),
          ],
        ),
      ),
    ])));
  }

  Future<String> getClassName(String classId) async {
    try {
      final result = await FirebaseFirestore.instance
          .collection('SchoolListCollection')
          .doc(UserCredentialsController.schoolId)
          .collection('classes')
          .doc(UserCredentialsController.classId)
          .get();
      return result.data()?["className"];
    } catch (e) {
      return " ";
}
}
}