import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constant/sizes/sizes.dart';
import '../../widgets/fonts/google_poppins.dart';
import 'uploaded_recorded_classes_page.dart';

class RecordedClassSubjectWisePage extends StatelessWidget {
  const RecordedClassSubjectWisePage({Key? key, required this.subjectID})
      : super(key: key);

  final String subjectID;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: adminePrimayColor,
          title: const Text("Chapters"),
        ),
        body: FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('SchoolListCollection')
                .doc(UserCredentialsController.schoolId)
                .collection(UserCredentialsController.batchId!)
                .doc(UserCredentialsController.batchId)
                .collection('classes')
                .doc(UserCredentialsController.classId)
                .collection('subjects')
                .doc(subjectID)
                .collection('recorded_classes_chapters')
                .get(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasData) {
                  if (snapshot.data!.docs.isEmpty) {
                    return const Center(
                      child: Text("Please Create Chapters"),
                    );
                  } else {
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
                                  text: snapshot.data!.docs[index]
                                      ['chapterName'],
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
                                              RecordedClassUploadPage(
                                                  subjectID: subjectID,
                                                  chapterName:
                                                      snapshot
                                                              .data!.docs[index]
                                                          ['chapterName'],
                                                  subjectName: snapshot.data!
                                                          .docs[index]
                                                      ['subjectName'],
                                                  chapterID: snapshot.data!
                                                      .docs[index]['docid'])));
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(top: 10.h),
                                  child: GooglePoppinsWidgets(
                                    text: "Recorded Classes",
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
                        );
                      },
                    );
                  }
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text("Error occurred while fetching data"),
                  );
                } else {
                  return const Center(
                    child: Text("No data available"),
                  );
                }
              } else {
                return const Center(
                  child: Text("Please Create Chapters"),
                );
              }
            }),
      ),
    );
  }
}

class ListileCardChapterWidget extends StatelessWidget {
  const ListileCardChapterWidget({
    required this.leading,
    required this.title,
    required this.subtitle,
    this.trailing,
    super.key,
  });

  final Widget leading;
  final Widget title;
  final Widget subtitle;
  final Widget? trailing;

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
