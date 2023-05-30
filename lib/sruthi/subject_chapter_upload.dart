import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/sruthi/widget/exm_upload_textformfeild.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:dujo_kerala_application/view/pages/Subject/sunject_display_teacher.dart';
import 'package:dujo_kerala_application/view/widgets/button_container_widget.dart';
import 'package:dujo_kerala_application/widgets/Iconbackbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';

import '../controllers/userCredentials/user_credentials.dart';

class ChapterUpoload extends StatelessWidget {
  ChapterUpoload({super.key, required this.subjectID});

  TextEditingController chapterNumberController = TextEditingController();
  TextEditingController chapterNameController = TextEditingController();
  TextEditingController subjectNameController = TextEditingController();

  String subjectID;

  Uuid idgen = const Uuid();

  Future<void> uploadChapters(id) async {
    FirebaseFirestore.instance
        .collection('SchoolListCollection')
        .doc(UserCredentialsController.schoolId)
        .collection(UserCredentialsController.batchId!)
        .doc(UserCredentialsController.batchId)
        .collection('classes')
        .doc(UserCredentialsController.classId)
        .collection('subjects')
        .doc(subjectID)
        .collection('Chapters')
        .doc(id)
        .set({
      'chapterNumber': chapterNumberController.text,
      'chapterName': chapterNameController.text,
      'subjectName': subjectNameController.text,
      'docid': id, 
      'uploadedBy': UserCredentialsController.teacherModel!.teacherName.toString()
    }).then((value) {
        chapterNameController.clear() ; 
        chapterNumberController.clear(); 
        subjectNameController.clear();
    }
              
                  ); 
              
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButtonBackWidget(
              color: cWhite,
            ),
            const Text("Chapter Upload"),
          ],
        ),
        backgroundColor: adminePrimayColor,
      ),
      body: Column(
        children: [
          kHeight20,
          ExamUploadTextFormFeild(
              textfromController: chapterNumberController,
              text: "Chapter No.",
              hintText: "Chapter Number"),
          kHeight20,
          ExamUploadTextFormFeild(
              textfromController: chapterNameController,
              text: "Chapter Name",
              hintText: "Chapter Name"),
          kHeight20,
          ExamUploadTextFormFeild(
              textfromController: subjectNameController,
              text: "Subject Name",
              hintText: "Subject Name"),
          kHeight20,
          GestureDetector(
            onTap: () {
              //print('subjejctname: ${subjectNameController.text}');
              String generatedDocID =  subjectNameController.text.trim()+idgen.v1();
              uploadChapters(generatedDocID).then((value) { 

                
                return showDialog(context: context, 
              builder: (context){
                return  AlertDialog(
                  title: const Text('Chapter Upload'),
                  content: const Text('New Chapter Added!'),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: MaterialButton(child:const Text('OK'), onPressed: () => Navigator.pop(context),),
                    )
                  ],
                );
              });});
            },
            child: ButtonContainerWidget(
              curving: 18,
              colorindex: 2,
              height: 70.h,
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
          ), 
          const SizedBox(height: 20,),
          GestureDetector( 
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) =>  SubjectWiseDisplayTeacher(subjectID: subjectID),));
            },
            child: ButtonContainerWidget(
                curving: 18,
                colorindex: 2,
                height: 70.h,
                width: 300.w,
                child: Center(
                  child: Text(
                    "UPLOAD STUDY MATERIALS",
                    style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
          ),
        ],
      ),
    );
  }
}
