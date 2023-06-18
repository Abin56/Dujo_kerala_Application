import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/pages/progress_Report/progress_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AllStudentsListScreen extends StatelessWidget {
  String schooilID;
  String classID;
  String examName;
  String batchId;
  String teacherId;
  AllStudentsListScreen(
      {required this.schooilID,
      required this.classID,
      required this.examName,
      required this.batchId,
      required this.teacherId,
      super.key});

  @override
  Widget build(BuildContext context) {
    int columnCount = 3;
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title:  Text("All Student List".tr),backgroundColor: adminePrimayColor,
      //   actions: [
      //     GestureDetector(
      //         onTap: () {
      //           Get.to(ViewAllStudentsListScreen(
      //               schooilID: schooilID,
      //               classID: classID,
      //               examName: examName,
      //               batchId: batchId));
      //         },
      //         child: Padding(
      //           padding: const EdgeInsets.all(8.0),
      //           child: Center(
      //               child: GooglePoppinsWidgets(text: 'View', fontsize: 18,color: cblack,fontWeight: FontWeight.w400,)
      //           ),
      //         )
      //         )
      //  ],
      ),
      body: SafeArea(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("SchoolListCollection")
                  .doc(schooilID)
                  .collection(batchId)
                  .doc(batchId)
                  .collection("classes")
                  .doc(classID)
                  .collection("Students")
                  .orderBy('studentName', descending: false)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return AnimationLimiter(
                    child: GridView.count(
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      padding: EdgeInsets.all(w / 60),
                      crossAxisCount: columnCount,
                      children: List.generate(
                        snapshot.data!.docs.length,
                        (int index) {
                          return AnimationConfiguration.staggeredGrid(
                            position: index,
                            duration: const Duration(milliseconds: 200),
                            columnCount: columnCount,
                            child: ScaleAnimation(
                              duration: const Duration(milliseconds: 900),
                              curve: Curves.fastLinearToSlowEaseIn,
                              child: FadeInAnimation(
                                child: GestureDetector(
                                  onTap: () {
                                    Get.to(()=>StudentProgressReportScreen(
                                      batchId: batchId,
                                      teacherid: teacherId,
                                      studentId: snapshot.data!.docs[index]
                                          .data()['docid'],
                                      dob: snapshot.data!.docs[index]
                                          ['dateofBirth'],
                                      examName: examName,
                                      rollNo: ' ${index + 1}',
                                      studentImage: snapshot.data!.docs[index]
                                          .data()['profileImageUrl'],
                                      studentName: snapshot.data!.docs[index]
                                          .data()['studentName'],
                                      classID: classID,
                                      schooilID: schooilID,
                                    ));
                                  },
                                  child: Container(
                                    height: h / 100,
                                    width: double.infinity,
                                    margin: EdgeInsets.only(
                                        bottom: w / 10,
                                        left: w / 50,
                                        right: w / 50),
                                    decoration: BoxDecoration(
                                      color:
                                          const Color.fromARGB(212, 67, 30, 203)
                                              .withOpacity(0.1),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          blurRadius: 40,
                                          spreadRadius: 10,
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          const CircleAvatar(),
                                          Text(
                                            snapshot.data!.docs[index]
                                                .data()['studentName'],
                                            style: GoogleFonts.poppins(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }
              })),
    );
  }
}
