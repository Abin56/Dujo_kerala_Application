import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/widgets/container_image.dart';
import 'package:dujo_kerala_application/view/widgets/fonts/google_poppins.dart';
import 'package:dujo_kerala_application/widgets/Iconbackbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../sruthi/Subject 2/subject_display.dart';
import '../../../constant/sizes/sizes.dart';
import '../../../pages/Subject/subject_chapterwise_display.dart';

class TeacherSubjectsList extends StatelessWidget {
  const TeacherSubjectsList({super.key});

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
          stream: FirebaseFirestore.instance.collection('SchoolListCollection').doc(UserCredentialsController.schoolId).collection(UserCredentialsController.batchId!).doc(UserCredentialsController.batchId).collection('classes').doc(UserCredentialsController.classId).collection('teachers').doc(UserCredentialsController.teacherModel!.docid).collection('teacherSubject').snapshots(),
          builder: (context, snapshot) { 
            if(snapshot.hasData){
              return GridView.count(
              padding: const EdgeInsets.all(15),
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              children: List.generate(
                snapshot.data!.docs.length,
                (index) => GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SubjectWiseDisplay()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: adminePrimayColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    height: 40,
        
                    // ignore: sort_child_properties_last
                    child: Padding(
                      padding: EdgeInsets.only(left: 20.h, top: 20.h, right: 20.h),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  child: ContainerImage(
                                    height: 70.h,
                                    imagePath: 'assets/images/teachernew.png',
                                    width: 70.w,
                                  ),
                                ),
                                SizedBox(width: 10.h),
                                Expanded(
                                  child: SizedBox(
                                    height:
                                        50, // set a fixed height for the container
                                    child: GooglePoppinsWidgets(
                                      text: text[index],
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
                                  text: snapshot.data!.docs[index]['subjectName'],
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
            );
            } return const Center(child: CircularProgressIndicator(),);
          }
        ),
      ),
    );
  }
}