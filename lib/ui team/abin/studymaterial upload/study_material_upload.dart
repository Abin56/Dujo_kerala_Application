import 'dart:developer';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:dujo_kerala_application/view/widgets/fonts/google_monstre.dart';
import 'package:dujo_kerala_application/widgets/textformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../view/colors/colors.dart';
import '../../../view/widgets/button_container_widget.dart';

class StudyMaterialUpload extends StatefulWidget {
  const StudyMaterialUpload({super.key});

  @override
  State<StudyMaterialUpload> createState() => _StudyMaterialUploadState();
}

class _StudyMaterialUploadState extends State<StudyMaterialUpload> {
  String _selectedLeaveType = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: cblack,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        title: Text(
          "Study Material",
          style: GoogleFonts.montserrat(
            color: Colors.grey,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: cblack),
      ),
      body: SingleChildScrollView(
        child: Column(
          //  mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            kHeight10,
            Container(
              height: 680.w,
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  /// mainAxisAlignment: MainAxisAlignment.start,
                  /// crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GoogleMonstserratWidgets(
                        text: 'Study Material upload',
                        fontsize: 13.h,
                        color: cgrey,
                        fontWeight: FontWeight.w700),
                    kWidth20,
                    Container(
                      height: 130.h,
                      width: double.infinity - 20.w,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: cblue,
                          width: 2.0,
                        ),
                      ),
                      child: Row(
                       // crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.attach_file_rounded,color: cblue,size: 30.w,weight: 10),
                            
                            // icon: Image.asset(
                            //   'assets/images/upload.png',
                            //  width: 90.w,
                             // height: 90.h,
                           // ),
                          ),
                          GoogleMonstserratWidgets(text: 'Upload file here', 
                          fontsize: 22,color: cblue,
                          fontWeight: FontWeight.bold,),
                          kWidth20,
                         
                        ],
                      ),
                    ),
                    kWidth20,
                    TextFormFieldWidget(
                      hintText: 'Subject Name',
                    ),
                    kHeight20,
                    Text(
                      "Choose the Chapter",
                      style: GoogleFonts.montserrat(
                          color: Colors.grey,
                          fontSize: 16.h,
                          fontWeight: FontWeight.w700),
                    ),
                    kHeight10,
                    Padding(
                      padding: EdgeInsets.only(left: 15.w, right: 15.w),
                      child: DropdownSearch<String>(
                        selectedItem: 'Select the Chapter',
                        validator: (v) => v == null ? "required field" : null,
                        items: const [
                          "Chapter 1",
                          "Chapter 2",
                          "Chapter 3",
                          'Chapter 4',
                          'Chapter 5'
                        ],
                        onChanged: (value) {
                          setState(() {
                            _selectedLeaveType = value!;
                          });
                        },
                      ),
                    ),
                    kHeight20,
                    TextFormFieldWidget(
                      hintText: 'Enter Topic',
                    ),
                    kHeight20,
                    TextFormFieldWidget(
                      hintText: 'Enter Title',
                    ),
                    kHeight40,
                    GestureDetector(
                      onTap: () {},
                      child: ButtonContainerWidget(
                        curving: 18,
                        colorindex: 2,
                        height: 60.w,
                        width: 300.w,
                        child: Center(
                          child: Text(
                            "SUBMIT",
                            style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),

            kHeight30,
           
          ],
        ),
      ),
    );
  }
}

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(resizeToAvoidBottomInset: false,
//       backgroundColor: cWhite,
//       appBar: AppBar( title: Row(
//           children: [
//             IconButtonBackWidget(color: cblack),SizedBox(width: 50.h,),
//             GoogleMonstserratWidgets(text: "Study Material upload", fontsize: 20.h,color: cblack,fontWeight: FontWeight.w600,)
//           ],
//         ),backgroundColor: cWhite),
//     body: Column(mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//       StudyContainerWidget(
//         hintText: 'Subject Name',
//         //hintText1: 'Enter Chapter Name',
//         hintText2:'Enter Topic',
//       hintText3:'Enter Title Name',

//        ),
//     ]),);
//   }
// }

// class StudyContainerWidget extends StatelessWidget {
//    StudyContainerWidget({
//     required this.hintText,
//     //required this.hintText1,
//     required this.hintText2,
//     required this. hintText3,

//     super.key,
//   });
//   String hintText;
//  // String hintText1;
//   String hintText2;
//   String hintText3;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(left: 15.h,right: 15.h),
//       height: 600.h,
//       width: double.infinity,
//       decoration: BoxDecoration(color: Color.fromARGB(255, 71, 73, 167),
//       borderRadius: BorderRadius.all(
//         Radius.circular(20.h))
//         ),
//         child: Column(children: [
//             TextFormFieldWidget(hintText: hintText,
//            // textEditingController:
//             ),
//              SizedBox(
//                             width: 330.w,
//                             child: DropdownSearch<String>(
//                               selectedItem: 'Chapter',
//                               validator: (v) =>
//                                   v == null ? "required field" : null,
//                               items: const ['Chapter 1', 'Chapter 2', 'Chapter 3'],
//                               onChanged: (value) {
//                                // studentController.gender = value;
//                               },
//                             ),
//                           ),
//             // TextFormFieldWidget(hintText: hintText1,
//              //textEditingController:
//             //  ),
//               TextFormFieldWidget(hintText: hintText2,
//               //textEditingController:
//               ),
//               TextFormFieldWidget(hintText: hintText3,
//              // textEditingController:
//               ),

//               kHeight20,

//              UploadButtonWidget(text: 'Upload Doc'),
//               kHeight20,
//               UploadButtonWidget(text: 'Submit'),

//           ]),
//         );
//   }
// }
