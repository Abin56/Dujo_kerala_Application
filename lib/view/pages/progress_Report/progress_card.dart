// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/controllers/get_parent&guardian/getx.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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

  Widget build(BuildContext context) {
    log(widget.studentImage);
    return Scaffold(
      body: SafeArea(
          child: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                schoolName,
                style:
                    const TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20.h,
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
              Container(
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
                          Text("Class :  ${className}"),
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
                    List<TextEditingController> _obtainedcontrollers =
                        List.generate(
                      snapshot.data!.docs.length,
                      (index) => TextEditingController(),
                    );
                    List<TextEditingController> _totalMarkController =
                        List.generate(
                      snapshot.data!.docs.length,
                      (index) => TextEditingController(),
                    );
                    log('${snapshot.data!.docs.length}');
                    if (snapshot.hasData) {
                    if (snapshot.data!.docs.isNotEmpty) {
                        return Container(
                        color: Colors.amber,
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
                                          keyboardType: TextInputType.number,
                                          controller: _obtainedcontrollers[i],
                                        )),
                                        DataCell(TextFormField(
                                            keyboardType: TextInputType.number,
                                            controller:
                                                _totalMarkController[i])),
                                      ],
                                    ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            GestureDetector(
                              onTap: () async {
                                List<ExamReports> _examReports = [];
                                for (int j = 0;
                                    j < snapshot.data!.docs.length - 1;
                                    j++) {
                                  double _obtainedMarks = double.parse(
                                      _obtainedcontrollers[j].text.trim());
                                  double _totalMarks = double.parse(
                                      _totalMarkController[j].text.trim());

                                  _examReports.add(ExamReports(
                                      obtainedMark: _obtainedMarks,
                                      subject: snapshot.data?.docs[j]
                                          .data()['subjectName'],
                                      totalMark: _totalMarks));
                                }

                                UploadProgressReportModel _subjectReport =
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
                                  reports: _examReports,
                                );
                                AddProgressReportStatusToFireBase()
                                    .addAProgressReportController(
                                        _subjectReport,
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
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text('Message'),
                                                content: SingleChildScrollView(
                                                  child: ListBody(
                                                    children: <Widget>[
                                                      Text('Records Updated'),
                                                    ],
                                                  ),
                                                ),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: const Text('ok'),
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
                              child: ButtonContainerWidget(
                                  colorindex: 2,
                                  curving: 10,
                                  height: 40,
                                  width: 150,
                                  child: Center(
                                    child: Text(
                                      "Submit",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )),
                            )
                          ],
                        ),
                      );
                      
                    }else{
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
        .collection('classes')
        .doc(UserCredentialsController.classId)
        .get();
    setState(() {
      className = vari.data()!['className'];
    });
  }
}
