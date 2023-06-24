import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../controllers/student_controller/profile_edit_controllers/guardian_profile_controller.dart';
import '../../../../controllers/userCredentials/user_credentials.dart';
import '../../../../model/Signup_Image_Selction/image_selection.dart';
import '../../../../widgets/Iconbackbutton.dart';
import '../../../colors/colors.dart';
import '../../../constant/sizes/constant.dart';
import '../../../constant/sizes/sizes.dart';
import '../../../widgets/bottom_container_profile_photo_container.dart';
import '../../../widgets/fonts/google_poppins.dart';

class GuardianEditProfileScreen extends StatelessWidget {
  const GuardianEditProfileScreen({super.key});

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
                  child: CircleAvatharImageSelectionWidgetGuardian(),
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
            GuardianEditListileWidget(
              icon: Icons.person,
              subtitle: GooglePoppinsWidgets(
                  text: UserCredentialsController.guardianModel?.guardianName ??
                      "",
                  fontsize: 19.h),
              title: GooglePoppinsWidgets(text: "Name".tr, fontsize: 12.h),
            ),
            GuardianEditListileWidget(
              icon: Icons.call,
              subtitle: GooglePoppinsWidgets(
                  text: UserCredentialsController
                          .guardianModel?.guardianPhoneNumber ??
                      "",
                  fontsize: 19.h),
              title: GooglePoppinsWidgets(text: "Phone No.".tr, fontsize: 12.h),
            ),
            GuardianEditListileWidget(
              icon: Icons.email,
              subtitle: GooglePoppinsWidgets(
                  text:
                      UserCredentialsController.guardianModel?.guardianEmail ??
                          "",
                  fontsize: 19.h),
              title: GooglePoppinsWidgets(text: "Email".tr, fontsize: 12.h),
              editicon: Icons.edit,
            ),
            GuardianEditListileWidget(
              icon: Icons.home,
              subtitle: GooglePoppinsWidgets(
                  text:
                      UserCredentialsController.guardianModel?.houseName ?? "",
                  fontsize: 19.h),
              title: GooglePoppinsWidgets(text: "Address".tr, fontsize: 12.h),
            ),
          ],
        ),
      ),
    ])));
  }

  // Future<String> getClassName(String classId) async {
  //   try {
  //     final result = await FirebaseFirestore.instance
  //         .collection('SchoolListCollection')
  //         .doc(UserCredentialsController.schoolId)
  //         .collection('classes')
  //         .doc(UserCredentialsController.classId)
  //         .get();
  //     return result.data()?["className"];
  //   } catch (e) {
  //     return " ";
  //   }
  // }
}

class GuardianEditListileWidget extends StatelessWidget {
  final Widget title;
  final Widget subtitle;
  final IconData icon;
  final IconData? editicon;
  final _formKey = GlobalKey<FormState>();
  String newEmail = "";
  GuardianProfileController guardianProfileEditController =
      Get.put(GuardianProfileController());

  GuardianEditListileWidget({
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
                                Obx(() => guardianProfileEditController
                                        .isLoading.value
                                    ? const Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : TextButton(
                                        child: Text("Update".tr),
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            guardianProfileEditController
                                                .changeGuardianEmail(
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

class CircleAvatharImageSelectionWidgetGuardian extends StatelessWidget {
  CircleAvatharImageSelectionWidgetGuardian({
    super.key,
  });
  final GetImage getImageController = Get.put(GetImage());
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundImage: UserCredentialsController
                          .guardianModel?.profileImageURL ==
                      null ||
                  UserCredentialsController
                      .guardianModel!.profileImageURL!.isEmpty
              ? const NetworkImage(netWorkImagePathPerson)
              : NetworkImage(
                  UserCredentialsController.guardianModel?.profileImageURL ??
                      " ") as ImageProvider,
          radius: 60,
          child: Stack(
            children: [
              InkWell(
                onTap: () async {
                  _getCameraAndGallery(context);
                },
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: const Color.fromARGB(255, 52, 50, 50),
                    child: IconButton(
                      icon: const Icon(Icons.edit),
                      color: Colors.white,
                      onPressed: () async {
                        _getCameraAndGallery(context);
                      },
                    ),
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
              () => Get.find<GuardianProfileController>().isLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : AlertDialog(
                      title: Text('Do you want to change profile picture?'.tr),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Get.find<GuardianProfileController>()
                                .updateGuardianProfilePicture();
                          },
                          child: const Text('Update'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            getImageController.pickedImage.value = '';
                          },
                          child: const Text('Cancel'),
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
