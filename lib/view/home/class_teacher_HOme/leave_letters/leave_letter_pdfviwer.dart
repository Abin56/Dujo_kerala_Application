import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class LeaveLettersScreen extends StatefulWidget {
  String schoolplaceName;
  String schoolName;
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
      required this.schoolplaceName,
      required this.schoolName,
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

    if (mounted) {
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
    nextpage().then((value) async{
      await Future.delayed(const Duration(seconds: 1));
      Get.back();
    });

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
            child: const Center(
              child:CircularProgressIndicator.adaptive()
            ),
          )
        ],
      )),
    );
    
  }

  Future<void>nextpage() async {
    await Future.delayed(const Duration(seconds: 1));
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
          return 
          pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
              crossAxisAlignment: pw.CrossAxisAlignment.center,
                  children: [
                       pw.Text(
                  'Leave Letter',
                  style:  pw.TextStyle(fontSize: 17,fontWeight: pw.FontWeight.bold),
                ),
                 pw.SizedBox(height: 50),
                   ]),
                pw.Text(
                  'To',
                  style: const pw.TextStyle(fontSize: 16),
                ),
              pw.SizedBox(height: 5),
                pw.Text(
                  'The Teacher',
                  style: const pw.TextStyle(fontSize: 16),
                ),
              pw.SizedBox(height: 5),
                pw.Text(
                  widget.schoolName,
                  style: const pw.TextStyle(fontSize: 16),
                ),
               
                 pw.SizedBox(height: 20),
               
                pw.Text(
                  'Subject: Application For Leave',
                  style: const pw.TextStyle(fontSize: 16),
                ),
                 pw.SizedBox(height: 5),
               
                pw.Text(
                  'Leave Type : ${widget.leaveResontype}',
                  style: const pw.TextStyle(fontSize: 16),
                ),
                 pw.SizedBox(height: 20),
                pw.Row(
                  children: [
                    pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            'Respected Sir,',
                            style: const pw.TextStyle(fontSize: 16),
                          ),
                         pw.SizedBox(height: 15),
                         pw.Text(
                              "I would like to inform you that due to ${widget.leaveReason}",
                              style: const pw.TextStyle(fontSize: 16)), 
                          
                               pw.SizedBox(height: 5),
                              
                          pw.Text(
                              "my child ${widget.studentName} would not be able to attend the classes ",
                              style: const pw.TextStyle(fontSize: 16)),
                               pw.SizedBox(height: 5),
                                       pw.Text(
                              'from ${widget.leaveFromDate} to ${widget.leaveToDate}. Therefore,I humbly request',
                              style: const pw.TextStyle(fontSize: 16)),
                               pw.SizedBox(height: 5),
                               pw.Text('you to grant leave.',
                              style: const pw.TextStyle(fontSize: 16)),
                          pw.SizedBox(height: 20),
                          pw.Text('Thanking You,',
                              style: const pw.TextStyle(fontSize: 16)),
                          pw.SizedBox(height: 5),
                          pw.Text('Yours sincerely,',
                              style: const pw.TextStyle(fontSize: 16)),
                           pw.SizedBox(height: 5),
                          pw.Text(widget.studentParent,
                              style: const pw.TextStyle(
                                   fontSize: 16)),
                                   pw.SizedBox(height: 5),
                          pw.Text('Date: ${widget.applyLeaveDate}',
                              style: const pw.TextStyle(
                                   fontSize: 16)),
                          
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
//       );