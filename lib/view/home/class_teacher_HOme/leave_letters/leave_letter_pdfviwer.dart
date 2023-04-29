import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class LeaveLettersScreen extends StatefulWidget {
  String id;
  String applyLeaveDate;
  String leaveResontype;
  String leaveFromDate;
  String leaveToDate;
  String leaveReason;
  String studentName;
  String studentParent;

  LeaveLettersScreen(
      {required this.id,
      required this.applyLeaveDate,
      required this.leaveResontype,
      required this.leaveFromDate,
      required this.leaveToDate,
      required this.leaveReason,
      required this.studentName,
      required this.studentParent,
      super.key});

  @override
  State<LeaveLettersScreen> createState() => _LeaveLettersScreenState();
}

class _LeaveLettersScreenState extends State<LeaveLettersScreen> {
  // late final dref = FirebaseDatabase.instance.ref();
  // late DatabaseReference databaseReference;

  String listID = '';

  String dateText = "";
  int deliveryCharge = 50;

  String formatCurrentDate(DateTime date) {
    return DateFormat("dd MMMM, yyyy").format(date);
  }

  getCurrentLiveTime() {
    final DateTime timeNow = DateTime.now();
    final String liveDate = formatCurrentDate(timeNow);

    if (this.mounted) {
      setState(() {
        dateText = liveDate;
      });
    }
  }

  creatNewMeeting() async {
    var random = Random();
    String roomName = (random.nextInt(1000000) + 1000000).toString();
    listID = roomName;
  }

  @override
  void initState() {
    // getInvoice();
    // databaseReference = dref.child("course");
    // _counter();
    nextpage();

    creatNewMeeting();
    getCurrentLiveTime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: () async {
              Printing.layoutPdf(
                onLayout: (PdfPageFormat format) {
                  return buildPdf(format);
                },
              );
              // await nextpage();
            },
            child: Center(
              child:CircularProgressIndicator.adaptive()
            ),
          )
        ],
      )),
    );
    
  }

  nextpage() async {
    await Future.delayed(Duration(seconds: 1));
    Printing.layoutPdf(
                onLayout: (PdfPageFormat format) {
                  return buildPdf(format);
                },
              );
  }

  /// This method takes a page format and generates the Pdf file data
  Future<Uint8List> buildPdf(PdfPageFormat format) async {
    // double totalprice = widget.price + gst + sgst + deliveryCharge;
    // Create the Pdf document
    final pw.Document doc = pw.Document();

    // Add one page with centered text "Hello World"
    doc.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.start,
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'To',
                style: pw.TextStyle(fontSize: 16),
              ),
              pw.Text(
                'The Teacher/Pricipal',
                style: pw.TextStyle(fontSize: 16),
              ),
              pw.Text(
                'Marthoma Higher Secondary School',
                style: pw.TextStyle(fontSize: 16),
              ),
              pw.Text(
                'Venmoney',
                style: pw.TextStyle(fontSize: 16),
              ),
              pw.SizedBox(height: 05),
              pw.Text(
                'Subject : Leave Applicaton',
                style: pw.TextStyle(fontSize: 16),
              ),
              pw.SizedBox(height: 20),
              pw.Text(
                'Dear Mr./Mrs  AbinJohn',
                style: pw.TextStyle(fontSize: 16),
              ),
              pw.SizedBox(height: 20),
              pw.Row(
                children: [
                  pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          'With due respect, I would like to inform you that',
                          style: pw.TextStyle(fontSize: 15),
                        ),
                        pw.Text('Due to ', style: pw.TextStyle(fontSize: 16)),
                        pw.Text(
                            '   Therefore, I request you to please consider our situation and grant me a total of \n  Day days leave from Date to Date. I am enclosing ___ your reference  ',
                            style: pw.TextStyle(fontSize: 16)),
                        pw.Text(
                            'If you have any questions, please feel free to contact me directly. Looking forward to your replay. ',
                            style: pw.TextStyle(fontSize: 16)),
                        pw.SizedBox(height: 10),
                        pw.Text('Thank you ',
                            style: pw.TextStyle(fontSize: 16)),
                        pw.SizedBox(height: 20),
                        pw.Text('Yours sincerely ',
                            style: pw.TextStyle(fontSize: 16)),
                        pw.SizedBox(height: 10),
                        pw.Text('ParenntNAme ',
                            style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold, fontSize: 16)),
                        pw.SizedBox(height: 10),
                        pw.Text('Date ', style: pw.TextStyle(fontSize: 16)),
                        pw.SizedBox(height: 05),
                        pw.Text('Place', style: pw.TextStyle(fontSize: 16)),
                      ])
                ],
              ),
            ],
          );
          //  pw.Expanded(child: Container(child: ,))
        },
      ),
    );

    // Build and return the final Pdf file data
    return await doc.save();
  }
}

    //  return pw.Column(
    //         children: [
    //           pw.Column(
    //             children: [


    //               pw.SizedBox(height: 40),


    //           pw.SizedBox(height: 40),
    //           pw.Column(
    //             children: [
    //               pw.Divider(),

    //                     ],
    //                   ),
    //                 ),
    //               ),
                  
    //             ],
    //           )
    //         ],
    //       );