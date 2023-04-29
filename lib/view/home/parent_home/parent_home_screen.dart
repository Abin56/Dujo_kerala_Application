// ignore_for_file: use_key_in_widget_constructors, must_call_super, annotate_overrides, non_constant_identifier_names
import 'package:dujo_kerala_application/controllers/get_parent&guardian/getx.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/home/parent_home/parent_accessories/parent_access.dart';
import 'package:dujo_kerala_application/view/widgets/fonts/google_monstre.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../sruthi/User Edit Profile/user_edit_profile.dart';

class ParentHomeScreen extends StatefulWidget {
  @override
  State<ParentHomeScreen> createState() => _ParentHomeScreenState();
}

class _ParentHomeScreenState extends State<ParentHomeScreen> {
  GetParentAndGuardian getxController = Get.put(GetParentAndGuardian());
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Obx(() {
      getxController.fetchAllParentData();

      if (getxController.parentNAme.value.isEmpty &&
          getxController.parentID.value.isEmpty &&
          getxController.parentEmail.value.isEmpty &&
          getxController.studentID.value.isEmpty &&
          getxController.parentIMage.value.isEmpty) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else {
        getxController.fetchStudentDetail();
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
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: screenSize.width / 2,
                              child: GoogleMonstserratWidgets(
                                overflow: TextOverflow.ellipsis,
                                text: getxController.parentNamee.value,
                                fontsize: 23.sp,
                                fontWeight: FontWeight.bold,
                                color: cWhite,
                              ),
                            ),
                            Stack(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Get.to(UserEditPage());
                                  },
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        getxController.parentIMage.value),
                                    radius: 50.r,
                                  ),
                                ),
                                Positioned(
                                  right: 6.r,
                                  bottom: 1.r,
                                  child: CircleAvatar(
                                    backgroundColor: cWhite,
                                    radius: 12.r,
                                    child:
                                        const Center(child: Icon(Icons.info)),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Obx(() => 
                      getxController.studentName.isEmpty?
                      const Text('')
                      :
                      GoogleMonstserratWidgets(
                            text: 'Student : ${getxController.studentName.value} ',
                            fontsize: 14.5.sp,
                            fontWeight: FontWeight.w500,
                            color: cWhite.withOpacity(0.8),
                          )),
                      GoogleMonstserratWidgets(
                        text: 'email : ${getxController.parentEmail.value}',
                        fontsize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: cWhite.withOpacity(0.7),
                      ),
                    ],
                  ),
                ),
                const ParentAccessories(),
              ],
            ),
          ),
        );
      }
    });
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
