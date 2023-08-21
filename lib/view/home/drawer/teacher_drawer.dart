import 'dart:developer';

import 'package:dujo_kerala_application/controllers/log_out/user_logout_controller.dart';
import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:dujo_kerala_application/view/home/exam_Notification/teacher_adding/add_subject.dart';
import 'package:dujo_kerala_application/view/home/general_instructions/general_instructions.dart';
import 'package:dujo_kerala_application/view/home/teachers_home/teacher_classes_list.dart';
import 'package:dujo_kerala_application/view/pages/Homework/homework.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../controllers/userCredentials/user_credentials.dart';
import '../../colors/colors.dart';
import '../../language/language_change_drawer.dart';
import '../../pages/Attentence/take_attentence/attendence_book_status_month.dart';
import '../../pages/privacy_policy/dialogs/privacy_policy.dart';
import '../class_teacher_HOme/class_teacher_mainhome.dart';
import '../student_home/time_table/ss.dart';

class TeacherHeaderDrawer extends StatelessWidget {
  UserLogOutController userLogOutController = Get.put(UserLogOutController());
  TeacherHeaderDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log("message");
    return Container(
      color: Colors.grey.withOpacity(0.2),
      width: double.infinity,
      height: 350.h,
      padding: EdgeInsets.only(bottom: 5.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          kHeight30,
          Container(
            margin: const EdgeInsets.only(bottom: 0),
            height: 90.h,
            width: 150.w,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(
                    "https://firebasestorage.googleapis.com/v0/b/leptonscipro-31792.appspot.com/o/files%2Fimages%2FL.png?alt=media&token=135e14d0-fb5a-4a21-83a6-411f647ec974"),
              ),
            ),
          ),
          Text(
            "Lepton DuJo",
            style: GoogleFonts.montserrat(
                color: Colors.black, fontSize: 25, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 1,
          ),
          Text(
            "Watch and Guide      \n  Let them Study",
            style: GoogleFonts.poppins(
                color: Colors.black.withOpacity(0.5),
                fontSize: 10.w,
                fontWeight: FontWeight.w600),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                  onPressed: () async {
                    userLogOutController.logOut(context);
                  },
                  icon: const Icon(Icons.key),
                  label: Text(
                    'Logout'.tr,
                    style: const TextStyle(color: cblack),
                  ))
            ],
          ),
          UserCredentialsController.teacherModel!.userRole == 'classTeacher'
              ? TextButton.icon(
                  onPressed: () async {
                    await backtoSwitchClass().then((value) {
                      UserCredentialsController.classId=value;
                    log('Value Printing ::::: $value');
                          Get.offAll(const ClassTeacherMainHomeScreen());
                    }
                    );
                  },
                  icon: const Icon(Icons.edit_note_rounded),
                  label: Text(
                    'Switch to Class Teacher'.tr,
                    style: const TextStyle(color: cblack),
                  ))
              : const Text('')
        ],
      ),
    );
  }
}

Widget menuItem(int id, String image, String title, bool selected, onTap) {
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

enum DrawerSections {
  dashboard,
  favourites,
  setting,
  share,
  feedback,
  contact,
  about,
}

// ignore: non_constant_identifier_names
Widget MyDrawerList(context) {
  void signOut(context) async {
    final auth = FirebaseAuth.instance;
    try {
      await auth.signOut().then((value) => {
            // Navigator.pushAndRemoveUntil(
            //     context,
            //     MaterialPageRoute(builder: (context) => const Gsignin()),
            //     (route) => false)
          });
    } catch (e) {}
  }

  void errorBox(context, e) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Error"),
            content: Text(e.toString()),
          );
        });
  }

  var currentPage = DrawerSections.dashboard;
  return Container(
    padding: const EdgeInsets.only(top: 15),
    child: Column(
      // show list  of menu drawer.........................
      children: [
        menuItem(1, 'assets/images/information.png', 'General Instructions'.tr,
            currentPage == DrawerSections.dashboard ? true : false, () {
          Get.to(
            () => GeneralInstruction(),
          );
        }),
        menuItem(2, 'assets/images/attendance.png', 'Attendance book'.tr,
            currentPage == DrawerSections.dashboard ? true : false, () {
          Get.to(
            () => AttendenceBookScreenSelectMonth(
                schoolId: UserCredentialsController.schoolId!,
                batchId: UserCredentialsController.batchId!,
                classID: UserCredentialsController.classId!), //Attendance Book,
          );
        }),
        menuItem(3, 'assets/images/exam.png', 'Exams'.tr,
            currentPage == DrawerSections.favourites ? true : false, () {
          Get.to(
            () => const AddTimeTable(),
          );
        }),
        menuItem(4, 'assets/images/library.png', 'Time Table'.tr,
            currentPage == DrawerSections.setting ? true : false, () {
          Get.to(
            () => const SS(),
          );
        }),
        menuItem(5, 'assets/images/homework.png', 'HomeWorks'.tr,
            currentPage == DrawerSections.contact ? true : false, () {
          Get.to(
            () => HomeWorkUpload(
              batchId: UserCredentialsController.batchId!,
              classId: UserCredentialsController.classId!,
              schoolID: UserCredentialsController.schoolId!,
              teacherID: UserCredentialsController.teacherModel!.docid!,
            ),
          );
        }),

        // menuItem(7, 'assets/images/splash.png', 'Progress Report'.tr,
        //     currentPage == DrawerSections.dashboard ? true : false, () {
        //   Get.to(
        //     () => CreateExamNameScreen(
        //         schooilID: UserCredentialsController.schoolId!,
        //         classID: UserCredentialsController.classId!,
        //         teacherId: UserCredentialsController.teacherModel!.docid!,
        //         batchId: UserCredentialsController.batchId!),
        //   );
        // }),
        menuItem(7, 'assets/images/languages.png', 'Change Language'.tr,
            currentPage == DrawerSections.dashboard ? true : false, () {
          Get.to(LanguageChangeDrawerPage());
        }),
        menuItem(8, 'assets/images/attendance.png', 'Privacy Policy'.tr,
            currentPage == DrawerSections.dashboard ? true : false, () {
          Get.to(const PrivacyViewScreen());
        }),

        kHeight10,
        kHeight10,
        kHeight10,
        Container(
          color: Colors.grey.withOpacity(0.2),
          height: 200,
          width: double.infinity,
          child: Stack(children: [
            Positioned(
              left: 20,
              top: 15,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: const [
                      Text(
                        "Developed by",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
                top: 38,
                left: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage: NetworkImage(
                          'https://firebasestorage.googleapis.com/v0/b/leptonscipro-31792.appspot.com/o/files%2Fimages%2FL.png?alt=media&token=135e14d0-fb5a-4a21-83a6-411f647ec974'),
                    ),
                    SizedBox(
                      width: 06,
                    ),
                    Text(
                      "Lepton Communications",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 11.5),
                    ),
                  ],
                )),
            Positioned(
              left: 100,
              top: 73,
              child: Column(
                children: [
                  Row(
                    children: const [
                      Icon(
                        Icons.adb_outlined,
                        color: Colors.green,
                      ),
                      Text(
                        " Version",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const Text(
                    "    1.0.0",
                    style: TextStyle(color: Colors.black, fontSize: 11.5),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ],
    ),
  );
}

Widget emptyDisplay(String section) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "No $section Found",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}
