import 'dart:developer';
import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:dujo_kerala_application/view/widgets/fonts/google_monstre.dart';
import 'package:dujo_kerala_application/widgets/Iconbackbutton.dart';
import 'package:dujo_kerala_application/widgets/textformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../view/colors/colors.dart';
import '../../../view/widgets/button_container_widget.dart';
import 'package:file_picker/file_picker.dart';

class StudyMaterialUpload extends StatefulWidget {
  const StudyMaterialUpload({super.key});

  @override
  State<StudyMaterialUpload> createState() => _StudyMaterialUploadState();
}

class _StudyMaterialUploadState extends State<StudyMaterialUpload> {
  String _selectedLeaveType = '';
  FilePickerResult? result;
  String? _fileName;
  PlatformFile? pickedfile;
  bool isLoading = false;
  File? fileTodisplay;

  void pickfile() async {
    try {
      setState(() {
        isLoading = true;
      });
      result = await FilePicker.platform.pickFiles(
        type: FileType.any,
     
        allowMultiple: false,
      );

      if (result != null) {
        _fileName = result!.files.first.name;
        pickedfile = result!.files.first;
        fileTodisplay = File(pickedfile!.path.toString());

        print("File Name$_fileName");
      }

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text("Study Materials"),
          ],
        ),
        backgroundColor: adminePrimayColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            kHeight10,
            Container(
              height: 680.w,
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    GoogleMonstserratWidgets(
                        text: 'Study Material upload',
                        fontsize: 13.h,
                        color: cgrey,
                        fontWeight: FontWeight.w700),
                    kWidth20,
                    Container(
                      height: 130.h,
                      width: double.infinity - 20.w,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: cblue,
                          width: 2.0,
                        ),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          pickfile();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.attach_file_rounded,
                                color: cblue, size: 30.w, weight: 10),
                            GoogleMonstserratWidgets(
                              text: 'Upload file here',
                              fontsize: 22,
                              color: cblue,
                              fontWeight: FontWeight.bold,
                            ),
                            kWidth20,
                          ],
                        ),
                      ),
                    ),
                    kWidth20,
                    TextFormFieldWidget(
                      hintText: 'Subject Name',
                    ),
                    kHeight20,
                    Text(
                      "Choose the Chapter",
                      style: GoogleFonts.montserrat(
                          color: Colors.grey,
                          fontSize: 16.h,
                          fontWeight: FontWeight.w700),
                    ),
                    kHeight10,
                    Padding(
                      padding: EdgeInsets.only(left: 15.w, right: 15.w),
                      child: DropdownSearch<String>(
                        selectedItem: 'Select the Chapter',
                        validator: (v) => v == null ? "required field" : null,
                        items: const [
                          "Chapter 1",
                          "Chapter 2",
                          "Chapter 3",
                          'Chapter 4',
                          'Chapter 5'
                        ],
                        onChanged: (value) {
                          setState(() {
                            _selectedLeaveType = value!;
                          });
                        },
                      ),
                    ),
                    kHeight20,
                    TextFormFieldWidget(
                      hintText: 'Enter Topic',
                    ),
                    kHeight20,
                    TextFormFieldWidget(
                      hintText: 'Enter Title',
                    ),
                    kHeight40,
                    GestureDetector(
                      onTap: () {},
                      child: ButtonContainerWidget(
                        curving: 18,
                        colorindex: 2,
                        height: 60.w,
                        width: 300.w,
                        child: Center(
                          child: Text(
                            "SUBMIT",
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
            kHeight30,
          ],
        ),
      ),
    );
  }
}


