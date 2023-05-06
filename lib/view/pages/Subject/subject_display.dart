// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:dujo_kerala_application/view/pages/Subject/subject_chapterwise_display.dart';
import 'package:dujo_kerala_application/ui%20team/abin/Subject%20dialog%20and%20chat/popup_container.dart';

import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:dujo_kerala_application/view/widgets/fonts/google_poppins.dart';
import 'package:dujo_kerala_application/widgets/Iconbackbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../view/widgets/container_image.dart';

class StudentSubjectHome extends StatelessWidget {
 
  StudentSubjectHome(
      {
      super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: cWhite,
          title: GooglePoppinsWidgets(
            text: "Subject",
            fontsize: 20.h,
            color: cblack,
          )),
      body: SafeArea(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("SchoolListCollection")
                .doc(UserCredentialsController.schoolId)
                .collection(UserCredentialsController.batchId!)
                .doc(UserCredentialsController.batchId)
                .collection("classes")
                .doc(UserCredentialsController.classId)
                .collection("subjects")
                .snapshots(),
            builder: (context, snapshot) { 
              if(snapshot.connectionState == ConnectionState.waiting)
{
  return Center(child: CircularProgressIndicator(),);
}              return Column(children: [
                Expanded(
                  child: GridView.count(
                    padding: const EdgeInsets.all(15),
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    children: List.generate(
                      snapshot.data!.docs.length,
                      (index) => Container(
                        decoration: BoxDecoration(
                          color: cWhite,
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
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                    bottomRight:
                                                        Radius.circular(40),
                                                    topLeft:
                                                        Radius.circular(40)),
                                              ),
                                              backgroundColor: cWhite,
                                              elevation: 0,
                                              contentPadding: EdgeInsets.zero,
                                              content: PopUpContainer(),
                                            );
                                          },
                                        );
                                      },
                                      child: Container(
                                        width: 75.w,
                                        height: 75.h,
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                                blurRadius: 3.0, color: cWhite),
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: Colors.white.withOpacity(0.5),
                                          border:
                                              Border.all(color: Colors.white),
                                        ),
                                        child: ContainerImage(
                                          height: 60.h,
                                          imagePath:
                                              'assets/images/teachernew.png',
                                          width: 60.w,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10.h),
                                    Expanded(
                                        child: FittedBox(
                                            child: GooglePoppinsWidgets(
                                      text: "${snapshot.data!.docs[index]['teacherName']}",
                                      fontsize: 12.h,
                                      color: Colors.grey,
                                    )))
                                  ],
                                ),
                                kHeight20,
                                InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SubjectWiseDisplay()));
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        GooglePoppinsWidgets(
                                          text: snapshot.data!.docs[index]
                                              ['subjectName'],
                                          fontsize: 20.h,
                                          fontWeight: FontWeight.w500,
                                          color: cblack,
                                        ),
                                      ],
                                    )),
                              ]),
                        ),
                      ),
                    ),
                  ),
                ),
              ]);
            }),
      ),
    );
  }
}

const text = [""];
