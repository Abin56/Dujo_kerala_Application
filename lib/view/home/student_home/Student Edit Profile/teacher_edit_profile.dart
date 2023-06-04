import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/view/home/student_home/Student%20Edit%20Profile/widget/edit_image_selection_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../controllers/student_controller/profile_edit_controllers/teacher_profile_controller.dart';
import '../../../../controllers/userCredentials/user_credentials.dart';
import '../../../../widgets/Iconbackbutton.dart';
import '../../../colors/colors.dart';
import '../../../constant/sizes/constant.dart';
import '../../../constant/sizes/sizes.dart';
import '../../../widgets/fonts/google_poppins.dart';

class TeacherEditProfileScreen extends StatelessWidget {
  const TeacherEditProfileScreen({super.key});

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
              kWidth50,
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
              Stack(children: const [
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
            TeacherEditListileWidget(
              icon: Icons.person,
              subtitle: GooglePoppinsWidgets(
                  text:
                      UserCredentialsController.teacherModel?.teacherName ?? "",
                  fontsize: 19.h),
              title: GooglePoppinsWidgets(text: "Name".tr, fontsize: 12.h),
            ),
            TeacherEditListileWidget(
              icon: Icons.call,
              subtitle: GooglePoppinsWidgets(
                  text:
                      UserCredentialsController.teacherModel?.teacherPhNo ?? "",
                  fontsize: 19.h),
              title: GooglePoppinsWidgets(text: "Phone No.".tr, fontsize: 12.h),
            ),
            TeacherEditListileWidget(
              icon: Icons.email,
              subtitle: GooglePoppinsWidgets(
                  text: UserCredentialsController.teacherModel?.teacherEmail ??
                      "",
                  fontsize: 19.h),
              title: GooglePoppinsWidgets(text: "Email".tr, fontsize: 12.h),
              editicon: Icons.edit,
            ),
            TeacherEditListileWidget(
              icon: Icons.class_rounded,
              subtitle: FutureBuilder(
                  future: getClassName(
                      UserCredentialsController.teacherModel?.classID ?? ""),
                  builder: (context, snapshot) {
                    return GooglePoppinsWidgets(
                        text: snapshot.data ?? " ", fontsize: 19.h);
                  }),
              title: GooglePoppinsWidgets(text: "Class".tr, fontsize: 12.h),
            ),
            TeacherEditListileWidget(
              icon: Icons.home,
              subtitle: GooglePoppinsWidgets(
                  text: UserCredentialsController.teacherModel?.houseName ?? "",
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
      return " ";
    }
  }
}

class TeacherEditListileWidget extends StatelessWidget {
  final Widget title;
  final Widget subtitle;
  final IconData icon;
  final IconData? editicon;
  final _formKey = GlobalKey<FormState>();
  String newEmail = "";
  TeacherProfileController teacherProfileEditController =
      Get.put(TeacherProfileController());

  TeacherEditListileWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.editicon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: title,
      subtitle: subtitle,
      trailing: InkWell(
        child: Icon(editicon),
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Do you want change mail ?"),
                actions: [
                  TextButton(
                    child: const Text("Cancel"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: const Text("OK"),
                    onPressed: () {
                      Navigator.pop(context);

                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          final TextEditingController emailController =
                              TextEditingController();
                          final TextEditingController passwordController =
                              TextEditingController();
                          return Form(
                            key: _formKey,
                            child: AlertDialog(
                              title: const Text("Update Mail"),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextFormField(
                                    validator: checkFieldEmailIsValid,
                                    controller: emailController,
                                    decoration: const InputDecoration(
                                        hintText: "Enter new email address"),
                                  ),
                                  TextFormField(
                                    validator: checkFieldEmpty,
                                    controller: passwordController,
                                    decoration: const InputDecoration(
                                        hintText: "Password"),
                                  ),
                                ],
                              ),
                              actions: [
                                Obx(() => teacherProfileEditController
                                        .isLoading.value
                                    ? const Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : TextButton(
                                        child: const Text("Update"),
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            teacherProfileEditController
                                                .changeTeacherEmail(
                                                    emailController.text.trim(),
                                                    context,
                                                    passwordController.text
                                                        .trim());
                                          }
                                        },
                                      )),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
