// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../model/teacher_model/progress_report_model/progress_report_model.dart';

class ViewProgressReportScreen extends StatefulWidget {
  String schooilID;
  String classID;
  String studentId;
  String wexam;
  String batchId;
  ViewProgressReportScreen(
      {required this.schooilID,
      required this.classID,
      required this.studentId,
      required this.wexam,
      required this.batchId,
      super.key});

  @override
  State<ViewProgressReportScreen> createState() =>
      ViewtProgressReportScreenState();
}

class ViewtProgressReportScreenState extends State<ViewProgressReportScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection("SchoolListCollection")
            .doc(widget.schooilID)
            .collection(widget.batchId)
            .doc(widget.batchId)
            .collection("classes")
            .doc(widget.classID)
            .collection("Students")
            .doc(widget.studentId)
            .collection("StudentProgressReport")
            .doc(widget.wexam)
            .get(),
        builder: (context, snapshot) {
    
          if (snapshot.hasData) {
            if (snapshot.data!.data()!=null) {
              UploadProgressReportModel data =
                  UploadProgressReportModel.fromMap(snapshot.data!.data()!);
              return Scaffold(
                body: SafeArea(
                    child: SizedBox(
                  height: double.maxFinite,
                  width: double.maxFinite,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          data.schoolName,
                          style: const TextStyle(
                              fontSize: 23, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Text(
                          data.schoolPlace,
                          style: const TextStyle(
                              letterSpacing: 5,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        Text(
                          data.whichExam,
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w800),
                        ),
                        SizedBox(
                          height: 05.h,
                        ),
                        Text(
                          "Progress Report",
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 23,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              data.studentName,
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            CircleAvatar(
                              backgroundImage: NetworkImage(data.studentIMage),
                              radius: 60,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 110,
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  children: [
                                    const Text("Roll No :  "),
                                    Text(data.rollNo),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("Class :   ${data.wClass}"),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                        "Class Adviser :   ${data.teacherName}"),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 600,
                          child: Column(
                            children: [
                              SingleChildScrollView(
                                child: DataTable(
                                  columns: const [
                                    DataColumn(
                                      label: Text('No'),
                                    ),
                                    DataColumn(
                                      label: Text("Subjects"),
                                    ),
                                    DataColumn(
                                      label: Text('Obtained'),
                                    ),
                                    DataColumn(
                                      label: Text('Total'),
                                    ),
                                  ],
                                  rows: [
                                    for (int i = 0;
                                        i <= data.reports.length - 1;
                                        i++)
                                      DataRow(
                                        cells: [
                                          DataCell(
                                            Text('${i + 1}'),
                                          ),
                                          DataCell(
                                            Text(data.reports[i].subject),
                                          ),
                                          DataCell(
                                            Text(
                                              data.reports[i].obtainedMark
                                                  .toString(),
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              data.reports[i].totalMark
                                                  .toString(),
                                            ),
                                          ),
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )),
              );
            } else {
              return const Scaffold(
                body:  Center(
                  child: Text("No Records"),
                ),
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
        });
  }
}
