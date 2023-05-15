import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/home/parent_home/parent_home_screen.dart';
import 'package:dujo_kerala_application/view/home/sample/under_maintance.dart';
import 'package:dujo_kerala_application/view/widgets/container_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

import '../drawer/parent_drawer.dart';

class ParentMainHomeScreen extends StatefulWidget {
  const ParentMainHomeScreen({Key? key}) : super(key: key);

  @override
  State<ParentMainHomeScreen> createState() => _ParentMainHomeScreenState();
}

class _ParentMainHomeScreenState extends State<ParentMainHomeScreen> {
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
      ParentHomeScreen(),
      const UnderMaintanceScreen(text: ""),
      const UnderMaintanceScreen(text: ""),
      const UnderMaintanceScreen(text: ""),
    ];
    return Scaffold(
      appBar: AppBar(
     title: ContainerImage(
            height: 28.h,
            width: 90.w,
            imagePath: 'assets/images/dujoo-removebg.png'),backgroundColor: adminePrimayColor,),
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
          tabs: const [
            GButton(
                iconSize: 20,
                icon: LineIcons.home,
                text: 'Home',
                style: GnavStyle.google),
            GButton(
              iconSize: 20,
              textSize: 9,
              icon: Icons.tv,
              text: 'ReC_ Classes',
            ),
            GButton(
              iconSize: 20,
              // iconSize: 10,
              textSize: 12,
              icon: Icons.laptop,
              text: 'Live Classes',
            ),
            GButton(
              iconSize: 20,
              icon: Icons.live_tv_sharp,
              text: 'Profile',
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
              const ParentHeaderDrawer(),
              MyDrawerList(context),
            ],
          ),
        ),
      ),
    );
  }
}
