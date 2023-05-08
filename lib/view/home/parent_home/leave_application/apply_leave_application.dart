// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable

import 'dart:developer';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:dujo_kerala_application/controllers/get_student_detail/get_student_details.dart';
import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../model/leave_letter_model/leave_letter.dart';
import '../../../widgets/button_container_widget.dart';

class LeaveApplicationScreen extends StatefulWidget {
  var studentName;
  var guardianName;
  var classID;
  var schoolId;
  var studentID;
  var batchId;
  LeaveApplicationScreen(
      {required this.studentName,
      required this.guardianName,
      required this.classID,
      required this.schoolId,
      required this.studentID,
      required this.batchId,
      super.key});

  @override
  State<LeaveApplicationScreen> createState() => _LeaveApplicationScreenState();
}

class _LeaveApplicationScreenState extends State<LeaveApplicationScreen> {
  StudentController studentController = Get.put(StudentController());
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
    return Obx(() {
      studentController.getTeacherClassRoll(widget.studentName);
      if (studentController.studentName.value.isEmpty) {
        return const Scaffold(
            body: Center(
          child: CircularProgressIndicator(),
        ));
      } else {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              "Apply Leave",
              style: GoogleFonts.montserrat(
                  color: Colors.grey,
                  fontSize: 20,
                  fontWeight: FontWeight.w700),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 220,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Apply Leave Date",
                          style: GoogleFonts.montserrat(
                              color: Colors.grey,
                              fontSize: 13,
                              fontWeight: FontWeight.w700),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 13,
                          ),
                          child: Stack(
                            alignment: AlignmentDirectional.centerEnd,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.calendar_today,
                                  color: Colors.black.withOpacity(0.3),
                                ),
                              ),
                              TextFormField(
                                controller: _applyleaveDateController,
                                readOnly: true,
                                onTap: () => _selectDate(context),
                                decoration: const InputDecoration(
                                  labelText: 'DD-MM-YYYY',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 90,
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Choose Leave Type",
                                style: GoogleFonts.montserrat(
                                    color: Colors.grey,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700),
                              ),
                              kHeight10,
                              DropdownSearch<String>(
                                selectedItem: 'Select',
                                validator: (v) =>
                                    v == null ? "required field" : null,
                                items: const [
                                  "Medical",
                                  "Family",
                                  "Sick",
                                  'Function',
                                  'Others'
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
                  padding: const EdgeInsets.only(left: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Apply Leave Date",
                        style: GoogleFonts.montserrat(
                            color: Colors.grey,
                            fontSize: 13,
                            fontWeight: FontWeight.w700),
                      ),
                      kHeight10,
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
                            const SizedBox(width: 8),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.black.withOpacity(0.3),
                            ),
                            const SizedBox(
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
                kHeight10,
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Reason",
                        style: GoogleFonts.montserrat(
                            color: Colors.grey,
                            fontSize: 13,
                            fontWeight: FontWeight.w700),
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
                          controller: _leaveReasonController,
                          minLines: 1,
                          maxLines: 10,
                          keyboardType: TextInputType.multiline,
                          decoration: const InputDecoration(
                            hintText: 'Respected ',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(7),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              log(_selectedLeaveType);
                              ApplyLeveApplicationModel
                                  addLeaveAppplicationDetails =
                                  ApplyLeveApplicationModel(
                                      id: _applyleaveDateController.text.trim(),
                                      applyLeaveDate:
                                          _applyleaveDateController.text.trim(),
                                      leaveResontype:
                                          _selectedLeaveType.toString(),
                                      leaveFromDate:
                                          _applyFromDateController.text.trim(),
                                      leaveToDate:
                                          _applyTODateController.text.trim(),
                                      leaveReason:
                                          _leaveReasonController.text.trim(),
                                      studentName: studentController.studentName.value,
                                      studentParent: widget.guardianName);
                              ApplyLeaveLetterStatusToFireBase()
                                  .applyLeaveLetterController(
                                      addLeaveAppplicationDetails,
                                      context,
                                      widget.schoolId,
                                      widget.classID,
                                      widget.studentID,
                                      _applyleaveDateController.text.trim(),
                                      widget.studentName,
                                      widget.batchId);
                            },
                            child: ButtonContainerWidget(
                              curving: 20,
                              colorindex: 2,
                              height: 60,
                              width: 300,
                              child: Center(
                                child: Text(
                                  "Apply Leave",
                                  style: GoogleFonts.montserrat(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                          ),
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
    });
  }
}
