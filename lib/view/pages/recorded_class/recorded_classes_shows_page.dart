import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:dujo_kerala_application/view/widgets/fonts/google_poppins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../sruthi/Subject 2/subject_chapterwise_display.dart';

class RecordedClassesShowsPage extends StatelessWidget {
  const RecordedClassesShowsPage(
      {super.key, required this.subjectID, required this.chapterID});

  final String subjectID;
  final String chapterID;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white70,
        appBar: AppBar(
          title: Row(
            children: const [
              Text("Study Materials"),
            ],
          ),
          backgroundColor: adminePrimayColor,
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('SchoolListCollection')
              .doc(UserCredentialsController.schoolId)
              .collection(UserCredentialsController.batchId!)
              .doc(UserCredentialsController.batchId)
              .collection('classes')
              .doc(UserCredentialsController.classId)
              .collection('subjects')
              .doc(subjectID)
              .collection('recorded_classes_chapters')
              .doc(chapterID)
              .collection('RecordedClass')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.separated(
                  itemCount: snapshot.data!.docs.length,
                  separatorBuilder: ((context, index) {
                    return kHeight10;
                  }),
                  itemBuilder: (BuildContext context, int index) {
                    return ListileCardChapterWidget(
                      leading: const Image(
                          image: NetworkImage(
                              "https://media.istockphoto.com/id/926144358/photo/portrait-of-a-little-bird-tit-flying-wide-spread-wings-and-flushing-feathers-on-white-isolated.jpg?b=1&s=170667a&w=0&k=20&c=DEARMqqAI_YoA5kXtRTyYTYU9CKzDZMqSIiBjOmqDNY=")),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 5.h),
                            child: GooglePoppinsWidgets(
                              fontsize: 15.h,
                              text: snapshot.data!.docs[index]['chapterName'],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5.h),
                            child: GooglePoppinsWidgets(
                                fontsize: 15.h,
                                text: snapshot.data!.docs[index]['topicName'],
                                fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5.h),
                            child: GooglePoppinsWidgets(
                                fontsize: 14.h,
                                text: 'Video',
                                fontWeight: FontWeight.bold),
                          ),
                          kHeight10,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GooglePoppinsWidgets(
                                  text: "Posted By :", fontsize: 15.h),
                              GooglePoppinsWidgets(
                                text: snapshot.data!.docs[index]['uploadedBy'],
                                fontsize: 15.h,
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          ),
                        ],
                      ),
                      title: Padding(
                        padding: EdgeInsets.only(top: 10.h),
                        child: GooglePoppinsWidgets(
                          fontsize: 20.h,
                          text: snapshot.data!.docs[index]['title'],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: InkWell(
                        child: GooglePoppinsWidgets(
                            text: "View",
                            fontsize: 16.h,
                            fontWeight: FontWeight.w500,
                            color: adminePrimayColor),
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) =>

                          //             PDFSectionScreen(
                          //               urlPdf: snapshot.data!.docs[index]
                          //                   ['downloadUrl'],
                          //             )));
                        },
                      ),
                    );
                  });
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return const Center(
                child: Text('No Study Materials Uploaded Yet!'));
          },
        ),
      ),
    );
  }
}
