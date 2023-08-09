import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/controllers/add_exam_time_table/add_exam_time_table.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:dujo_kerala_application/model/exam_list_model/exam_list.model.dart';
import 'package:dujo_kerala_application/utils/utils.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/constant/sizes/constant.dart';
import 'package:dujo_kerala_application/view/constant/sizes/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../widgets/drop_down/all_subject_drop_down.dart';
import '../../../widgets/fonts/google_poppins.dart';

class ViewSchoolExamScreen extends StatelessWidget {
  const ViewSchoolExamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: adminePrimayColor,
          title: Text("Exam Time Table".tr),
          bottom: TabBar(tabs: [
            Tab(
              text: 'School Level'.tr,
            ),
            Tab(
              text: 'Public Level'.tr,
            ),
          ]),
        ),
        body: const SafeArea(
          child: TabBarView(
            children: [TPublicLevel(), TStateLevel()],
          ),
        ),
      ),
    );
  }
}

class TPublicLevel extends StatefulWidget {
  const TPublicLevel({super.key});

  @override
  State<TPublicLevel> createState() => _TPublicLevelState();
}

class _TPublicLevelState extends State<TPublicLevel> {
  AddExamTimeTableController addExamTimeTableController =
      Get.put(AddExamTimeTableController());

  final TextEditingController _timeController = TextEditingController();

  final TextEditingController _stimeController = TextEditingController();

  TextEditingController applynewBatchYearContoller = TextEditingController();

  DateTime? _selectedDateForApplyDate;

  TimeOfDay? time1;

  TimeOfDay? time2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('SchoolListCollection')
                .doc(UserCredentialsController.schoolId)
                .collection(UserCredentialsController.batchId!)
                .doc(UserCredentialsController.batchId!)
                .collection('School Level')
                .snapshots(),
            builder: (context, snaps) {
              if (snaps.hasData) {
                if (snaps.data!.docs.isEmpty) {
                  return Center(
                    child: GooglePoppinsWidgets(
                        text: 'No Records Found'.tr, fontsize: 20),
                  );
                } else {
                  return ListView.separated(
                      itemBuilder: (context, index) {
                        final data = AddExamModel.fromMap(
                            snaps.data!.docs[index].data());
                        return GestureDetector(
                          onTap: () {
                            _addSubjectsToServer(context, data.docid);
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                                top: 10.h, left: 10.h, right: 10.h),
                            height: 120.h,
                            width: 80.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.h),
                              color: adminePrimayColor,
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(top: 20.h, left: 20.w),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GooglePoppinsWidgets(
                                      text: "Exam Name  :   ${data.examName}",
                                      fontsize: 16.h,
                                      color: cWhite),
                                  SizedBox(
                                    height: 5.w,
                                  ),
                                  GooglePoppinsWidgets(
                                    text:
                                        "Published date :  ${stringTimeToDateConvert(data.publishDate)}",
                                    fontsize: 14.h,
                                    color: cWhite,
                                  ),
                                  SizedBox(
                                    height: 7.w,
                                  ),
                                  GooglePoppinsWidgets(
                                      text:
                                          "Starting date :  ${data.startingDate}",
                                      fontsize: 12.h,
                                      color: cWhite),
                                  GooglePoppinsWidgets(
                                      text: "Ending date :  ${data.endDate}",
                                      fontsize: 12.h,
                                      color: cWhite),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 10.h,
                        );
                      },
                      itemCount: snaps.data!.docs.length);
                }
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }

