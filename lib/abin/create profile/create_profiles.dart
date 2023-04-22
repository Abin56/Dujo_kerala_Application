
import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:dujo_kerala_application/view/pages/login/users_login_screen/student%20login/student_login.dart';
import 'package:dujo_kerala_application/view/widgets/Leptonlogoandtext.dart';
import 'package:dujo_kerala_application/view/widgets/container_image.dart';
import 'package:dujo_kerala_application/view/widgets/fonts/google_monstre.dart';
import 'package:dujo_kerala_application/view/widgets/fonts/google_poppins.dart';
import 'package:dujo_kerala_application/widgets/Iconbackbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';




class ProfileCreation extends StatelessWidget {
  const ProfileCreation({super.key});

  @override
  Widget build(BuildContext context) {
    int columnCount = 2;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(body: SafeArea(child: 
    Column(children: [
      Row(
        children: [
          IconButtonBackWidget(color: Colors.black),
          const leptonDujoWidget(),
        ],
      ),

      ContainerImage(height: 250.h, width:  370.w, imagePath: 'assets/images/lap.png'),
      kHeight20,
      GooglePoppinsWidgets(text: 'Choose Your Profile ', fontsize: 25,color: Colors.blue,fontWeight: FontWeight.w700),
      kHeight30,
      Expanded(child:  AnimationLimiter(
         child: GridView.count(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                padding: EdgeInsets.all(w / 60),
                crossAxisCount: columnCount,
                children: List.generate(
                  4,
                  (int index) {
                    return AnimationConfiguration.staggeredGrid(
                      position: index,
                      duration: const Duration(milliseconds: 200),
                      columnCount: columnCount,
                      child: ScaleAnimation(
                        duration: const Duration(milliseconds: 900),
                        curve: Curves.fastLinearToSlowEaseIn,
                        child: FadeInAnimation(
                          child: GestureDetector(
                            onTap: () {
                              // print("object");
                              Get.to(navigationScreens[index]);
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  bottom: w / 10, left: w / 20, right: w / 20),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color:
                                        const Color.fromARGB(255, 27, 75, 235),
                                    width: 0.3),
                                color: const Color.fromARGB(250, 55, 144, 207)
                                    .withOpacity(0.4),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(16),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 40,
                                    spreadRadius: 10,
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ContainerImage(
                                      height: 60,
                                      width: 60,
                                      imagePath: icons[index]),
                                  GoogleMonstserratWidgets(
                                    text: userList[index],
                                    letterSpacing: 0.5,
                                    fontsize: 18.h,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
       ),)
    ],)),);
  }
}


List<String> userList = ['Student Profile', 'Parent Profile', 'Guardian Profile', 'Teacher Profile'];

var navigationScreens = [
  StudentLogin(),
   StudentLogin(),
   StudentLogin (),
   StudentLogin(),
];
var icons = [
  'assets/images/profile.png',
  'assets/images/family.png',
  'assets/images/guard.png',
  'assets/images/teacher.png',
];
