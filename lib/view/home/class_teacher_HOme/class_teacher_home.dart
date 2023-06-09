// ignore_for_file: use_key_in_widget_constructors, must_call_super, annotate_overrides, non_constant_identifier_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:dujo_kerala_application/view/home/class_teacher_HOme/accessories.dart';
import 'package:dujo_kerala_application/view/home/student_home/Student%20Edit%20Profile/teacher_edit_profile.dart';
import 'package:dujo_kerala_application/view/widgets/fonts/google_monstre.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ClassTeacherHomeScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: cgraident,
              width: double.infinity,
              height: screenSize.width * 0.5,
              padding: EdgeInsets.all(15.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:  EdgeInsets.all(8.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: screenSize.width / 2,
                          child: GoogleMonstserratWidgets(
                            overflow: TextOverflow.ellipsis,
                            text: UserCredentialsController
                                    .teacherModel?.teacherName ??
                                " ",
                            fontsize: 23.sp,
                            fontWeight: FontWeight.bold,
                            color: cWhite,
                          ),
                        ),
                        UserCredentialsController.teacherModel?.imageUrl == null
                            ? kHeight
                            : GestureDetector(
                                onTap: () {
                                  Get.to(const TeacherEditProfileScreen());
                                },
                                child: Stack(
                                  children: [
                                    Container(
                                      height: 100,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: NetworkImage(
                                              UserCredentialsController
                                                      .teacherModel?.imageUrl ??
                                                  " "),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      right: 6.r,
                                      bottom: 1.r,
                                      child: CircleAvatar(
                                        radius: 12.r,
                                        child: const Center(
                                            child: Icon(Icons.info)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      ],
                    ),
                  ),
                  GoogleMonstserratWidgets(
                    text:
                        'ID : ${UserCredentialsController.teacherModel?.employeeID ?? " "}',
                    fontsize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: cWhite.withOpacity(0.8),
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
                      builder: (context, snaps) {
                        if (snaps.hasData) {
                          return GoogleMonstserratWidgets(
                            text: 'Class : ${snaps.data!.data()!['className']}',
                            fontsize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: cWhite.withOpacity(0.8),
                          );
                        } else {
                          return const Text('');
                        }
                      }),
                  GoogleMonstserratWidgets(
                    text:
                        'email : ${UserCredentialsController.teacherModel?.teacherEmail ?? " "}',
                    fontsize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: cWhite.withOpacity(0.7),
                  ),
                ],
              ),
            ),
            ClassTeacherAccessories(
              classID: '',
            ),
          ],
        ),
      ),
    );
  }
}

Widget MenuItem(int id, String image, String title, bool selected, onTap) {
  return Material(
    color: Colors.white,
    child: InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 30,
                width: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage(image))),
              ),
            ),
            Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                ))
          ],
        ),
      ),
    ),
  );
}
