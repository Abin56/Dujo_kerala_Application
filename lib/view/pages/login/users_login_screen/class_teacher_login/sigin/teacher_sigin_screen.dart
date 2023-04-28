// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:dujo_kerala_application/controllers/sign_up_controller/teacher_signup_controller.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:dujo_kerala_application/model/Text_hiden_Controller/password_field.dart';
import 'package:dujo_kerala_application/model/teacher_model/teacher_model.dart';
import 'package:dujo_kerala_application/utils/utils.dart';
import 'package:dujo_kerala_application/view/constant/sizes/constant.dart';
import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:dujo_kerala_application/view/pages/login/users_login_screen/class_teacher_login/class_teacher_login.dart';
import 'package:dujo_kerala_application/view/widgets/Leptonlogoandtext.dart';
import 'package:dujo_kerala_application/view/widgets/container_image.dart';
import 'package:dujo_kerala_application/widgets/login_button.dart';
import 'package:dujo_kerala_application/view/widgets/textformfield_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';

import '../../../../../../controllers/userCredentials/user_credentials.dart';
import '../../../userVerify_Phone_OTP/get_otp..dart';

class TeachersSignInScreen extends StatefulWidget {
  int pageIndex;

  TeachersSignInScreen({required this.pageIndex, super.key});

  @override
  State<TeachersSignInScreen> createState() => _TeachersSignInScreenState();
}

class _TeachersSignInScreenState extends State<TeachersSignInScreen> {
  PasswordField hideGetxController = Get.find<PasswordField>();

  final formKey = GlobalKey<FormState>();
    TeacherSignUpController teacherSignUpController =
      Get.put(TeacherSignUpController());


  TextEditingController verificationIdController = TextEditingController();

  TextEditingController verificationpasswordController =
      TextEditingController();

  TextEditingController verificationconfirmController = TextEditingController(); 

  String? mailCheckValue;

  String? so; 

  Future<bool> checkMail()async{
     final CollectionReference collectionRef = FirebaseFirestore.instance.collection('SchoolListCollection').doc(UserCredentialsController.schoolId).collection('Teachers');


final QuerySnapshot querySnapshot =
    await collectionRef.where('teacherEmail', isEqualTo: verificationIdController.text).get();


if (querySnapshot.docs.isNotEmpty) {

  log("Value is present in the collection.");
  return true;
} else {
  showToast(msg: 'The mail you entered is not matching with the mail in database');
  return false;
}   



  } 

  bool passwordCheck(){
                             
if(verificationpasswordController.text == verificationconfirmController.text){
  log('password matches');
  return true;
} else{
  log('passwords does not match');
  return false;
}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            const leptonDujoWidget(),
            //  kHeight20,
            ContainerImage(
              height: 250.h,
              width: double.infinity,
              imagePath: 'assets/images/splash.png',
            ),
            kHeight30,
            Obx(()=> teacherSignUpController.isLoading.value
                ? circularProgressIndicatotWidget
                : SizedBox(
                   height: 60.h,
              width: 350.w,
                  child: DropdownSearch<TeacherModel>(
                
                        selectedItem: TeacherModel(teacherName: 'Select Teacher',
                         teacherEmail: '', houseName: '',
                          houseNumber: '', place: '', gender: '', 
                          district: '', altPhoneNo: '', 
                          employeeID: '', joinDate: '', teacherPhNo: "",
                          docid: '', userRole: ''), 
                             validator: (v) => v == null ? "required field" : null,
                          items: teacherSignUpController.teachersList,
                          itemAsString: (TeacherModel u) => u.teacherName,
                          onChanged: (value) {
                            UserCredentialsController.teacherModel = value;
                            log('${value!.teacherPhNo}');
                  }),
          )),
 
    
    
                  // return DropdownButtonFormField(
                  //   hint: Text('Select Teacher'),
                  //   validator: (v) => v == null ? "required field" : null,
                  //   items: dropdownItems, value: so,
                  //   onChanged: (val){
                  //     setState(() {
                  //       so = val;
                  //     }); 
                  //     print(so);
                  //   },
                  // );
            
            kHeight30,
            Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  kHeight10,
                  SigninTextFormfield(
                      obscureText: false,
                      hintText: 'Email id',
                      labelText: 'Enter Mail ID',
                      
                      prefixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.mail_outline,
                        ),
                        
                      ),
                      textEditingController: teacherSignUpController.emailController,
                      function: checkFieldEmailIsValid),
                  Obx(
                    () => SigninTextFormfield(
                      hintText: 'Password',
                      obscureText: hideGetxController.isObscurefirst.value,
                      labelText: 'Password',
                      icon: Icons.lock,
                      textEditingController: teacherSignUpController.passwordController,
                      function: checkFieldPasswordIsValid,
                      prefixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.lock),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(hideGetxController.isObscurefirst.value
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          hideGetxController.toggleObscureFirst();
                        },
                      ),
                    ),
                  ),
                  Obx(
                    () => SigninTextFormfield(
                      hintText: 'Confirm Password',
                      obscureText: hideGetxController.isObscureSecond.value,
                      labelText: 'Confirm Password',
                      icon: Icons.lock,
                      textEditingController: verificationconfirmController,
                      function: checkFieldPasswordIsValid,
                      prefixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.lock),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(hideGetxController.isObscureSecond.value
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          hideGetxController.toggleObscureSecond();
                        },
                      ),
                    ),
                  ),
                  kHeight10,
                  Padding(
                    padding: EdgeInsets.only(top: 20.h),
                    child: GestureDetector( 
                      onTap: (){
                        if (formKey.currentState!.validate()) {
                        if (UserCredentialsController
                                .teacherModel?.teacherPhNo != '' || UserCredentialsController
                                .teacherModel?.teacherPhNo != null
                            ) {
                          Get.to(() => UserSentOTPScreen(
                                userpageIndex: widget.pageIndex,
                                phoneNumber:
                                    "+91${UserCredentialsController.teacherModel?.teacherPhNo}",
                                userEmail: teacherSignUpController
                                    .emailController.text,
                                userPassword: teacherSignUpController
                                    .passwordController.text,
                              ));
                        } else {
                          showToast(msg: "Please select student detail.");
                        }
                      }},
                        // var k = await checkMail();
                        // if(passwordCheck() && k){
                        //   //Navigator.push(context, MaterialPageRoute(builder:(context) => UserSentOTPScreen(phoneNumber: ),));
                        // }
                        // else{
                        //   log('not okay');
                        // }
              //  },
                    
                      child: loginButtonWidget(
                                 height: 60,
                        width: 180,
                        text: 'Submit', 
                        
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
