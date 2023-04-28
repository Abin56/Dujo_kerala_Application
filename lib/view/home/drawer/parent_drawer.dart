// ignore_for_file: empty_catches, unused_element

import 'package:dujo_kerala_application/view/home/student_home/student_home.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:dujo_kerala_application/view/widgets/fonts/google_monstre.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
Widget ParentDrawer(context) {
  void signOut(context) async {
    final auth = FirebaseAuth.instance;
    try {
      await auth.signOut().then((value) => {
            
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
    color: adminePrimayColor,
    padding: const EdgeInsets.only(top: 15),
    child: Column(
      
      // show list  of menu drawer.........................
      children: [
        Container(
          margin: EdgeInsets.only(top: 20.h),
          width: double.infinity,
          height: 250.h,
          decoration: const BoxDecoration(color: adminePrimayColor),
          child: Column(children: [
            
       Padding(
         padding:  EdgeInsets.only(top: 20.h),
         child: CircleAvatar(radius: 65.h,
          backgroundColor: Colors.white,
           backgroundImage: const NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTO3Kbs-sPqhzk0A2i0doztmT0RLa0nGmYWYw&usqp=CAU'),),
       ),
        kWidth10,
        GoogleMonstserratWidgets(text: 'Parent', fontsize: 18,color: cWhite,fontWeight: FontWeight.bold),
        kWidth10,
        GoogleMonstserratWidgets(text: 'parent@email.com', fontsize: 18,color: cWhite,fontWeight: FontWeight.bold),
          ]),
        ),


        MenuItem(1, 'assets/images/profile.png', 'Profile',
            currentPage == DrawerSections.dashboard ? true : false, () {
         
        }),
        MenuItem(2, 'assets/images/exam.png', ' Exams',
            currentPage == DrawerSections.favourites ? true : false, () {
          
        }),
        MenuItem(3, 'assets/images/library.png', ' TimeTable',
            currentPage == DrawerSections.setting ? true : false, () {
          
        }),
       
        MenuItem(4, 'assets/images/homework.png', ' HomeWorks',
            currentPage == DrawerSections.contact ? true : false, () {
         
        }),
        MenuItem(5, 'assets/images/notice.jpg', ' Notices',
            currentPage == DrawerSections.about ? true : false, () {
          
        }),
        MenuItem(6, 'assets/images/live.jpg', ' Live Classes',
            currentPage == DrawerSections.dashboard ? true : false, () {
          
        }),
        MenuItem(7, 'assets/images/rec.png', ' Recorded Classes',
            currentPage == DrawerSections.dashboard ? true : false, () {
       
        }),
        MenuItem(8, 'assets/images/privacy.png', ' privacy and policy',
            currentPage == DrawerSections.dashboard ? true : false, () {
        
        }),
        MenuItem(9, 'assets/images/logout.jpg', ' Logout',
            currentPage == DrawerSections.dashboard ? true : false, () {
           signOut(context);
        }),
        
        Container(
          color:cWhite,
          // Colors.grey.withOpacity(0.2),
          height: 200.h ,
          width: double.infinity,
          child: Stack(children: [
            Positioned(
              left: 20,
              top: 15,
              child: Column(
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

