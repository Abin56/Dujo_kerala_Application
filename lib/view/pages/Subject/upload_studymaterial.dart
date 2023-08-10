import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:dujo_kerala_application/view/constant/sizes/constant.dart';
import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:dujo_kerala_application/view/pages/Subject/show_teacher_studymaterials.dart';
import 'package:dujo_kerala_application/view/widgets/fonts/google_monstre.dart';
import 'package:dujo_kerala_application/widgets/textformfield.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';

import '../../../view/colors/colors.dart';
import '../../../view/widgets/button_container_widget.dart';

class UploadStudyMaterial extends StatefulWidget {
  UploadStudyMaterial({super.key, required this.subjectID, required this.subjectName, required this.chapterID,required this.chapterName});

  String subjectID;
  String subjectName;
  String chapterName;
  String chapterID;
  bool stat = false;

  @override
  State<UploadStudyMaterial> createState() => _UploadStudyMaterialState();
}

class _UploadStudyMaterialState extends State<UploadStudyMaterial> {
  final String _selectedLeaveType = '';
  TextEditingController subjectNameController = TextEditingController();
  TextEditingController topicController = TextEditingController();
  TextEditingController titleController = TextEditingController(); 

  File? filee;
  String downloadUrl = '';

  Future<String> pickAFile(file) async{
    try{
        setState(() {
      widget.stat = true;
    });

       String uid2 = const Uuid().v1();

      
      UploadTask uploadTask =  FirebaseStorage.instance.ref()
      .child("files/studymaterials/${widget.subjectName}/${widget.chapterName}/$uid2")
      .putFile(file);  

      final TaskSnapshot snap = await uploadTask;
       downloadUrl = await snap.ref.getDownloadURL(); 
      log('downloadUrl $downloadUrl');  
        setState(() {
      widget.stat = true;
    });

      return downloadUrl;

 


     
      
     } catch(e){
      log(e.toString()); 
        setState(() {
      widget.stat = true;
    });
      return e.toString();
     }

  } 

  Future<void>uploadToFirebase()async{ 
    
    try{
    
      String uid = const Uuid().v1();
     FirebaseFirestore.instance
        .collection('SchoolListCollection')
        .doc(UserCredentialsController.schoolId)
        .collection(UserCredentialsController.batchId!)
        .doc(UserCredentialsController.batchId)
        .collection('classes')
        .doc(UserCredentialsController.classId)
        .collection('subjects')
        .doc(widget.subjectID)
        .collection('Chapters')
        .doc(widget.chapterID)
        .collection('StudyMaterials')
        .doc(uid)
        .set({
          'subjectName': widget.subjectName, 
          'chapterName': widget.chapterName, 
          'chapterID': widget.chapterID,
          'subjectID': widget.subjectID, 
          'topicName': topicController.text, 
          'title': titleController.text, 
          'downloadUrl' : downloadUrl,
          'docid': uid, 
          'uploadedBy': UserCredentialsController.teacherModel!.teacherName

        }).then((value) => showDialog(context: context, builder: (context){
          return AlertDialog(
            title:  Text('Study Materials'.tr), 
            content:  Text('New Study Material Added!'.tr),
            actions: [
              MaterialButton(onPressed: (){
                Navigator.pop(context);
              }, child:  Text('Ok'.tr),)
            ],
          );
        }));

          setState(() {
      widget.stat = false;
    });
    } 
    catch(e){
      log(e.toString());
           setState(() {
      widget.stat = false;
    });

    }

  }

 final _formKey = GlobalKey<FormState>();

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
          "Study material".tr, 
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

          children: [
            kHeight10,
            SizedBox(
              height: 680.w,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(

                    children: [
                      GoogleMonstserratWidgets(
                          text: 'Study material upload'.tr,
                          fontsize: 13.h,
                          color: cgrey,
                          fontWeight: FontWeight.w700),
                      kWidth20,
                      GestureDetector( 
                        onTap: ()async{
                           FilePickerResult? result =
                                    await FilePicker.platform.pickFiles(allowedExtensions: ['pdf'], type: FileType.custom);
                
                                if (result != null) {
                                  File file = File(result.files.single.path!); 
                                  setState(() {
                                    filee = file;
                                  });
                                } else {
                                  print('No file selected');
                                } 
                
                               
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

                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              
                                Icon(Icons.attach_file_rounded,
                                    color: cblue, size: 30.w, weight: 10),

                            
                              GoogleMonstserratWidgets(
                                text: (filee ==null)? 'Upload file here' : filee!.path.split('/').last,
                                fontsize: 22,
                                color: cblue,
                                fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis,
                              ),
                              kWidth20,
                            ],
                          ),
                        ),
                      ),
                      kWidth20,
                      kHeight20,

                      kHeight20,
                      TextFormFieldWidget(
                        function: checkFieldEmpty,
                
                        textEditingController: topicController,
                        hintText: 'Enter Topic',
                      ),
                      kHeight20,
                      TextFormFieldWidget(
                         function: checkFieldEmpty,
                        textEditingController: titleController,
                        hintText: 'Enter Title',
                      ),
                      kHeight40,
                  (widget.stat == true)? const Center(child: CircularProgressIndicator(),): GestureDetector(
                        onTap: ()async {

                             if(_formKey.currentState!.validate()){
                 await pickAFile(filee);
                          await uploadToFirebase().then((value) {
                            topicController.clear();
                          titleController.clear();
                          filee = null;
                          } 
                          );
                          }

                          //check here
                         
                        },
                        child:  ButtonContainerWidget(
                          curving: 18,
                          colorindex: 2,
                          height: 60.w,
                          width: 300.w,
                          child: Center(
                            child: Text(
                              "SUBMIT".tr,
                              style: GoogleFonts.montserrat(
                                  color: Colors.white,
                                  fontSize: 13.w,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ), 
                      kHeight20,
                      GestureDetector(
                        onTap: ()async {
                       
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> StudyMaterials(subjectID: widget.subjectID,chapterID: widget.chapterID,)));
                        },
                        child: ButtonContainerWidget(
                          curving: 18,
                          colorindex: 2,
                          height: 60.w,
                          width: 300.w,
                          child: Center(
                            child: Text(
                              "UPLOADED STUDY MATERIALS".tr,
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
            ),
            kHeight30,
          ],
        ),
      ),
    );
  }
}


