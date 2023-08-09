import 'package:dujo_kerala_application/controllers/log_out/user_logout_controller.dart';
import 'package:dujo_kerala_application/main.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/home/class_teacher_HOme/class_teacher_home.dart';
import 'package:dujo_kerala_application/view/pages/live_classes/teacher_live_section/create_room.dart';
import 'package:dujo_kerala_application/view/widgets/container_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

import '../../../controllers/userCredentials/user_credentials.dart';
import '../../pages/chat_gpt/screens/chat_screen.dart';
import '../../pages/recorded_videos/select_subjects.dart';
import '../../pages/splash_screen/splash_screen.dart';
import '../drawer/class_teacher.dart';
import '../teachers_home/teacher_classes_list.dart';

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
    backtoSwitchClass();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    checkingSchoolActivate(context);
    List<Widget> pages = [
      ClassTeacherHomeScreen(),
        RecSelectSubjectScreen(
        batchId: UserCredentialsController.batchId!,
        classID: UserCredentialsController.classId!,
        schoolId: UserCredentialsController.schoolId!,
      ),
      CreateRoomScreen(),
    const ChatScreen(),
    ];
    return WillPopScope(
         onWillPop: () => onbackbuttonpressed(context),
      child: Scaffold(
         appBar: AppBar(
       title: ContainerImage(
              height: 28.h,
              width: 90.w,
              imagePath: 'assets/images/dujoo-removebg.png'),backgroundColor: adminePrimayColor),
       
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
                  iconSize: 20.h,
                  icon: LineIcons.home,
                  text: 'Home'.tr,
                  style: GnavStyle.google),
              GButton(
                iconSize: 30.h,
                textSize: 20,
                icon: Icons.tv,
                text: 'Recorded\nClasses'.tr,
              ),
              GButton(
                iconSize: 30.h,
                // iconSize: 10,
                textSize: 20,
                icon: Icons.laptop,
                text: 'Live\nClasses'.tr,
              ),
              GButton(
                iconSize: 30.h,
                icon: Icons.chat,
                      textSize: 20,
                text: 'Ask\nDoubt'.tr,
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
    ),
    );
}
}