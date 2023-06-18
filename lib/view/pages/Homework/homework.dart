// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable, prefer_const_constructors_in_immutables, depend_on_referenced_packages, prefer_const_constructors

import 'dart:developer';

import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:dujo_kerala_application/view/widgets/button_container_widget.dart';
import 'package:dujo_kerala_application/view/widgets/fonts/google_poppins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../model/teacher_model/home_works/homeworks.dart';
import '../../widgets/drop_down/subject_dropdown.dart';

class HomeWorkUpload extends StatefulWidget {
  String teacherID;
  String schoolID;
  String batchId;
  String classId;

  HomeWorkUpload(
      {required this.teacherID,
      required this.schoolID,
      required this.batchId,
      required this.classId,
      super.key});

  @override
  State<HomeWorkUpload> createState() => _HomeWorkUploadState();
}

class _HomeWorkUploadState extends State<HomeWorkUpload> {
  final TextEditingController _applyleaveDateController =
      TextEditingController();
  final TextEditingController _applyFromDateController =
      TextEditingController();
  final TextEditingController _applyTODateController = TextEditingController();

  final TextEditingController _taskapplyController = TextEditingController();

  DateTime? _selectedFromDate;
  DateTime? _selectedToDate;

  _selectFromDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedFromDate ?? DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedFromDate) {
      setState(() {
        _selectedFromDate = picked;
        DateTime parseDate = DateTime.parse(_selectedFromDate.toString());
        final DateFormat formatter = DateFormat('dd-MM-yyyy');
        String formatted = formatter.format(parseDate);

        _applyFromDateController.text = formatted.toString();
        log(formatted.toString());
      });
    }
  }

  _selectToDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedToDate ?? DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedToDate) {
      setState(() {
        _selectedToDate = picked;
        DateTime parseDate = DateTime.parse(_selectedToDate.toString());
        final DateFormat formatter = DateFormat('dd-MM-yyyy');
        String formatted = formatter.format(parseDate);

        _applyTODateController.text = formatted.toString();
        log(formatted.toString());
      });
    }
  }

  final String _selectedLeaveType = '';
  // late Animation animation, delayedAnimation, muchDelayedAnimation, LeftCurve;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  
        backgroundColor: adminePrimayColor,
        title: Text(
          "HomeWorks".tr,
          style: GoogleFonts.poppins(
            color: cWhite,
            fontSize: 20,
          ),
        ),
  
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
       
            SizedBox(
              height: 460.h,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Text(
                          "Homework Tasks".tr,
                          style: GoogleFonts.poppins(
                              color:cblack,
                              fontSize: 13,
                              fontWeight: FontWeight.bold
                              ),
                        ),
                    kHeight10,
                    Container(
                      height: 130,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextFormField(
                        controller: _taskapplyController,
                        minLines: 1,
                        maxLines: 10,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          hintText: 'Assign Here for Tasks'.tr,
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(7),
                        ),
                      ),
                    ),
                    kHeight20,
                    SizedBox(
                      height: 160.h,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                             Text(
                          "Choose your subject".tr,
                          style: GoogleFonts.poppins(
                              color:cblack,
                              fontSize: 13,
                                fontWeight: FontWeight.bold
                              ),
                        ),
                          SizedBox(
                            height: 10,
                          ),
                          GetSubjectListDropDownButton(
                              batchId: widget.batchId,
                              classId: widget.classId,
                              schoolID: widget.schoolID)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 13.w, right: 13.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    Text(
                          "Time period and deadline".tr,
                          style: GoogleFonts.poppins(
                              color:cblack,
                              fontSize: 13,
                                fontWeight: FontWeight.bold
                              ),
                        ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 80,
                    color: Colors.grey.withOpacity(0.1),
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          Icons.calendar_month,
                          color: Colors.black.withOpacity(0.3),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: _applyFromDateController,
                            readOnly: true,
                            onTap: () => _selectFromDate(context),
                            decoration:  InputDecoration(
                              labelText: 'From'.tr,
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.black.withOpacity(0.3),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: _applyTODateController,
                            readOnly: true,
                            onTap: () => _selectToDate(context),
                            decoration:  InputDecoration(
                              labelText: 'To'.tr,
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                       GooglePoppinsWidgets(text: "Time to complete should be > 1 day".tr, fontsize: 13,fontWeight: FontWeight.w400,)
                ],
              ),
            ),
            kHeight30,
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  kHeight20,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          HomeWorksModel data = HomeWorksModel(
                              tasks: _taskapplyController.text.trim(),
                              teacherid: widget.teacherID,
                              subjectid: subjectListValue!['docid'],
                              uploadDate: _selectedFromDate!.toString(),
                              endDate: _selectedToDate!.toString());
                          AddHomeWorsToFireBase()
                              .addHomeWorksController(
                                  data,
                                  context,
                                  widget.schoolID,
                                  widget.classId,
                                  widget.batchId)
                              .then((value) {
                            _taskapplyController.clear();
                            clearFeild();
                          });
                        },
                        child: ButtonContainerWidget(
                          curving: 18,
                          colorindex: 2,
                          height: 70.h,
                          width: 300.w,
                          child: Center(
                            child:Text(
                          "Submit".tr,
                          style: GoogleFonts.poppins(
                              color:cblack,
                              fontSize: 13,
                              fontWeight: FontWeight.w700
                              ),
                        ),
                          ),
                        ),
                      ),
                      kHeight30,
                    ],
                  )
                ],
              ),
            ),
       
          ],
        ),
      ),
    );
  }
   void clearFeild (){
    _taskapplyController.clear();
     _applyFromDateController.clear();
      _applyTODateController.clear();
     
         
  }
}
