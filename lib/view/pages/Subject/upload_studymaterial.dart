import 'dart:developer';
import 'dart:io';

import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:dujo_kerala_application/view/widgets/fonts/google_monstre.dart';
import 'package:dujo_kerala_application/widgets/textformfield.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';

import '../../../view/colors/colors.dart';
import '../../../view/widgets/button_container_widget.dart';

class UploadStudyMaterial extends StatefulWidget {
  UploadStudyMaterial({super.key, required this.subjectID, required this.subjectName, required this.chapterName});

  String subjectID;
  String subjectName;
  String chapterName;

  @override
  State<UploadStudyMaterial> createState() => _UploadStudyMaterialState();
}

class _UploadStudyMaterialState extends State<UploadStudyMaterial> {
  final String _selectedLeaveType = '';
  TextEditingController subjectNameController = TextEditingController();
  TextEditingController topicController = TextEditingController();
  TextEditingController titleController = TextEditingController(); 

  File? filee;

  Future<String> pickAFile(file) async{
    try{
          // log('gggggg${studentListValue?['studentName']}');
       String uid2 = const Uuid().v1();
      //isImageUpload.value = true; 
      
      UploadTask uploadTask =  FirebaseStorage.instance.ref()
      .child("files/studymaterials/${widget.subjectName}/${widget.chapterName}/$uid2")
      .putData(file);  

      final TaskSnapshot snap = await uploadTask;
      String downloadUrl = await snap.ref.getDownloadURL(); 
      log('downloadUrl $downloadUrl');  

      return downloadUrl;

 

      // final path =   'teachernotes/${pickedFile!.name}';
      //          final file =  pickedFile!.bytes;
      //          log('this is path: $path');
      //          final ref = FirebaseStorage.instance.ref().child(path);
      //          ref.putData(file!);
      //          log('completed ${ref.fullPath}'); 

   ///////////////////////////////////////////////////////   
 
     
      
     } catch(e){
      log(e.toString()); 
      return e.toString();
     }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
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
        iconTheme: const IconThemeData(color: cblack),
      ),
      body: SingleChildScrollView(
        child: Column(
          //  mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            kHeight10,
            SizedBox(
              height: 680.w,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(20),
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
                    GestureDetector( 
                      onTap: ()async{
                         FilePickerResult? result =
                                  await FilePicker.platform.pickFiles();

                              if (result != null) {
                                File file = File(result.files.single.path!); 
                                setState(() {
                                  filee = file;
                                });
                              } else {
                                print('No file selected');
                              } 

                              pickAFile(filee);
                      },
                      child: Container(
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
                            
                              Icon(Icons.attach_file_rounded,
                                  color: cblue, size: 30.w, weight: 10),
                    
                              // icon: Image.asset(
                              //   'assets/images/upload.png',
                              //  width: 90.w,
                              // height: 90.h,
                              // ),
                          
                            GoogleMonstserratWidgets(
                              text: (filee ==null)? 'Upload file here' : filee!.path.split('/').last,
                              fontsize: 22,
                              color: cblue,
                              fontWeight: FontWeight.bold, 
                            ),
                            kWidth20,
                          ],
                        ),
                      ),
                    ),
                    kWidth20,
                    kHeight20,

                    //           FirebaseStorage.instance
                    // .ref()
                    // .child(
                    //     "files/scholarshipimages/${studentListValue?['studentName']}/images/$uid")
                    // .putData(file!);
                    kHeight20,
                    TextFormFieldWidget(
                      textEditingController: topicController,
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
