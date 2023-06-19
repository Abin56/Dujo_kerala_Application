// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/controllers/get_teacher_subject/get_sub.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:dujo_kerala_application/sruthi/subject_chapter_upload.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:dujo_kerala_application/view/widgets/fonts/google_poppins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../view/widgets/container_image.dart';
import '../../../widgets/Iconbackbutton.dart';

class TeacherSubjectHome extends StatelessWidget {
  TeacherSubjectController teacherSubjectController =
      Get.put(TeacherSubjectController());
  TeacherSubjectHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: adminePrimayColor,
        title: Row(
          children: [
            IconButtonBackWidget(
              color: cWhite,
            ),
            GooglePoppinsWidgets(
              text: "Subjects".tr,
              fontsize: 20.h,
              color: cWhite,
            )
          ],
        ),
      ),
      body: SafeArea(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("SchoolListCollection")
                .doc(UserCredentialsController.schoolId)
                .collection(UserCredentialsController.batchId!)
                .doc(UserCredentialsController.batchId)
                .collection("classes")
                .doc(UserCredentialsController.classId)
                .collection('teachers')
                .doc(UserCredentialsController.teacherModel!.docid)
                .collection('teacherSubject')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Column(children: [
                Expanded(
                  child: GridView.count(
                    padding: const EdgeInsets.all(15),
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    children: 
                        List.generate(snapshot.data!.docs.length, (index) {
                      teacherSubjectController
                          .getSubject(snapshot.data!.docs[index]['teacherdocid']);
                      return GestureDetector( 
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> 
                          
                          //StudyMaterials()
                          ChapterUpoload(subjectID: snapshot.data!.docs[index]['docid'],)
                          ));

                         // ChapterDisplay(subjectID: snapshot.data!.docs[index]['docid'],)));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 90, 147, 194),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          height: 50,
                      
                          // ignore: sort_child_properties_last
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 20.h, top: 20.h, right: 20.h),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                        ),
                                        child: ContainerImage(
                                          height: 60.h,
                                          imagePath:
                                              'assets/images/teachernew.png',
                                          width: 70.w,
                                        ),
                                      ),
                                      SizedBox(width: 10.h),
                                      Expanded(
                                        child: SizedBox(
                                          height:
                                              50, // set a fixed height for the container
                                          child: Center(
                                              child: FutureBuilder(
                                                  future: teacherSubjectController
                                                      .getSubject(
                                                          snapshot.data?.docs[index]
                                                              ['teacherdocid']),
                                                  builder: (context, snap) {
                                                    return SizedBox(
                                                      height: 40,
                                                      width: 70,
                                                      child: GooglePoppinsWidgets(
                                                          text: snap.data ?? "",
                                                          fontsize: 12),
                                                    );
                                                  })),
                                        ),
                                      )
                                    ],
                                  ),
                                  kHeight20,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GooglePoppinsWidgets(
                                        text: snapshot.data!.docs[index]
                                            ['subjectName'],
                                        fontsize: 20.h,
                                        color: cWhite,
                                      ),
                                    ],
                                  ),
                                ]),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ]);
            }),
      ),
    );
  }
}

const text = [""];