  final _formKey = GlobalKey<FormState>();
  _addSubjectsToServer(BuildContext context, String examdocID) async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: GooglePoppinsWidgets(
              text: 'Add Subject to Time Table'.tr, fontsize: 14.w),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: ListBody(
                children: <Widget>[
                  GetAllSubjectListDropDownButton(
                      batchId: UserCredentialsController.batchId!,
                      classId: UserCredentialsController.classId!,
                      schoolID: UserCredentialsController.schoolId!),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // GooglePoppinsWidgets(
                      //   fontsize: 12,
                      //   fontWeight: FontWeight.w300,

                      //   text: 'Starting Time : ',
                      // ),
                      SizedBox(
                        height: 70.w,
                        width: 200.w,
                        child: Center(
                            child: TextFormField(
                          validator: (value) {
                            if (_timeController.text.isEmpty) {
                              return "Please select Time";
                            } else {
                              return null;
                            }
                          },
                          controller: _timeController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.w))),
                            labelText: 'Starting Time  '.tr,
                          ),
                          onTap: () => selectTime(context),
                          readOnly: true,
                        )),
                      ),
                      IconButton(
                          onPressed: () {
                            selectTime(context);
                          },
                          icon: const Icon(Icons.timer))
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // GooglePoppinsWidgets(
                      //   fontsize: 12,
                      //   fontWeight: FontWeight.w300,
                      //   text: 'End Time       : ',
                      // ),
                      kHeight10,
                      SizedBox(
                        height: 70.w,
                        width: 200.w,
                        child: Center(
                            child: TextFormField(
                          validator: (value) {
                            if (_stimeController.text.isEmpty) {
                              return "Please select Time ";
                            } else {
                              return null;
                            }
                          },
                          controller: _stimeController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.w))),
                              labelText: 'EndTime'.tr),
                          onTap: () => selectTimesec(context),
                          readOnly: true,
                        )),
                      ),
                      IconButton(
                          onPressed: () {
                            selectTimesec(context);
                          },
                          icon: const Icon(Icons.timer))
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (applynewBatchYearContoller.text.isEmpty) {
                        return 'Invalid';
                      } else {
                        return null;
                      }
                    },
                    controller: applynewBatchYearContoller,
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
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'.tr),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Add'.tr),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  addExamTimeTableController
                      .uploadSubject(
                          'School Level',
                          examdocID,
                          allsubjectListValue!['subjectName'],
                          time1!,
                          time2!,
                          applynewBatchYearContoller.text.trim(),
                          _timeController.text.trim(),
                          _stimeController.text.trim(),
                          context)
                      .then((value) {
                    _timeController.clear();
                    _stimeController.clear();
                    applynewBatchYearContoller.clear();
                    showToast(msg: 'Successfully Added');
                  });
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime != null) {
      final String formattedTime = selectedTime.format(context);

      _timeController.text = formattedTime;
      setState(() {
        time1 = selectedTime;
      });
    }
  }

  Future<void> selectTimesec(BuildContext context) async {
    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime != null) {
      final String formattedTime = selectedTime.format(context);
      _stimeController.text = formattedTime;
      setState(() {
        time2 = selectedTime;
      });
    }
  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDateForApplyDate ?? DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDateForApplyDate) {
      _selectedDateForApplyDate = picked;
      DateTime parseDate = DateTime.parse(_selectedDateForApplyDate.toString());
      final DateFormat formatter = DateFormat('dd-MM-yyyy');
      String formatted = formatter.format(parseDate);

      applynewBatchYearContoller.text = formatted.toString();
    }
  }
}

const containerColor = [
  Colors.blue,
  Colors.green,
  Colors.yellow,
  Colors.orange,
  Colors.pink,
  Colors.purple,
  Colors.grey,
  Colors.black
];

class TStateLevel extends StatefulWidget {
  const TStateLevel({super.key});

  @override
  State<TStateLevel> createState() => _TStateLevelState();
}

class _TStateLevelState extends State<TStateLevel> {
  TimeOfDay? time1;
  TimeOfDay? time2;
  AddExamTimeTableController addExamTimeTableController =
      Get.put(AddExamTimeTableController());

  final TextEditingController _timeController = TextEditingController();

  final TextEditingController _stimeController = TextEditingController();

  TextEditingController applynewBatchYearContoller = TextEditingController();

