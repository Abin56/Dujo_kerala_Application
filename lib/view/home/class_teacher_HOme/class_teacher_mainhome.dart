import 'package:dujo_kerala_application/controllers/log_out/user_logout_controller.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/home/class_teacher_HOme/class_teacher_home.dart';
import 'package:dujo_kerala_application/view/pages/live_classes/teacher_live_section/create_room.dart';
import 'package:dujo_kerala_application/view/widgets/container_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

import '../drawer/class_teacher.dart';
import '../sample/under_maintance.dart';

class ClassTeacherMainHomeScreen extends StatefulWidget {
  const ClassTeacherMainHomeScreen({Key? key}) : super(key: key);

  @override
  State<ClassTeacherMainHomeScreen> createState() =>
      _ClassTeacherMainHomeScreenState();
}

class _ClassTeacherMainHomeScreenState
    extends State<ClassTeacherMainHomeScreen> {
  UserLogOutController userLogOutController = Get.put(UserLogOutController());
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
      ClassTeacherHomeScreen(),
      const UnderMaintanceScreen(text: ""),
      CreateRoomScreen(),
      const UnderMaintanceScreen(text: ""),
    ];
    return Scaffold(
       appBar: AppBar(
     title: ContainerImage(
            height: 28.h,
            width: 90.w,
            imagePath: 'assets/images/dujoo-removebg.png'),backgroundColor: adminePrimayColor),
          // actions: [
          //   PopupMenuButton(
          //     onSelected: (value) {
          //       value = userLogOutController.logout.value;
          //     },
          //     itemBuilder: (context) => [
          //       PopupMenuItem(
          //         value: userLogOutController.logout.value,
          //         onTap: () async {
          //           userLogOutController.logout.value == true;
          //           if (userLogOutController.logout.value == true) {
          //             userLogOutController.logOut(context);
          //           }
          //         },
          //         child: GestureDetector(
          //             onTap: () async {}, child: const Text('Logout')),
          //       )
          //     ],
          //   )
          // ]),
     
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
          tabs:  [
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
              text: 'Chat With Bot'.tr,
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
               ClassTeacherHeaderDrawer(),
              MyDrawerList(context),
            ],
          ),
        ),
),
);
}
}