import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/get_utils.dart';

import '../../../utils/utils.dart';
import '../../../widgets/drop_down/all_class_students.dart';
import '../../../widgets/drop_down/select_school_level_exam.dart';
import '../../../widgets/drop_down/select_subject_teachers.dart';
import '../../../widgets/textformfield.dart';
import '../../constant/sizes/constant.dart';
import '../../widgets/fonts/google_poppins.dart';

class ExamResultsView extends StatefulWidget {
  bool isLoading = false;

  String classID;
  String examlevel;

  ExamResultsView({super.key, required this.classID, required this.examlevel});

  @override
  State<ExamResultsView> createState() => _ExamResultsViewState();
}

class _ExamResultsViewState extends State<ExamResultsView> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController obtainedMark = TextEditingController();

  TextEditingController obtainedGrade = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 239, 239, 239),
      appBar: AppBar(
          title: GooglePoppinsWidgets(
              text: 'Upload Exam Results'.tr,
              fontsize: 16.w,
              fontWeight: FontWeight.w500),
          backgroundColor: adminePrimayColor),
      body: widget.isLoading
          ? circularProgressIndicatotWidget
          : Center(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      // height: 60.h,
                      width: 320.w,

                      child: Center(
                        child: GetSchoolLevelExamDropDownButton(
                          examType: widget.examlevel,
                        ),
                      ),
                    ),
                    SizedBox(
                      // height: 75.h,
                      width: 320.w,

                      child: Center(
                        child: GetTeachersSubjectsDropDownButton(
                          classId: widget.classID,
                        ),
                      ),
                    ),
                    SizedBox(
                      // height: 60.h,
                      width: 320.w,

                      child: Center(
                          child: AllClassStudentsListDropDownButton(
                        classID: widget.classID,
                      )),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 30.w,
                        right: 30.w,
                      ),
                      child: TextFormFieldWidget(
                        textEditingController: obtainedMark,
                        labelText: "Obtained Mark".tr,
                        function: checkFieldEmpty,
                        //textEditingController: ,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 30.w,
                        right: 30.w,
                      ),
                      child: TextFormFieldWidget(
                        textEditingController: obtainedGrade,
                        // hintText: "Obtained Grade",
                        labelText: 'Obtained Grade'.tr,
                        //textEditingController: ,
                      ),
                    ),
                    GestureDetector(
                        onTap: () async {
                          final docid = uuid.v1();
                          if (_formKey.currentState!.validate()) {
                            if (schoolLevelExamistValue != null &&
                                allClassStudentsListValue != null) {
                              setState(() {
                                widget.isLoading = true;
                              });
                              await FirebaseFirestore.instance
                                  .collection('SchoolListCollection')
                                  .doc(UserCredentialsController.schoolId)
                                  .collection(
                                      UserCredentialsController.batchId!)
                                  .doc(UserCredentialsController.batchId!)
                                  .collection('classes')
                                  .doc(widget.classID)
                                  .collection('Students')
                                  .doc(allClassStudentsListValue!['docid'])
                                  .collection(widget.examlevel)
                                  .doc(schoolLevelExamistValue!['examName'])
                                  .set({
                                'docid': schoolLevelExamistValue!['examName']
                              }).then((value) async {
                                await FirebaseFirestore.instance
                                    .collection('SchoolListCollection')
                                    .doc(UserCredentialsController.schoolId)
                                    .collection(
                                        UserCredentialsController.batchId!)
                                    .doc(UserCredentialsController.batchId!)
                                    .collection('classes')
                                    .doc(widget.classID)
                                    .collection('Students')
                                    .doc(allClassStudentsListValue!['docid'])
                                    .collection(widget.examlevel)
                                    .doc(schoolLevelExamistValue!['examName'])
                                    .collection('Marks')
                                    .doc(teacherSubjectValue!['docid'])
                                    .set({
                                  'docid': docid,
                                  'uploadDate': DateTime.now().toString(),
                                  'studentName':
                                      allClassStudentsListValue!['studentName'],
                                  'obtainedMark': obtainedMark.text.trim(),
                                  'obtainedGrade': obtainedGrade.text.trim(),
                                  'subjectName':
                                      teacherSubjectValue!['subjectName'],
                                  'studentid':
                                      allClassStudentsListValue!['docid'],
                                }, SetOptions(merge: true)).then((value) async {
                                  await FirebaseFirestore.instance
                                      .collection('SchoolListCollection')
                                      .doc(UserCredentialsController.schoolId)
                                      .collection(
                                          UserCredentialsController.batchId!)
                                      .doc(UserCredentialsController.batchId!)
                                      .collection('classes')
                                      .doc(widget.classID)
                                      .collection('Exam Results')
                                      .doc(schoolLevelExamistValue!['examName'])
                                      .set({
                                    'docid':
                                        schoolLevelExamistValue!['examName']
                                  }).then((value) async {
                                    await FirebaseFirestore.instance
                                        .collection('SchoolListCollection')
                                        .doc(UserCredentialsController.schoolId)
                                        .collection(
                                            UserCredentialsController.batchId!)
                                        .doc(UserCredentialsController.batchId!)
                                        .collection('classes')
                                        .doc(widget.classID)
                                        .collection('Exam Results')
                                        .doc(schoolLevelExamistValue![
                                            'examName'])
                                        .collection('Subjects')
                                        .doc(teacherSubjectValue!['docid'])
                                        .set({
                                      'subject':
                                          teacherSubjectValue!['subjectName'],
                                      'subjectid':
                                          teacherSubjectValue!['docid'],
                                    }).then((value) async {
                                      await FirebaseFirestore.instance
                                          .collection('SchoolListCollection')
                                          .doc(UserCredentialsController
                                              .schoolId)
                                          .collection(UserCredentialsController
                                              .batchId!)
                                          .doc(UserCredentialsController
                                              .batchId!)
                                          .collection('classes')
                                          .doc(widget.classID)
                                          .collection('Exam Results')
                                          .doc(schoolLevelExamistValue![
                                              'examName'])
                                          .collection('Subjects')
                                          .doc(teacherSubjectValue!['docid'])
                                          .collection('MarkList')
                                          .doc(allClassStudentsListValue![
                                              'docid'])
                                          .set({
                                        'subjectid':
                                            teacherSubjectValue!['docid'],
                                        'teacherId': teacherSubjectValue![
                                            'teacherdocid'],
                                        'teachername':
                                            teacherSubjectValue!['teacherName'],
                                        'examid': docid,
                                        'uploadDate': DateTime.now().toString(),
                                        'studentName':
                                            allClassStudentsListValue![
                                                'studentName'],
                                        'obtainedMark':
                                            obtainedMark.text.trim(),
                                        'obtainedGrade':
                                            obtainedGrade.text.trim(),
                                        'subjectName':
                                            teacherSubjectValue!['subjectName'],
                                        'studentid':
                                            allClassStudentsListValue!['docid'],
                                      }).then((value) {
                                        setState(() {
                                          widget.isLoading = false;
                                        });
                                        obtainedMark.clear();
                                        obtainedGrade.clear();
                                        showToast(msg: "Uploaded Successfully");
                                      });
                                    });
                                  });
                                });
                              });
                            } else {
                              return showToast(
                                  msg: 'Please check selected Items');
                            }
                          }
                        },
                        child: SubmitButtonWidget(
                          text: 'Submit'.tr,
                        ))
                  ],
                ),
              ),
            ),
    );
  }
}

class SubmitButtonWidget extends StatelessWidget {
  SubmitButtonWidget({
    required this.text,
    super.key,
  });
  String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.h,
      width: 190.w,
      decoration: BoxDecoration(
          color: cblue, borderRadius: BorderRadius.all(Radius.circular(8.w))),
      child: Center(
        child: GooglePoppinsWidgets(
            text: text,
            fontsize: 15.w,
            color: cWhite,
            fontWeight: FontWeight.w600),
      ),
    );
  }
}
