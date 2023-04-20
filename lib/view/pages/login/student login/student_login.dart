// ignore_for_file: must_be_immutable

import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:dujo_kerala_application/view/pages/login/student%20login/text_form_hide/password_filed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';



import '../../../constant/sizes/constant.dart';
import '../../../widgets/container_image.dart';
import '../../../widgets/fonts/google_monstre.dart';
import '../../../widgets/fonts/google_poppins.dart';
import '../../../widgets/login_button.dart';
import '../widgets/textformfield_login.dart';

class StudentLogin extends StatelessWidget {
    PasswordField hideGetxController = Get.find<PasswordField>();

  String adminpassword = '';
   StudentLogin({super.key});
  
  TextEditingController emailIdController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

   final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return 
    Form(
      child: Scaffold(
       
        body: ListView(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children:  [
            Center(
              child: ContainerImage(
                  height: 350.h,
                  width: double.infinity,
                  imagePath: 'assets/images/Login_screen.png'),
            ),
            Expanded(
              child: Form
              (key: formKey,
                child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 140.w),
                      child: GoogleMonstserratWidgets(fontsize: 45,
                      text: 'Login',color:cblack ,fontWeight: FontWeight.w500,
                      letterSpacing:0.5,),
                    ),
                    SigninTextFormfield(obscureText: false,hintText: 'Email id',
                      labelText: 'Enter Mail ID',  
                         prefixIcon: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.mail_outline,),
                            ),
                     
                       textEditingController: emailIdController,
                        function:checkFieldEmailIsValid ),
              
                        Obx(() => SigninTextFormfield(hintText: 'Password',
                            obscureText:hideGetxController.isObscurefirst.value,
                                              labelText: 'Password',  
                                              icon: Icons.lock, 
                                              textEditingController: passwordController,
                                              function: checkFieldPasswordIsValid,
                                               prefixIcon: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.lock),
                              ),
                                              suffixIcon:IconButton(
                                  icon: Icon(
                                      hideGetxController.isObscurefirst.value
                                         ? Icons.visibility
                                          : Icons.visibility_off),
                                           onPressed: () { hideGetxController.toggleObscureFirst(); },
                               
                                ), ),
                        ),
              kHeight20,
                       Padding(
                         padding:  EdgeInsets.only(left: 150.w),
                         child: GooglePoppinsWidgets(onTap: () {},
                                     fontsize: 18,text:'Forgot Password?' ,
                                     fontWeight: FontWeight.w400,color: adminePrimayColor,),
                       ),
              
                Padding(
                  padding:  EdgeInsets.only(top:20.h),
                  child: GestureDetector(onTap: () {
                     // ignore: unused_local_variable
                     bool? result = formKey.currentState?.validate();
                  },
                    child: loginButtonWidget(text: 'Login',
                     
                    ),
                  ),
                ),
                kHeight20,
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GooglePoppinsWidgets(text: "Don't Have an account!", fontsize: 15),
                    kWidth60,
                    GooglePoppinsWidgets(text: 'Sign Up', fontsize: 18,color: cblue,)
                  ],
                ),
                 Center(child: Row(mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                    ContainerImage(height: 60.h, width: 60.w,
                     imagePath: 'assets/images/leptonlogo.png'),
                     GooglePoppinsWidgets(text: "Lepton DuJo", fontsize: 15,color:cred,fontWeight: FontWeight.w600, ),
                   ],
                 )),
                  ],
                ),
              ),
              
            ),
          
          
          
          
        ],),
        ),
    );
  }
}