  DateTime? _selectedDateForApplyDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('SchoolListCollection')
                .doc(UserCredentialsController.schoolId)
                .collection(UserCredentialsController.batchId!)
                .doc(UserCredentialsController.batchId!)
                .collection('Public Level')
                .snapshots(),
            builder: (context, snaps) {
              if (snaps.hasData) {
                if (snaps.data!.docs.isEmpty) {
                  return Center(
                    child: GooglePoppinsWidgets(
                        text: 'No Records Found'.tr, fontsize: 20),
                  );
                } else {
                  return ListView.separated(
                      itemBuilder: (context, index) {
                        final data = AddExamModel.fromMap(
                            snaps.data!.docs[index].data());
                        return GestureDetector(
                          onTap: () async {
                            _addSubjectsToServer(context, data.docid);
                          },
                          child: Padding(
                            padding: EdgeInsets.only(left: 10.h, right: 10.h),
                            child: Container(
                              margin: EdgeInsets.only(
                                  top: 10.h, left: 10.h, right: 10.h),
                              height: 140.h,
                              width: 80.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.h),
                                color: adminePrimayColor,
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(top: 20.h, left: 20.w),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GooglePoppinsWidgets(
                                        text: "Exam Name  :   ${data.examName}",
                                        fontsize: 16.h,
                                        color: cWhite),
                                    SizedBox(
                                      height: 5.w,
                                    ),
                                    GooglePoppinsWidgets(
                                      text:
                                          "Published date :  ${stringTimeToDateConvert(data.publishDate)}",
                                      fontsize: 14.h,
                                      color: cWhite,
                                    ),
                                    SizedBox(
                                      height: 10.w,
                                    ),
                                    GooglePoppinsWidgets(
                                        text:
                                            "Starting date :  ${data.startingDate}",
                                        fontsize: 12.h,
                                        color: cWhite),
                                    GooglePoppinsWidgets(
                                        text: "Ending date :  ${data.endDate}",
                                        fontsize: 12.h,
                                        color: cWhite),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 10.h,
                        );
                      },
                      itemCount: snaps.data!.docs.length);
                }
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }

  final _formKey = GlobalKey<FormState>();

  _addSubjectsToServer(BuildContext context, String examdocID) async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Subject to Time Table'.tr),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: ListBody(
                children: <Widget>[
                  GetAllSubjectListDropDownButton(
                      batchId: UserCredentialsController.batchId!,
                      classId: UserCredentialsController.classId!,
                      schoolID: UserCredentialsController.schoolId!),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // GooglePoppinsWidgets(
                      //   fontsize: 12,
                      //   fontWeight: FontWeight.w300,
                      //   text: 'Starting Time : ',
                      // ),
                      SizedBox(
                        height: 50.h,
                        width: 200.w,
                        child: Center(
                            child: TextFormField(
                          validator: (value) {
                            if (_timeController.text.isEmpty) {
                              return "Please select Time";
                            } else {
                              return null;
                            }
                          },
                          controller: _timeController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.w))),
                            labelText: 'Starting Time'.tr,
                          ),
                          onTap: () => selectTime(context),
                          readOnly: true,
                        )),
                      ),
                      IconButton(
                          onPressed: () {
                            selectTime(context);
                          },
                          icon: const Icon(Icons.timer))
                    ],
                  ),
                  kHeight10,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 50.h,
                        width: 200.w,
                        child: Center(
                            child: TextFormField(
                          validator: (value) {
                            if (_stimeController.text.isEmpty) {
                              return "Please select Time";
                            } else {
                              return null;
                            }
                          },
                          controller: _stimeController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.w))),
                            labelText: 'End Time'.tr,
                          ),
                          readOnly: true,
                          onTap: () => selectTimesec(context),
                        )),
                      ),
                      IconButton(
                          onPressed: () {
                            selectTimesec(context);
                          },
                          icon: const Icon(Icons.timer))
                    ],
                  ),
                  kHeight10,
                  TextFormField(
                    validator: (value) {
                      if (applynewBatchYearContoller.text.isEmpty) {
                        return 'Invalid';
                      } else {
                        return null;
                      }
                    },
                    controller: applynewBatchYearContoller,
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
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'.tr),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
                child: Text('Add'.tr),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    addExamTimeTableController
                        .uploadSubject(
                            'Public Level',
                            examdocID,
                            allsubjectListValue!['subjectName'],
                            time1!,
                            time2!,
                            applynewBatchYearContoller.text.trim(),
                            _timeController.text.trim(),
                            _stimeController.text.trim(),
                            context)
                        .then((value) async {
                      applynewBatchYearContoller.clear();
                      _timeController.clear();
                      _stimeController.clear();
                      showToast(msg: 'Successfully Added');
                    });
                  }
                })
          ],
        );
      },
    );
  }

  Future<void> selectTime(BuildContext context) async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime != null) {
      final String formattedTime = selectedTime.format(context);
      _timeController.text = formattedTime;
      setState(() {
        time1 = selectedTime;
      });
    }
  }

  Future<void> selectTimesec(BuildContext context) async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime != null) {
      final String formattedTime = selectedTime.format(context);
      _stimeController.text = formattedTime;
      setState(() {
        time2 = selectedTime;
      });
    }
  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDateForApplyDate ?? DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDateForApplyDate) {
      _selectedDateForApplyDate = picked;
      DateTime parseDate = DateTime.parse(_selectedDateForApplyDate.toString());
      final DateFormat formatter = DateFormat('dd-MM-yyyy');
      String formatted = formatter.format(parseDate);

      applynewBatchYearContoller.text = formatted.toString();
    }
  }
}
