// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/widgets/fonts/google_poppins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../model/teacher_model/progress_report_model/progress_report_model.dart';
import '../../widgets/button_container_widget.dart';

class StudentProgressReportScreen extends StatefulWidget {
  String schooilID;
  String classID;
  String studentImage;
  String studentName;
  String rollNo;
  String dob;
  String examName;
  String studentId;
  String teacherid;
  String batchId;

  StudentProgressReportScreen(
      {required this.schooilID,
      required this.classID,
      required this.studentImage,
      required this.studentName,
      required this.rollNo,
      required this.dob,
      required this.examName,
      required this.studentId,
      required this.teacherid,
      required this.batchId,
      super.key});

  @override
  State<StudentProgressReportScreen> createState() =>
      _StudentProgressReportScreenState();
}

class _StudentProgressReportScreenState
    extends State<StudentProgressReportScreen> {
  String schoolName = '';
  String schoolPlace = "";
  String className = '';
  @override
  void initState() {
    getSchoolDetails();
    getClassDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log(widget.studentImage);
    return Scaffold(
      appBar: AppBar(
          backgroundColor: adminePrimayColor,
          title: GooglePoppinsWidgets(
            fontsize: 18,
            text: "Progress Report",
          )),
      backgroundColor: Colors.blue[100],
      body: SafeArea(
          child: SizedBox(
        height: double.maxFinite,
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 10.h),
            child: Column(
              children: [
                Text(
                  schoolName,
                  style: const TextStyle(
                      fontSize: 23, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Text(
                  schoolPlace,
                  style: const TextStyle(
                      letterSpacing: 5,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Text(
                  widget.examName,
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
                      widget.studentName,
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    CircleAvatar(
                      backgroundImage: NetworkImage(widget.studentImage),
                      radius: 60,
                    ),
                  ],
                ),
                SizedBox(
                  height: 60,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            const Text("Roll No :  "),
                            Text(widget.rollNo),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Class :  $className"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("SchoolListCollection")
                        .doc(widget.schooilID)
                        .collection(widget.batchId)
                        .doc(widget.batchId)
                        .collection("classes")
                        .doc(widget.classID)
                        .collection("subjects")
                        .snapshots(),
                    builder: (context, snapshot) {
                      // log('${snapshot.data!.docs.length}');
                      if (snapshot.hasData) {
                        if (snapshot.data!.docs.isNotEmpty) {
                          List<TextEditingController> obtainedcontrollers =
                              List.generate(
                            snapshot.data!.docs.length,
                            (index) => TextEditingController(),
                          );
                          List<TextEditingController> totalMarkController =
                              List.generate(
                            snapshot.data!.docs.length,
                            (index) => TextEditingController(),
                          );
                          return Container(
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: cWhite,
                            ),
                            child: Column(
                              children: [
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
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
                                          i <= snapshot.data!.docs.length - 1;
                                          i++)
                                        DataRow(
                                          cells: [
                                            DataCell(
                                              Text('${i + 1}'),
                                            ),
                                            DataCell(
                                              Text(
                                                '${snapshot.data?.docs[i].data()['subjectName']}',
                                              ),
                                            ),
                                            DataCell(TextFormField(
                                              keyboardType:
                                                  TextInputType.number,
                                              controller:
                                                  obtainedcontrollers[i],
                                            )),
                                            DataCell(
                                              TextFormField(
                                                  keyboardType:
                                                      TextInputType.number,
                                                  controller:
                                                      totalMarkController[i]),
                                            ),
                                          ],
                                        ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    List<ExamReports> examReports = [];
                                    for (int j = 0;
                                        j <= snapshot.data!.docs.length - 1;
                                        j++) {
                                      double obtainedMarks = double.parse(
                                          obtainedcontrollers[j].text.trim());
                                      double totalMarks = double.parse(
                                          totalMarkController[j].text.trim());

                                      examReports.add(ExamReports(
                                          obtainedMark: obtainedMarks,
                                          subject: snapshot.data?.docs[j]
                                              .data()['subjectName'],
                                          totalMark: totalMarks));
                                    }
                                    log(examReports.toString());

                                    UploadProgressReportModel subjectReport =
                                        UploadProgressReportModel(
                                      studentIMage: widget.studentImage,
                                      schoolName: schoolName,
                                      schoolPlace: schoolPlace,
                                      teacherName: widget.teacherid,
                                      id: widget.examName,
                                      whichExam: widget.examName,
                                      publishDate: DateTime.now().toString(),
                                      studentName: widget.studentName,
                                      rollNo: widget.rollNo,
                                      wClass: widget.classID,
                                      reports: examReports,
                                    );
                                    AddProgressReportStatusToFireBase()
                                        .addAProgressReportController(
                                            subjectReport,
                                            context,
                                            widget.schooilID,
                                            widget.classID,
                                            widget.studentId,
                                            widget.examName,
                                            widget.batchId)
                                        .then((value) => {
                                              showDialog(
                                                context: context,
                                                barrierDismissible:
                                                    false, // user must tap button!
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title:
                                                        const Text('Message'),
                                                    content:
                                                        SingleChildScrollView(
                                                      child: ListBody(
                                                        children: const <
                                                            Widget>[
                                                          Text(
                                                              'Records Updated'),
                                                        ],
                                                      ),
                                                    ),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        child: const Text('Ok'),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      ),
                                                    ],
                                                  );
                                                },
                                              ),
                                            });
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(bottom: 10.h),
                                    child: ButtonContainerWidget(
                                        colorindex: 2,
                                        curving: 10,
                                        height: 40,
                                        width: 150,
                                        child: const Center(
                                          child: Text(
                                            "Submit",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )),
                                  ),
                                )
                              ],
                            ),
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    })
              ],
            ),
          ),
        ),
      )),
    );
  }

  void getSchoolDetails() async {
    var vari = await FirebaseFirestore.instance
        .collection("SchoolListCollection")
        .doc(widget.schooilID)
        .get();
    setState(() {
      schoolName = vari.data()!['schoolName'];
      schoolPlace = vari.data()!['place'];
    });
  }

  void getClassDetails() async {
    var vari = await FirebaseFirestore.instance
        .collection("SchoolListCollection")
        .doc(widget.schooilID)
        .collection(UserCredentialsController.batchId!)
        .doc(UserCredentialsController.batchId!)
        .collection('classes')
        .doc(UserCredentialsController.classId)
        .get();
    setState(() {
      className = vari.data()?['className'];
    });
  }
}
