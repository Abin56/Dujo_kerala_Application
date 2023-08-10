import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/sruthi/widget/exm_upload_textformfeild.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:dujo_kerala_application/view/pages/Subject/sunject_display_teacher.dart';
import 'package:dujo_kerala_application/view/widgets/button_container_widget.dart';
import 'package:dujo_kerala_application/widgets/Iconbackbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/get_utils.dart';
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
             Text("Chapter Upload".tr),
          ],
        ),
        backgroundColor: adminePrimayColor,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            kHeight20,
            ExamUploadTextFormFeild(
              validator: (val){
                if(val!.isEmpty){
                  return 'Please enter values';
                }
                return null;
              },
                textfromController: chapterNumberController,
                text: "Chapter No.".tr,
                hintText: "Chapter Number".tr),
            kHeight20,
            ExamUploadTextFormFeild(
                validator: (val){
                if(val!.isEmpty){
                  return 'Please enter values';
                }
                return null;
              },
                textfromController: chapterNameController,
                text: "Chapter Name".tr,
                hintText: "Chapter Name".tr),
            kHeight20,
            ExamUploadTextFormFeild(
                validator: (val){
                if(val!.isEmpty){
                  return 'Please enter values';
                }
                return null;
              },
                textfromController: subjectNameController,
                text: "Subject Name".tr,
                hintText: "Subject Name".tr),
            kHeight20,
            GestureDetector(
              onTap: () {
                //print('subjejctname: ${subjectNameController.text}');

                if(_formKey.currentState!.validate()){

                
                String generatedDocID =  subjectNameController.text.trim()+idgen.v1();
                uploadChapters(generatedDocID).then((value) { 
      
                  
                  return showDialog(context: context, 
                builder: (context){
                  return  AlertDialog(
                    title:  Text('Chapter Upload'.tr),
                    content:  Text('New Chapter Added!'.tr),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: MaterialButton(child: Text('Ok'.tr), onPressed: () => Navigator.pop(context),),
                      )
                    ],
                  );
                });});}
              },
              child: ButtonContainerWidget(
                curving: 18,
                colorindex: 2,
                height: 70.h,
                width: 300.w,
                child: Center(
                  child: Text(
                    "SUBMIT".tr,
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
                      "UPLOAD STUDY MATERIALS".tr,
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
      ),
    );
  }
}
