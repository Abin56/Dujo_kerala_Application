import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../controllers/student_controller/profile_edit_controllers/teacher_profile_controller.dart';
import '../../../../controllers/userCredentials/user_credentials.dart';
import '../../../../model/Signup_Image_Selction/image_selection.dart';
import '../../../../widgets/Iconbackbutton.dart';
import '../../../colors/colors.dart';
import '../../../constant/sizes/constant.dart';
import '../../../constant/sizes/sizes.dart';
import '../../../widgets/bottom_container_profile_photo_container.dart';
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
              Stack(children: [
                SingleChildScrollView(
                  child: CircleAvatharImageSelectionWidgetTeacher(),
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
            FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('SchoolListCollection')
                    .doc(UserCredentialsController.schoolId)
                    .collection(UserCredentialsController.batchId!)
                    .doc(UserCredentialsController.batchId)
                    .collection('classes')
                    .doc(UserCredentialsController.classId)
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return TeacherEditListileWidget(
                      subtitle: Text('${snapshot.data!.data()!['className']}'),
                      icon: Icons.class_rounded,
                      title: GooglePoppinsWidgets(
                          text: 'Class'.tr, fontsize: 13.h),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
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
                title: Text("Do you want to change Email ID ?".tr),
                actions: [
                  TextButton(
                    child: Text("Cancel".tr),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: Text("Ok".tr),
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
                              title: Text("Update Mail".tr),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextFormField(
                                    validator: checkFieldEmailIsValid,
                                    controller: emailController,
                                    decoration: InputDecoration(
                                        hintText: "Enter new email address".tr),
                                  ),
                                  TextFormField(
                                    validator: checkFieldEmpty,
                                    controller: passwordController,
                                    decoration: InputDecoration(
                                        hintText: "Password".tr),
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
                                        child: Text("Update".tr),
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

class CircleAvatharImageSelectionWidgetTeacher extends StatelessWidget {
  CircleAvatharImageSelectionWidgetTeacher({
    super.key,
  });
  final GetImage getImageController = Get.put(GetImage());
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundImage: UserCredentialsController.teacherModel?.imageUrl ==
                      null ||
                  UserCredentialsController.teacherModel!.imageUrl!.isEmpty
              ? const NetworkImage(netWorkImagePathPerson)
              : NetworkImage(
                      UserCredentialsController.teacherModel?.imageUrl ?? " ")
                  as ImageProvider,
          radius: 60,
          child: Stack(
            children: [
              InkWell(
                onTap: () async {
                  _getCameraAndGallery(context);
                },
                child: const Align(
                  alignment: Alignment.bottomRight,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Color.fromARGB(255, 52, 50, 50),
                    child: Icon(Icons.edit),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  void _getCameraAndGallery(BuildContext context) {
    showModalBottomSheet(
      enableDrag: false,
      isDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return BottomProfilePhotoContainerWidget(
          getImageController: getImageController,
        );
      },
    ).then((value) {
      if (getImageController.pickedImage.value.isNotEmpty) {
        showDialog(
          context: context,
          barrierDismissible:
              false, // Added to prevent dialog dismissal on tap outside
          builder: (context) {
            return Obx(
              () => Get.find<TeacherProfileController>().isLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : AlertDialog(
                      title: Text('Do you want to change profile picture?'.tr),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Get.find<TeacherProfileController>()
                                .updateTeacherProfilePicture();
                          },
                          child: Text('Update'.tr),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            getImageController.pickedImage.value = '';
                          },
                          child: Text('Cancel'.tr),
                        ),
                      ],
                    ),
            );
          },
        );
      }
    });
  }
}
