import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/pages/Subject/upload_studymaterial.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/get_utils.dart';

import '../../constant/sizes/sizes.dart';
import '../../widgets/fonts/google_poppins.dart';

class SubjectWiseDisplayTeacher extends StatelessWidget {
  SubjectWiseDisplayTeacher({Key? key, required this.subjectID})
      : super(key: key);

  String subjectID;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                if (snapshot.hasData) {
                  return ListView.separated(
                    itemCount: snapshot.data!.docs.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        kHeight10,
                    itemBuilder: (BuildContext context, int index) {
                      return ListileCardChapterWidget(
                        leading: const Icon(Icons.note_rounded),
                        title: GooglePoppinsWidgets(
                          text: snapshot.data!.docs[index]['chapterNumber'],
                          fontsize: 20.h,
                          fontWeight: FontWeight.bold,
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 10.h),
                              child: GooglePoppinsWidgets(
                                text: snapshot.data!.docs[index]['chapterName'],
                                fontsize: 15.h,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>

                                            //StudyMaterials()
                                            UploadStudyMaterial(
                                                subjectID: subjectID,
                                                chapterName: snapshot.data!
                                                    .docs[index]['chapterName'],
                                                subjectName: snapshot.data!
                                                    .docs[index]['subjectName'],
                                                chapterID: snapshot.data!
                                                    .docs[index]['docid'])));
                              },
                              child: Padding(
                                padding: EdgeInsets.only(top: 10.h),
                                child: GooglePoppinsWidgets(
                                  text: "Study Materials".tr,
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
                                    fontsize: 15.h,
                                  ),
                                  GooglePoppinsWidgets(
                                    text: UserCredentialsController
                                        .teacherModel!.teacherName
                                        .toString(),
                                    fontsize: 15.h,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        trailing: null,
                      );
                    },
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }),
        ),
      ),
    );
  }
}

class ListileCardChapterWidget extends StatelessWidget {
  ListileCardChapterWidget({
    required this.leading,
    required this.title,
    required this.subtitle,
    this.trailing,
    super.key,
  });

  Widget leading;
  Widget title;
  Widget subtitle;
  Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        shape: const BeveledRectangleBorder(side: BorderSide(color: cWhite)),
        leading: leading,
        title: title,
        subtitle: subtitle,
        trailing: trailing,
      ),
    );
  }
}
