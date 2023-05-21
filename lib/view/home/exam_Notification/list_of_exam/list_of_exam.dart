import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/controllers/add_exam_time_table/add_exam_time_table.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:dujo_kerala_application/model/exam_list_model/exam_list.model.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../widgets/drop_down/subject_dropdown.dart';
import '../../../widgets/fonts/google_poppins.dart';

class ViewSchoolExamScreen extends StatelessWidget {
  const ViewSchoolExamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: adminePrimayColor,
          bottom: const TabBar(tabs: [
            Tab(
              text: 'Public Level',
            ),
            Tab(
              text: 'State Level',
            )
          ]),
        ),
        body: SafeArea(
          child: TabBarView(
            children: [TPublicLevel(), const TStateLevel()],
          ),
        ),
      ),
    );
  }
}

class TPublicLevel extends StatelessWidget {
  AddExamTimeTableController addExamTimeTableController =
      Get.put(AddExamTimeTableController());
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _stimeController = TextEditingController();
  TextEditingController applynewBatchYearContoller = TextEditingController();
  DateTime? _selectedDateForApplyDate;
  TPublicLevel({super.key});

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
                        text: 'No Records Found', fontsize: 20),
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
                          child: SizedBox(
                            height: 100,
                            child: Text(data.examName),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider();
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

  _addSubjectsToServer(BuildContext context, String examdocID) async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Subject to TimeTable'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GetSubjectListDropDownButton(
                    batchId: UserCredentialsController.batchId!,
                    classId: UserCredentialsController.classId!,
                    schoolID: UserCredentialsController.schoolId!),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GooglePoppinsWidgets(
                      fontsize: 12,
                      fontWeight: FontWeight.w300,
                      text: 'Starting Time : ',
                    ),
                    SizedBox(
                      height: 50,
                      width: 150,
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
                        decoration: const InputDecoration(
                          hintText: '  Selected Time',
                        ),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GooglePoppinsWidgets(
                      fontsize: 12,
                      fontWeight: FontWeight.w300,
                      text: 'End Time : ',
                    ),
                    SizedBox(
                      height: 50,
                      width: 150,
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
                        decoration: const InputDecoration(
                          hintText: '  Selected Time',
                        ),
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
          actions: <Widget>[
            TextButton(
              child: const Text('cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                // addExamTimeTableController.uploadSubject(
                //     'Public Level',
                //     examdocID,
                //     subjectListValue!['subjectName'],
                //     _timeController.text.trim(),
                //     _stimeController.text.trim(),
                //     applynewBatchYearContoller.text.trim());
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
                .collection('State Level')
                .snapshots(),
            builder: (context, snaps) {
              if (snaps.hasData) {
                if (snaps.data!.docs.isEmpty) {
                  return Center(
                    child: GooglePoppinsWidgets(
                        text: 'No Records Found', fontsize: 20),
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
                          child: SizedBox(
                            height: 100,
                            child: Text(data.examName),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider();
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

  _addSubjectsToServer(BuildContext context, String examdocID) async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Subject to TimeTable'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GetSubjectListDropDownButton(
                    batchId: UserCredentialsController.batchId!,
                    classId: UserCredentialsController.classId!,
                    schoolID: UserCredentialsController.schoolId!),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GooglePoppinsWidgets(
                      fontsize: 12,
                      fontWeight: FontWeight.w300,
                      text: 'Starting Time : ',
                    ),
                    SizedBox(
                      height: 50,
                      width: 150,
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
                        decoration: const InputDecoration(
                          hintText: '  Selected Time',
                        ),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GooglePoppinsWidgets(
                      fontsize: 12,
                      fontWeight: FontWeight.w300,
                      text: 'End Time : ',
                    ),
                    SizedBox(
                      height: 50,
                      width: 150,
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
                        decoration: const InputDecoration(
                          hintText: '  Selected Time',
                        ),
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
          actions: <Widget>[
            TextButton(
              child: const Text('cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                addExamTimeTableController.uploadSubject(
                    'State Level',
                    examdocID,
                    subjectListValue!['subjectName'],
                    time1!,
                    time2!,
                    applynewBatchYearContoller.text.trim());
              },
            ),
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
      time1=  selectedTime ;
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
        time2 =selectedTime ;
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
