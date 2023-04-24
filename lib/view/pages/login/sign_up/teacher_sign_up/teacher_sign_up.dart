// ignore_for_file: must_be_immutable

import 'package:dropdown_search/dropdown_search.dart';
import 'package:dujo_kerala_application/view/widgets/fonts/google_poppins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../model/Signup_Image_Selction/image_selection.dart';
import '../../../../../widgets/login_button.dart';
import '../../../../constant/sizes/sizes.dart';
import '../../../../widgets/bottom_container_profile_photo_container.dart';
import '../../../../widgets/container_image.dart';
import '../../../../widgets/fonts/google_monstre.dart';
import '../../../../widgets/sinup_textform_filed.dart';
import '../../../home/home.dart';

class TeachersSignUpPage extends StatelessWidget {
  TeachersSignUpPage({super.key});
  TextEditingController userNameController = TextEditingController();
  TextEditingController useremailController = TextEditingController();
  TextEditingController houseNameController = TextEditingController();
  TextEditingController houseNumberController = TextEditingController();
  TextEditingController placeController = TextEditingController();

  TextEditingController districtController = TextEditingController();
  TextEditingController altPhoneNoController = TextEditingController();

  final getImageController = Get.put(GetImage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ContainerImage(
                        height: 100.h,
                        width: 100.w,
                        imagePath: 'assets/images/leptonlogo.png'),
                    GoogleMonstserratWidgets(
                      text: 'Lepton Dujo',
                      fontsize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
                GooglePoppinsWidgets(
                  fontsize: 20,
                  fontWeight: FontWeight.w400,
                  text: 'Welcome..',
                ),
                kHeight20,
                Center(
                  child: GooglePoppinsWidgets(
                    fontsize: 24,
                    fontWeight: FontWeight.w600,
                    text: 'Sign up',
                  ),
                ),
                kHeight10,
                Center(
                  child: GooglePoppinsWidgets(
                    fontsize: 20,
                    fontWeight: FontWeight.w300,
                    text: 'Personal Data',
                  ),
                ),
              ],
            ),
          ),
          kHeight10,
          Stack(children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundImage: const NetworkImage(
                        "https://img.freepik.com/premium-photo/teenager-student-girl-yellow-pointing-finger-side_1368-40175.jpg"),
                    radius: 60,
                    child: Stack(
                      children: [
                        InkWell(
                          onTap: () async {
                            _getCameraAndGallery(context);
                          },
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor:
                                  const Color.fromARGB(255, 95, 92, 92),
                              child: IconButton(
                                icon: const Icon(Icons.camera_alt),
                                color: Colors.white,
                                onPressed: () async {
                                  _getCameraAndGallery(context);
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  kHeight10,
                  GooglePoppinsWidgets(
                    text: "ID : 8934883839",
                    fontsize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                  kWidth30,
                  SinUpTextFromFiled(
                      text: "Your Name",
                      hintText: 'Miss Latha',
                      textfromController: useremailController),
                  SinUpTextFromFiled(
                      text: "Your email",
                      hintText: 'latha@gmailcom',
                      textfromController: useremailController),
                  Padding(
                    padding: EdgeInsets.only(left: 8.h, right: 8.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GooglePoppinsWidgets(
                          text: "Gender",
                          fontsize: 14,
                          fontWeight: FontWeight.w300,
                        ),
                        kWidth30,
                        SizedBox(
                          width: 330.w,
                          child: DropdownSearch<String>(
                            selectedItem: 'Select Gender',
                            validator: (v) =>
                                v == null ? "required field" : null,
                            items: const ['Male', 'Female', 'Others'],
                          ),
                        ),
                      ],
                    ),
                  ),
                  kHeight30,
                  SinUpTextFromFiled(
                      text: 'House Name',
                      hintText: 'Enter your House Name',
                      textfromController: houseNameController),
                  SinUpTextFromFiled(
                      keyboardType: TextInputType.number,
                      text: 'House Number',
                      hintText: 'Enter your House Number',
                      textfromController: houseNumberController),
                  SinUpTextFromFiled(
                      text: 'Place',
                      hintText: 'Enter your Place',
                      textfromController: placeController),
                  SinUpTextFromFiled(
                      text: 'District',
                      hintText: 'Enter your District',
                      textfromController: districtController),
                  SinUpTextFromFiled(
                      keyboardType: TextInputType.number,
                      text: ' Al Phone Number',
                      hintText: 'Enter your Al Phone Number',
                      textfromController: altPhoneNoController),
                  kHeight30,
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: GestureDetector(
                      onTap: () {
                        Get.offAll(const HomeScreen());
                        
                      },
                      child: loginButtonWidget(
                          height: 60, width: 180, text: 'Submit'),
                    ),
                  ),
                ],
              ),
            ),
          ])
        ],
      )),
    );
  }

 void _getCameraAndGallery(BuildContext context ) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return BottomProfilePhotoContainerWidget(
              getImageController: getImageController);
        });
  }
}
