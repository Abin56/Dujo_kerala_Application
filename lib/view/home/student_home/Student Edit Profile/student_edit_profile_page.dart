import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/view/home/student_home/Student%20Edit%20Profile/widget/student_profile_edit_listtile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../controllers/student_controller/profile_edit_controllers/student_profile_edit_controller.dart';
import '../../../../controllers/userCredentials/user_credentials.dart';
import '../../../../model/Signup_Image_Selction/image_selection.dart';
import '../../../../widgets/Iconbackbutton.dart';
import '../../../colors/colors.dart';
import '../../../constant/sizes/constant.dart';
import '../../../constant/sizes/sizes.dart';
import '../../../widgets/bottom_container_profile_photo_container.dart';
import '../../../widgets/fonts/google_poppins.dart';

class StudentProfileEditPage extends StatelessWidget {
  const StudentProfileEditPage({super.key});

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
                  child: StudentCircleAvatarImgeWidget(),
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
            StudentEditListileWidget(
              icon: Icons.person,
              subtitle: GooglePoppinsWidgets(
                  text:
                      UserCredentialsController.studentModel?.studentName ?? "",
                  fontsize: 19.h),
              title: GooglePoppinsWidgets(text: "Name".tr, fontsize: 12.h),
            ),
            StudentEditListileWidget(
              icon: Icons.call,
              subtitle: GooglePoppinsWidgets(
                  text: UserCredentialsController
                          .studentModel?.parentPhoneNumber ??
                      "",
                  fontsize: 19.h),
              title: GooglePoppinsWidgets(text: "Phone No.".tr, fontsize: 12.h),
            ),
            StudentEditListileWidget(
              icon: Icons.email,
              subtitle: GooglePoppinsWidgets(
                  text: UserCredentialsController.studentModel?.studentemail ??
                      "",
                  fontsize: 19.h),
              title: GooglePoppinsWidgets(text: "Email".tr, fontsize: 12.h),
              editicon: Icons.edit,
            ),
            StudentEditListileWidget(
              icon: Icons.class_rounded,
              subtitle: FutureBuilder(
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
                      return GooglePoppinsWidgets(
                          text: snapshot.data!.data()!['className'],
                          fontsize: 19.h);
                    } else {
                      return const Text('');
                    }
                  }),
              title: GooglePoppinsWidgets(text: "Class ".tr, fontsize: 12.h),
            ),
            StudentEditListileWidget(
              icon: Icons.bloodtype_outlined,
              subtitle:
                  GooglePoppinsWidgets(text: "Blood Group".tr, fontsize: 19.h),
              title: GooglePoppinsWidgets(
                  text:
                      UserCredentialsController.studentModel?.bloodgroup ?? "",
                  fontsize: 12.h),
            ),
            StudentEditListileWidget(
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
      return " ";
    }
  }
}

class StudentCircleAvatarImgeWidget extends StatelessWidget {
  StudentCircleAvatarImgeWidget({
    super.key,
  });
  final GetImage getImageController = Get.put(GetImage());
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundImage:
              UserCredentialsController.studentModel?.profileImageUrl == null ||
                      UserCredentialsController
                          .studentModel!.profileImageUrl.isEmpty
                  ? const NetworkImage(netWorkImagePathPerson)
                  : NetworkImage(
                      UserCredentialsController.studentModel?.profileImageUrl ??
                          " ") as ImageProvider,
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
        isDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return BottomProfilePhotoContainerWidget(
              getImageController: getImageController);
        }).then((value) {
      if (getImageController.pickedImage.value.isNotEmpty) {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return Obx(
                () => Get.find<StudentProfileEditController>().isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : AlertDialog(
                        title: Text('Do you want to change profile picture'.tr),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Get.find<StudentProfileEditController>()
                                    .updateStudentProfilePicture();
                              },
                              child: Text('Update'.tr)),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                getImageController.pickedImage.value = "";
                              },
                              child: Text('Cancel'.tr)),
                        ],
                      ),
              );
            });
      }
    });
  }
}
