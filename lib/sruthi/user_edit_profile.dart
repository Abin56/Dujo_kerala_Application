import 'package:dujo_kerala_application/sruthi/edit_image_selection_widget.dart';
import 'package:dujo_kerala_application/sruthi/user_edit_page_widget.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../view/colors/colors.dart';
import '../view/constant/sizes/sizes.dart';
import '../view/widgets/fonts/google_poppins.dart';
import '../widgets/Iconbackbutton.dart';

class UserEditPage extends StatelessWidget {
  String newEmail = "";
  UserEditPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: ListView(children: [
      Container(
        width: double.infinity,
        height: 300.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12.h),
              bottomRight: Radius.circular(12.h)),
          color: adminePrimayColor,
        ),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButtonBackWidget(
                color: cWhite,
                
              ),
              kWidth50,
              GooglePoppinsWidgets(text: "Profile", fontsize: 22.h,color: cWhite,)
            ],
          ),
          kHeight20,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(children: [
                SingleChildScrollView(
                  child: CircleAvatharImageSelectionWidget(),
                ),
                kHeight20,
              ]),
            ],
          )
        ]),
      ),
    
      Container(
        width: double.infinity,
        height: 700.h,
        child: Expanded(
          child: ListView(
            children: [
            
              UserEditListileWidget(
                icon: Icons.person,
                subtitle: GooglePoppinsWidgets(text: "Anu", fontsize: 19.h),
                title: GooglePoppinsWidgets(text: "Name", fontsize: 12.h),
              ),
              UserEditListileWidget(
                icon: Icons.call,
                subtitle:
                    GooglePoppinsWidgets(text: "9867543223", fontsize: 19.h),
                title: GooglePoppinsWidgets(text: "Phone No.", fontsize: 12.h),
              ),
              UserEditListileWidget(
                icon: Icons.email,
                subtitle:
                    GooglePoppinsWidgets(text: "anu@gmail.com", fontsize: 19.h),
                title: GooglePoppinsWidgets(text: "Email", fontsize: 12.h),
                editicon: Icons.edit,
              ),
              UserEditListileWidget(
                icon: Icons.class_rounded,
                subtitle: GooglePoppinsWidgets(text: "9 A", fontsize: 19.h),
                title: GooglePoppinsWidgets(text: "Class", fontsize: 12.h),
              ),
              UserEditListileWidget(
                icon: Icons.bloodtype_outlined,
                subtitle: GooglePoppinsWidgets(text: "Blood Group", fontsize: 19.h),
                title: GooglePoppinsWidgets(text: "A -ve", fontsize: 12.h),
              ),
              UserEditListileWidget(
                icon: Icons.home,
                subtitle: GooglePoppinsWidgets(text: "Address", fontsize: 19.h),
                title: GooglePoppinsWidgets(text: "Adress", fontsize: 12.h),
              ),
              
            ],
          ),
        ),
      ),
    ])));
  }
}



