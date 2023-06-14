





  import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../widgets/drop_down/select_school_level_exam.dart';
import '../../../widgets/textformfield.dart';
import '../../constant/sizes/constant.dart';
import '../../widgets/fonts/google_poppins.dart';

class ExamResultsView extends StatefulWidget {
    const ExamResultsView({super.key});

    @override
    State<ExamResultsView> createState() => _ExamResultsViewState();
  }

  class _ExamResultsViewState extends State<ExamResultsView> {
    String? _selectedExams;
    String? _selectedDate;
    String? _selectedRollno;

    List<TextEditingController> controllersList =
        List.generate(8, (index) => TextEditingController());

    final List<String> exams = [
      'English Exam',
      'Chemistry Exam',
      'Physics Exam',
      'Biology Exam',
    ];

    final List<String> date = [
      'March 21',
      'April 20',
      'June 16',
      'May 01',
    ];

    final List<String> rollno = [
      'Roll No 1',
      'Roll No 2',
      'Roll No 3',
    ];

    TextEditingController periodController = TextEditingController();

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: const Color.fromARGB(255, 239, 239, 239),
        appBar: AppBar(
            centerTitle: true,
            title: GooglePoppinsWidgets(
                text: 'Upload Exam Result',
                fontsize: 16.w,
                fontWeight: FontWeight.w500),
            backgroundColor: adminePrimayColor),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 60.h,
                width: 320.w,
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.all(Radius.circular(5.w))),
                child: Center(
                  child:GetSchoolLevelExamDropDownButton(
                    examType: 'Public Level',
                  ),
                ),
              ),

              Container(
                height: 50.h,
                width: 320.w,
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.all(Radius.circular(5.w))),
                child: Center(
                  child: DropdownButton(
                    hint: GooglePoppinsWidgets(
                        text: 'Roll No',
                        fontsize: 15.w,
                        fontWeight: FontWeight.w500),
                    value: _selectedRollno,
                    onChanged: (RollNo) {
                      setState(() {
                        _selectedRollno = RollNo;
                      });
                      print('Selected Roll No: $_selectedRollno');
                    },
                    items: rollno.map((RollNo) {
                      return DropdownMenuItem(
                          value: RollNo,
                          child: Container(
                              height: 150.h,
                              width: 250.w,
                              decoration: BoxDecoration(
                                  // border: Border.all(),

                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.w))),
                              child: Center(
                                child: GooglePoppinsWidgets(
                                    text: RollNo, fontsize: 15.w),
                              )));
                    }).toList(),
                  ),
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(left: 30.w,right: 30.w,top: 20.h),
                child: TextFormFieldWidget(
                  labelText: "Student Name",
                function: checkFieldEmpty,
                //textEditingController: ,
                ),
              ),

                Padding(
                  padding:  EdgeInsets.only(left: 30.w,right: 30.w,top: 20.h),
                  child: TextFormFieldWidget(
                labelText: "Obtained Mark",
                            function: checkFieldEmpty,
                            //textEditingController: ,
                            ),
                ),
                Padding(
                  padding:  EdgeInsets.only(left: 30.w,right: 30.w,top: 20.h),
                  child: TextFormFieldWidget(
                // hintText: "Obtained Grade",
                  labelText: 'Obtained Grade',
                            function: checkFieldEmpty,
                            //textEditingController: ,
                            ),
                ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MaterialButton(
                  onPressed: () {
                  
                },
                color: cred,
                child: 
                GooglePoppinsWidgets(
                  text: 'Upload Sheet', fontsize: 15.w,color: cWhite),),
              ),
            GestureDetector(
              onTap: () {
                
              },
              child: SubmitButtonWidget(text: 'Submit',))
            ],
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
        color: cblue,
        borderRadius: BorderRadius.all(
          Radius.circular(8.w))),
      child: 
      Center(
        child: GooglePoppinsWidgets(
          text: text, fontsize: 15.w,color: cWhite,fontWeight:  FontWeight.w600),
      ),
      );
    }
  }
