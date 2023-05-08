// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable, prefer_const_constructors_in_immutables, depend_on_referenced_packages, prefer_const_constructors

import 'dart:developer';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:dujo_kerala_application/view/widgets/button_container_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class HomeWorkUpload extends StatefulWidget {
  
  HomeWorkUpload(
      {
      
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

  final TextEditingController _leaveReasonController = TextEditingController();

  DateTime? _selectedDateForApplyDate;
  DateTime? _selectedFromDate;
  DateTime? _selectedToDate;

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDateForApplyDate ?? DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDateForApplyDate) {
      setState(() {
        _selectedDateForApplyDate = picked;
        DateTime parseDate =
            DateTime.parse(_selectedDateForApplyDate.toString());
        final DateFormat formatter = DateFormat('dd-MM-yyyy');
        String formatted = formatter.format(parseDate);

        _applyleaveDateController.text = formatted.toString();
        log(formatted.toString());
      });
    }
  }

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

  String _selectedLeaveType = '';
  // late Animation animation, delayedAnimation, muchDelayedAnimation, LeftCurve;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
              title: Row(
                children: [
                
                  Text("HomeWork Upload"),
                ],
              ),
              backgroundColor: adminePrimayColor,
            ),
      body: SingleChildScrollView(
        child: Column(
        //  mainAxisAlignment: MainAxisAlignment.start,
         // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           kHeight20,
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
                    "Homework Tasks",
                    style: GoogleFonts.montserrat(
                        color: Colors.grey,
                        fontSize: 13,
                        fontWeight: FontWeight.w700),
                  ),
                  kWidth20,
                  Container(
                    
                    height: 130,
                    width: double.infinity,
                    decoration: BoxDecoration(
                     
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextFormField(
                      controller: _leaveReasonController,
                      minLines: 1,
                      maxLines: 10,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                         hintText: 'Enter the questions ',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(7),
                      ),
                    ),
                  ),
                    kWidth20,
      
                    SizedBox( 
                      height: 160.h,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Choose your Subject",
                            style: GoogleFonts.montserrat(
                                color: Colors.grey,
                                fontSize: 13,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          DropdownSearch<String>(
                            selectedItem: 'Select',
                            validator: (v) =>
                                v == null ? "required field" : null,
                            items: const [
                              "English",
                              "Physics",
                              "Chemistry",
                              'Biology',
                              'Geography'
                            ],
                            onChanged: (value) {
                              setState(() {
                                _selectedLeaveType = value!;
                              });
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 13.w,right: 13.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Time period and deadline",
                    style: GoogleFonts.montserrat(
                        color: Colors.grey,
                        fontSize: 13,
                        fontWeight: FontWeight.w700),
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
                            decoration: const InputDecoration(
                              labelText: 'From',
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
                            decoration: const InputDecoration(
                              labelText: 'To',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
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
                          log(_selectedLeaveType);
                        },
                        child: ButtonContainerWidget(
                          curving: 18,
                          colorindex: 2,
                          height: 70.h,
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
                        
                      ),
                      kHeight30,
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
   );
  }
}