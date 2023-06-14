import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/sruthi/widget/exm_upload_textformfeild.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:dujo_kerala_application/view/widgets/button_container_widget.dart';
import 'package:dujo_kerala_application/widgets/Iconbackbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';

import '../../../controllers/userCredentials/user_credentials.dart';
import '../../constant/sizes/constant.dart';
import 'recorded_class_subject_wise.dart';

class RecordedClassChapterUploadPage extends StatelessWidget {
  RecordedClassChapterUploadPage({super.key, required this.subjectID});

  TextEditingController chapterNumberController = TextEditingController();
  TextEditingController chapterNameController = TextEditingController();
  TextEditingController subjectNameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String subjectID;

  Uuid idgen = const Uuid();

  Future<void> createChapter(id) async {
    FirebaseFirestore.instance
        .collection('SchoolListCollection')
        .doc(UserCredentialsController.schoolId)
        .collection(UserCredentialsController.batchId!)
        .doc(UserCredentialsController.batchId)
        .collection('classes')
        .doc(UserCredentialsController.classId)
        .collection('subjects')
        .doc(subjectID)
        .collection('recorded_classes_chapters')
        .doc(id)
        .set({
      'chapterNumber': chapterNumberController.text,
      'chapterName': chapterNameController.text,
      'subjectName': subjectNameController.text,
      'docid': id,
      'uploadedBy':
          UserCredentialsController.teacherModel!.teacherName.toString()
    }).then((value) {
      chapterNameController.clear();
      chapterNumberController.clear();
      subjectNameController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButtonBackWidget(
              color: cWhite,
            ),
            const Text("Chapter Upload"),
          ],
        ),
        backgroundColor: adminePrimayColor,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              kHeight20,
              ExamUploadTextFormFeild(
                  validator: checkFieldEmpty,
                  textfromController: chapterNumberController,
                  text: "Chapter No.",
                  hintText: "Chapter Number"),
              kHeight20,
              ExamUploadTextFormFeild(
                  validator: checkFieldEmpty,
                  textfromController: chapterNameController,
                  text: "Chapter Name",
                  hintText: "Chapter Name"),
              kHeight20,
              ExamUploadTextFormFeild(
                  validator: checkFieldEmpty,
                  textfromController: subjectNameController,
                  text: "Subject Name",
                  hintText: "Subject Name"),
              kHeight20,
              GestureDetector(
                onTap: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    String generatedDocID =
                        subjectNameController.text.trim() + idgen.v1();
                    createChapter(generatedDocID).then((value) {
                      return showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Chapter Upload'),
                              content: const Text('New Chapter Added!'),
                              actions: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: MaterialButton(
                                    child: const Text('OK'),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                )
                              ],
                            );
                          });
                    });
                  }
                },
                child: ButtonContainerWidget(
                  curving: 18,
                  colorindex: 2,
                  height: 70.h,
                  width: 300.w,
                  child: Center(
                    child: Text(
                      "Create Chapter",
                      style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            RecordedClassSubjectWisePage(subjectID: subjectID),
                      ));
                },
                child: ButtonContainerWidget(
                  curving: 18,
                  colorindex: 2,
                  height: 70.h,
                  width: 300.w,
                  child: Center(
                    child: Text(
                      "Upload Recorded Classes",
                      style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
