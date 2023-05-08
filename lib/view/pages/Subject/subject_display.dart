// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:dujo_kerala_application/view/widgets/fonts/google_poppins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../view/widgets/container_image.dart';
import '../../../widgets/Iconbackbutton.dart';

class StudentSubjectHome extends StatelessWidget {
  const StudentSubjectHome({super.key});

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
              text: "Subject",
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
                .collection("teachers")
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
                    children: List.generate(
                      snapshot.data!.docs.length,
                      (index) => Container(
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
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                      ),
                                      child: ContainerImage(
                                        height: 70.h,
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
                                        child: GooglePoppinsWidgets(
                                          text: snapshot.data!.docs[index]['teacherName'],
                                          fontsize: 12.h,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                kHeight20,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GooglePoppinsWidgets(
                                      text: "Chemistry",
                                      fontsize: 25.h,
                                      color: cWhite,
                                    ),
                                  ],
                                ),
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
