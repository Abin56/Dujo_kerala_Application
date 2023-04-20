import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/pages/login/widgets/login_screenDegin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../fonts/fonts.dart';
import '../../../widgets/container_image.dart';
import '../../../widgets/fonts/google_monstre.dart';
import '../widgets/textformfield_login.dart';

class StudentLogin extends StatelessWidget {
  const StudentLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: 
      Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children:  [
          Center(
            child: ContainerImage(
                height: 350.h,
                width: double.infinity,
                imagePath: 'assets/images/student_profile.jpeg'),
          ),
          Expanded(
            child: Container(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 140.w),
                    child: GoogleMonstserratWidgets(fontsize: 45,
                    text: 'Login',color:cblack ,fontWeight: FontWeight.w500,
                    letterSpacing:0.5,),
                  ),
                  SigninTextFormfield(
                    labelText: 'Enter Mail ID',  
                    icon: Icons.mail_outline, ),

                      SigninTextFormfield(
                    labelText: 'Password',  
                    icon: Icons.lock, ),
                ],
              ),
            ),
          ),




      ],)
      ),
      );
  }
}
