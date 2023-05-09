import 'dart:developer';

import 'package:dujo_kerala_application/controllers/log_out/user_logout_controller.dart';
import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../controllers/userCredentials/user_credentials.dart';
import '../../colors/colors.dart';
import '../class_teacher_HOme/class_teacher_mainhome.dart';

class TeacherHeaderDrawer extends StatelessWidget {
  UserLogOutController userLogOutController = Get.put(UserLogOutController());
  TeacherHeaderDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  log("message");
      return Container(
      color: Colors.grey.withOpacity(0.2),
      width: double.infinity,
      height: 290,
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 0),
            height: 100,
            width: 150,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(
                    "https://firebasestorage.googleapis.com/v0/b/leptonscipro-31792.appspot.com/o/files%2Fimages%2FL.png?alt=media&token=135e14d0-fb5a-4a21-83a6-411f647ec974"),
              ),
            ),
          ),
          Text(
            "DuJo App",
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
                fontSize: 10,
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
                  label: const Text(
                    'Logout',
                    style: TextStyle(color: cblack),
                  ))
            ],
          ),
          UserCredentialsController.teacherModel!.userRole == 'classTeacher'
              ? TextButton.icon(
                  onPressed: () async {
                    Get.offAll(ClassTeacherMainHomeScreen());
                  },
                  icon: const Icon(Icons.edit_note_rounded),
                  label: const Text(
                    'Switch to Class Teacher',
                    style: TextStyle(color: cblack),
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
        menuItem(1, 'assets/images/attendance.png', 'Attendance',
            currentPage == DrawerSections.dashboard ? true : false, () {
          // Navigator.of(context).push(
          //     MaterialPageRoute(builder: (ctx) => RecordedCoursesListScreen()));
        }),
        menuItem(2, 'assets/images/exam.png', 'Exams',
            currentPage == DrawerSections.favourites ? true : false, () {
          // Navigator.of(context).push(
          //     MaterialPageRoute(builder: (ctx) => LiveCoursesListScreen()));
        }),
        menuItem(3, 'assets/images/library.png', 'TimeTable',
            currentPage == DrawerSections.setting ? true : false, () {
          // termsAndConditions(context);
        }),
        // menuItem(4, "Share", Icons.share,
        //     currentPage == DrawerSections.share ? true : false, () async {
        //   // await  Share.share('https://play.google.com/store/apps/details?id=in.brototype.BrotoPlayer');
        // }),
        menuItem(4, 'assets/images/homework.png', 'HomeWorks',
            currentPage == DrawerSections.contact ? true : false, () {
          // contactus(context);
        }),
        menuItem(5, 'assets/images/school_building.png', 'Notices',
            currentPage == DrawerSections.about ? true : false, () {
          // showAboutDialog(
          //     context: context,
          //     applicationIcon: const Image(
          //       image: AssetImage('assets/images/SCIPRO.png'),
          //       height: 100,
          //       width: 100,
          //     ),
          //     applicationName: "SCI PRO",
          //     applicationVersion: '1.0.2',
          //     children: [
          //       const Text(
          //           'SCI PRO is a Education App created by VECTORWIND-TECHSYSTEMS PRIVATE LIMITED.')
          //     ]);
        }),
        menuItem(6, 'assets/images/activity.png', 'Events',
            currentPage == DrawerSections.dashboard ? true : false, () {
          // signOut(context);
        }),
        menuItem(7, 'assets/images/splash.png', 'Progress Report',
            currentPage == DrawerSections.dashboard ? true : false, () {
          // signOut(context);
        }),
        // menuItem(8, 'assets/images/leave_apply.png', 'Apply Leave',
        //     currentPage == DrawerSections.dashboard ? true : false, () {
        //   signOut(context);
        // }),
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
                      "Lepton Plus Communications",
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
