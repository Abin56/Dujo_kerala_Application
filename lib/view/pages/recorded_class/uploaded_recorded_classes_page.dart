import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:dujo_kerala_application/view/pages/Subject/show_teacher_studymaterials.dart';
import 'package:dujo_kerala_application/view/widgets/fonts/google_monstre.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';

import '../../../utils/utils.dart';
import '../../../view/colors/colors.dart';
import '../../../view/widgets/button_container_widget.dart';
import '../../constant/sizes/constant.dart';

class StudyMaterialsUploadedPage extends StatefulWidget {
  StudyMaterialsUploadedPage(
      {super.key,
      required this.subjectID,
      required this.subjectName,
      required this.chapterID,
      required this.chapterName});

  String subjectID;
  String subjectName;
  String chapterName;
  String chapterID;
  bool stat = false;

  @override
  State<StudyMaterialsUploadedPage> createState() =>
      _StudyMaterialsUploadedPageState();
}

class _StudyMaterialsUploadedPageState
    extends State<StudyMaterialsUploadedPage> {
  TextEditingController subjectNameController = TextEditingController();
  TextEditingController topicController = TextEditingController();
  TextEditingController titleController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  File? filee;
  String downloadUrl = '';
  TaskSnapshot? taskProgress;
  double uploadPercentage = 0;

  uploadToFirebase(File file) async {
    try {
      setState(() {
        widget.stat = true;
      });
      String uid2 = const Uuid().v1();
      UploadTask uploadTask = FirebaseStorage.instance
          .ref()
          .child(
              "${UserCredentialsController.schoolId}/${UserCredentialsController.batchId}/${UserCredentialsController.classId}/files/recorded_clasees/${widget.subjectName}/${widget.chapterName}/${widget.chapterName}$uid2")
          .putFile(file);

      final TaskSnapshot snap = await uploadTask;
      setState(() {
        uploadPercentage = snap.bytesTransferred / snap.totalBytes;
      });

      downloadUrl = await snap.ref.getDownloadURL();
      String uid = const Uuid().v1();
      FirebaseFirestore.instance
          .collection('SchoolListCollection')
          .doc(UserCredentialsController.schoolId)
          .collection(UserCredentialsController.batchId!)
          .doc(UserCredentialsController.batchId)
          .collection('classes')
          .doc(UserCredentialsController.classId)
          .collection('subjects')
          .doc(widget.subjectID)
          .collection('recorded_classes_chapters')
          .doc(widget.chapterID)
          .collection('RecordedClass')
          .doc(uid)
          .set({
        'subjectName': widget.subjectName,
        'chapterName': widget.chapterName,
        'chapterID': widget.chapterID,
        'subjectID': widget.subjectID,
        'topicName': topicController.text,
        'title': titleController.text,
        'downloadUrl': downloadUrl,
        'fileId': "${widget.chapterName}$uid2",
        'docid': uid,
        'uploadedBy': UserCredentialsController.teacherModel?.teacherName
      }).then((value) => showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Recorded Classes'),
                  content: const Text('New file added!'),
                  actions: [
                    MaterialButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Ok'),
                    )
                  ],
                );
              }));

      setState(() {
        widget.stat = false;
      });
    } catch (e) {
      log(e.toString());
      setState(() {
        widget.stat = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: cblack,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        title: Text(
          "Study Material",
          style: GoogleFonts.montserrat(
            color: Colors.grey,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: cblack),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            kHeight10,
            SizedBox(
              height: 680.w,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  child: Column(
                    children: [
                      GoogleMonstserratWidgets(
                          text: 'Study Material upload',
                          fontsize: 13.h,
                          color: cgrey,
                          fontWeight: FontWeight.w700),
                      kWidth20,
                      GestureDetector(
                        onTap: () async {
                          try {
                            FilePickerResult? result = await FilePicker.platform
                                .pickFiles(allowedExtensions: [
                              'mkv',
                              'mp4',
                              'mov',
                              'avi'
                            ], type: FileType.custom, allowCompression: true);

                            if (result != null) {
                              File file = File(result.files.single.path!);
                              setState(() {
                                filee = file;
                              });
                            } else {
                              log('No file selected');
                            }
                          } catch (e) {
                            log(e.toString());
                          }
                        },
                        child: Container(
                          height: 130.h,
                          width: double.infinity - 20.w,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: cblue,
                              width: 2.0,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.attach_file_rounded,
                                  color: cblue, size: 30.w, weight: 10),
                              if (taskProgress == null)
                                GoogleMonstserratWidgets(
                                  text: (filee == null)
                                      ? 'Upload file here'
                                      : filee!.path.split('/').last,
                                  fontsize: 22,
                                  color: cblue,
                                  fontWeight: FontWeight.bold,
                                )
                              else if (taskProgress!.state == TaskState.running)
                                Center(
                                  child: CircularProgressIndicator(
                                      value: uploadPercentage),
                                )
                              else if (taskProgress!.state == TaskState.success)
                                const Text("Uploaded Complete")
                              else
                                const Text("Failed"),
                              kWidth20,
                            ],
                          ),
                        ),
                      ),
                      kWidth20,
                      kHeight20,
                      kHeight20,
                      TextFormField(
                        validator: checkFieldEmpty,
                        controller: topicController,
                        decoration:
                            const InputDecoration(hintText: 'Enter Topic'),
                      ),
                      kHeight20,
                      TextFormField(
                        validator: checkFieldEmpty,
                        controller: titleController,
                        decoration:
                            const InputDecoration(hintText: 'Enter Title'),
                      ),
                      kHeight40,
                      (widget.stat == true)
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : GestureDetector(
                              onTap: () async {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  if (filee != null) {
                                    uploadToFirebase(filee!);
                                  } else {
                                    showToast(msg: "Please Select File");
                                  }
                                }
                              },
                              child: ButtonContainerWidget(
                                curving: 18,
                                colorindex: 2,
                                height: 60.w,
                                width: 300.w,
                                child: Center(
                                  child: Text(
                                    "Submit",
                                    style: GoogleFonts.montserrat(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                            ),
                      kHeight20,
                      GestureDetector(
                        onTap: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => StudyMaterials(
                                        subjectID: widget.subjectID,
                                        chapterID: widget.chapterID,
                                      )));
                        },
                        child: ButtonContainerWidget(
                          curving: 18,
                          colorindex: 2,
                          height: 60.w,
                          width: 300.w,
                          child: Center(
                            child: Text(
                              "UPLOADED STUDY MATERIALS",
                              style: GoogleFonts.montserrat(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            kHeight30,
          ],
        ),
      ),
    );
  }
}
