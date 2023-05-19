import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:dujo_kerala_application/view/pages/Subject/upload_studymaterial.dart';
import 'package:dujo_kerala_application/view/widgets/fonts/google_poppins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../chapterdisplay.dart';
import '../show_teacher_studymaterials.dart';

class ChapterDisplay extends StatelessWidget {
   ChapterDisplay({super.key, required this.subjectID}); 

  String subjectID;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(136, 236, 221, 221),
        appBar: AppBar(
          backgroundColor: adminePrimayColor,
          title: const Text("Chapters"),
        ),
        body: Container(
          color: Colors.white54,
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
        .collection('SchoolListCollection')
        .doc(UserCredentialsController.schoolId)
        .collection(UserCredentialsController.batchId!)
        .doc(UserCredentialsController.batchId)
        .collection('classes')
        .doc(UserCredentialsController.classId)
        .collection('subjects')
        .doc(subjectID)
        .collection('Chapters')
        .snapshots(),
        
            builder: (context, snapshot) {
             if(snapshot.hasData){
               return ListView.separated(
                itemCount: snapshot.data!.docs.length,
                separatorBuilder: (BuildContext context, int index) => kHeight10,
                itemBuilder: (BuildContext context, int index) {
                  return ListileCardChapterWidget(leading: const Icon(Icons.note_rounded), title: GooglePoppinsWidgets(
                text: snapshot.data!.docs[index]['chapterName'], fontsize: 20.h,fontWeight: FontWeight.bold,), subtitle:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 10.h),
                  child: GooglePoppinsWidgets(
                      text: snapshot.data!.docs[index]['chapterNumber'], fontsize: 15.h,fontWeight: FontWeight.bold,),
                ),
                InkWell(
                  onTap: () {
                    if(UserCredentialsController.userRole == 'teacher' || UserCredentialsController.userRole == 'classTeacher'){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  
                            
                            //StudyMaterials() 
                          
                     UploadStudyMaterial(subjectID: subjectID,chapterName: snapshot.data!.docs[index]['chapterName'], subjectName: snapshot.data!.docs[index]['subjectName'],
                     chapterID: snapshot.data!.docs[index]['docid'] )
                            
                            ));
                    }
                    else{
                       Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  
                            
                            StudyMaterials(subjectID: subjectID, chapterID: snapshot.data!.docs[index]['docid'], )));
                    }

                  },
                  child: Padding(
                    padding: EdgeInsets.only(top: 10.h),
                    child: GooglePoppinsWidgets(
                      text: "Study Materials",
                      fontsize: 16.h,
                      color: adminePrimayColor,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 18.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GooglePoppinsWidgets(
                          text: "Teacher Name : ",
                          fontsize: 15.h,),
                           GooglePoppinsWidgets(
                          text: snapshot.data!.docs[index]['uploadedBy'] ,
                          fontsize: 15.h,fontWeight: FontWeight.bold,),
                    ],
                  ),
                ),
              ],
              ) , trailing: null,);
                },
              );
             } 
             return const Center(child: CircularProgressIndicator(),);
            }
          ),
        ),
      );
  }
}