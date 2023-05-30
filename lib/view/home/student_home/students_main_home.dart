import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/home/drawer/student_drawer.dart';
import 'package:dujo_kerala_application/view/home/student_home/student_home.dart';
import 'package:dujo_kerala_application/view/pages/live_classes/students_room/list_room.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

import '../../widgets/container_image.dart';
import '../sample/under_maintance.dart';

class StudentsMainHomeScreen extends StatefulWidget {
  // var schoolID;
  // var classID;
  // var studentEmailid;
  const StudentsMainHomeScreen(
      {
      //   required this.schoolID,
      // required this.classID,
      // required this.studentEmailid,
      Key? key})
      : super(key: key);

  @override
  State<StudentsMainHomeScreen> createState() => _StudentsMainHomeScreenState();
}

class _StudentsMainHomeScreenState extends State<StudentsMainHomeScreen> {
  int _page = 0;

  onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      StudentHomeScreen(),
      const UnderMaintanceScreen(text: ""),
     const StudentsRoomListScreen(),
      const UnderMaintanceScreen(text: ""),
    ];
    return Scaffold(
      appBar: AppBar(
          title: ContainerImage(
              height: 28.h,
              width: 90.w,
              imagePath: 'assets/images/dujoo-removebg.png'),
          backgroundColor: adminePrimayColor),
      body: pages[_page],
      bottomNavigationBar: Container(
        height: 71,
        decoration: BoxDecoration(
          // color: Colors.white,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          border: Border.all(color: Colors.white.withOpacity(0.13)),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 6, 71, 157),
              Color.fromARGB(255, 5, 85, 222)
            ],
          ),
        ),
        child: GNav(
          gap: 8,
          rippleColor: Colors.grey,
          activeColor: Colors.white,
          color: Colors.white,
          tabs: [
            GButton(
                iconSize: 20,
                icon: LineIcons.home,
                text: 'Home'.tr,
                style: GnavStyle.google),
            GButton(
              iconSize: 20,
              textSize: 9,
              icon: Icons.tv,
              text: 'Recorded Classes'.tr,
            ),
            GButton(
              iconSize: 20,
              // iconSize: 10,
              textSize: 12,
              icon: Icons.laptop,
              text: 'Live Classes'.tr,
            ),
            GButton(
              iconSize: 20,
              icon: Icons.chat,
              text: 'Chat With bot'.tr,
            )
          ],
          selectedIndex: _page,
          onTabChange: (value) {
            onPageChanged(value);
          },
        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const StudentsHeaderDrawer(),
              MyDrawerList(context),
            ],
          ),
        ),
      ),
    );
  }
}
